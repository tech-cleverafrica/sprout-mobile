package com.example.clevermobile

import com.danbamitale.epmslib.entities.KeyHolder
import com.google.gson.Gson
import com.pixplicity.easyprefs.library.Prefs

object AppUtil {
    const val KEY_HOLDER = "KEY_HOLDER"
    const val CONFIG_DATA = "CONFIG_DATA"
    const val PARTNET_ID = "5de231d9-1be0-4c31-8658-6e15892f2b83"
    const val PARTNER_NAME = "Clevermoni"
    const val TERMINAL_SERIAL_ID = "1142016190000472"

    fun getSavedKeyHolder(): KeyHolder? {
        val savedKeyHolderInStringFormat = Prefs.getString(KEY_HOLDER)
        return Gson().fromJson(savedKeyHolderInStringFormat, KeyHolder::class.java)
    }
}