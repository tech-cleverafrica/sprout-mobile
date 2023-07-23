package com.clever.sprout

import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.netpluspay.contactless.sdk.start.ContactlessSdk
import com.netpluspay.contactless.sdk.utils.ContactlessReaderResult
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import android.app.ProgressDialog
import android.os.Bundle
import com.danbamitale.epmslib.entities.CardData
import com.danbamitale.epmslib.entities.TransactionType
import com.google.gson.Gson
import com.netpluspay.nibssclient.models.IsoAccountType
import com.netpluspay.nibssclient.models.MakePaymentParams
import com.netpluspay.nibssclient.models.UserData
import com.netpluspay.nibssclient.service.NetposPaymentClient
import com.pixplicity.easyprefs.library.Prefs
import com.woleapp.netposcontactlesssampleprojectkotlin.CardReadResult
import com.woleapp.netposcontactlesssampleprojectkotlin.ContactlessData
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import timber.log.Timber
import android.widget.Toast
import com.danbamitale.epmslib.entities.clearPinKey
import com.example.clevermobile.AppUtil.CONFIG_DATA
import com.example.clevermobile.AppUtil.KEY_HOLDER
import com.example.clevermobile.AppUtil.PARTNER_NAME
import com.example.clevermobile.AppUtil.PARTNET_ID
import com.example.clevermobile.AppUtil.TERMINAL_SERIAL_ID
import com.example.clevermobile.AppUtil.getSavedKeyHolder

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "flutter.native/helper"
    private lateinit var _result: MethodChannel.Result

    // Payment library variables and initializations
    private var STRING_REMARK = ""
    private val disposable: CompositeDisposable = CompositeDisposable()
    private val netposPaymentClient = NetposPaymentClient
    private var amountToPay = 0L
    private val compositeDisposable = CompositeDisposable()
    private val gson = Gson()
    private var _terminalId = ""

    // Result from reading the card, this contains the emv data of the card
    private var userData: UserData? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Prefs.Builder().setContext(this).build();
    }

    private fun setUserData(call: MethodCall, result: MethodChannel.Result) {
        var terminalId = call.argument<String>("terminalId")
        var businessName = call.argument<String>("businessName")
        var businessAddress = call.argument<String>("businessAddress")
        var customerName = call.argument<String>("customerName")
        if(terminalId != null && businessName != null && businessAddress != null && customerName != null) {
            _result = result
            userData = UserData(
                businessName,
                PARTNER_NAME,
                PARTNET_ID,
                terminalId,
                TERMINAL_SERIAL_ID,
                businessAddress,
                customerName
            )
            netposPaymentClient.logUser(this, gson.toJson(userData))
            configureTerminal()
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine) //missing this
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result -> 
            when {
                call.method.equals("virtualPOS") -> {
                    virtualPOS(call, result);
                }
            }
            when {
                call.method.equals("setUserData") -> {
                    setUserData(call, result);
                }
            }
        }
    }

    private fun virtualPOS(call: MethodCall, result: MethodChannel.Result) {
        var amount = call.argument<String>("amount")
        var terminalId = call.argument<String>("terminalId")
        var remark = call.argument<String>("remark")
        if(amount != null && terminalId != null && remark != null) {
            amountToPay = amount.toString().trim().toLong()
            _result = result
            _terminalId = terminalId
            STRING_REMARK = remark;
            getSavedKeyHolder()?.let {
                ContactlessSdk.readContactlessCard(this,
                    100, // requestCode
                    it.clearPinKey, //pinKey
                    amountToPay.toDouble(), // amount
                    0.0 //cashbackAmount(optional)
                )
            } ?: run {
                Toast.makeText(this@MainActivity, "Terminal has not been configured", Toast.LENGTH_LONG).show()
                configureTerminal()
            }
        }
    }

    private fun configureTerminal() {
        compositeDisposable.add(
            netposPaymentClient.init(this, false, Gson().toJson(userData))
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe { data, error ->
                    data?.let { response ->
                        _result.success(getString(R.string.terminal_configured))
                        val keyHolder = response.first
                        val configData = response.second
                        val pinKey = keyHolder?.clearPinKey
                        if (pinKey != null) {
                            Prefs.putString(KEY_HOLDER, gson.toJson(keyHolder))
                            Prefs.putString(CONFIG_DATA, gson.toJson(configData))
                        }
                    }
                    error?.let {
                        _result.error("Terminal Configuration Failed", getString(R.string.terminal_config_failed), "")
                        Timber.d("%s%s", "ERROR_TAG", it.localizedMessage)
                    }
                }
        )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == ContactlessReaderResult.RESULT_OK) {
            data?.let { i ->
                Log.e("tag", "value: ${i.getStringExtra("data")}")
//                _result.success(i.getStringExtra("data"))
                val contactlessData =
                    Gson().fromJson(i.getStringExtra("data"), ContactlessData::class.java)
                makePayment(contactlessData.cardReadResult)
            }
        }
        if (resultCode == ContactlessReaderResult.RESULT_ERROR) {
            data?.let { i ->
                Log.e("tag", "value: ${i.getStringExtra("message")}")
//                _result.success(i.getStringExtra("message"))
                Timber.e("value: ${i.getStringExtra("message")}")
            }
        }
    }

    private fun makePayment(cardReadResult: CardReadResult?) {
        val progressDialog: ProgressDialog = ProgressDialog(this)
        progressDialog.setMessage("Please Wait...")
        progressDialog.setCancelable(false)
        if (cardReadResult != null) {
            val cardData = cardReadResult.track2Data.let {
                CardData(
                    it,
                    cardReadResult.iccString,
                    cardReadResult.applicationPanSequenceNumber,
                    "051"
                )
            }
            cardData.pinBlock = cardReadResult.pinBlock
            val makePaymentParams = cardData.let {
                MakePaymentParams(
                    "makePayment",
                    _terminalId,
                    amountToPay,
                    0,
                    TransactionType.PURCHASE,
                    IsoAccountType.DEFAULT_UNSPECIFIED,
                    it,
                    STRING_REMARK
                )
            }
            makePaymentParams.cardData = cardData
            "".let {
                "CUSTOMER".let { it1 ->
                    netposPaymentClient.makePayment(
                        this,
                        _terminalId,
                        Gson().toJson(makePaymentParams),
                        it,
                        it1,
                        STRING_REMARK
                    ).subscribeOn(Schedulers.io())
                        .observeOn(AndroidSchedulers.mainThread())
                        .doOnSubscribe {
                            progressDialog.show()
                        }
                        .subscribe { t1, t2 ->
                            progressDialog.dismiss()
                            val alertDialog =
                                androidx.appcompat.app.AlertDialog.Builder(this@MainActivity)
                                    .setCancelable(false)
                                    .setPositiveButton("ok") { d, _ ->
                                        d.cancel()
                                    }
                            t1?.let {
                                Timber.d(
                                    "MAKE_PAYMENT_RESPONSE==>%s",
                                    gson.toJson(it)
                                )

                                if(it.responseCode == "00") {
                                    _result.success(gson.toJson(it))
                                } else {
                                    _result.error("Transaction Declined", "Response Code: ${it.responseCode}\nResponse Message: ${it.responseMessage}", "")
                                }
                            }

                            t2?.let {
                                Timber.d("ERROR==>%s", gson.toJson(it.localizedMessage))
                                _result.error("Transaction Failed", "Transaction could not be completed\n${it.message}", "")
                            }
                        }
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        disposable.clear()
    }
}
