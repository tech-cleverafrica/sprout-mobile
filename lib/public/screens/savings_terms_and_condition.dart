import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:get/get.dart';

class SavingsTermsAndCondition extends StatefulWidget {
  @override
  _SavingsTermsAndConditionState createState() =>
      _SavingsTermsAndConditionState();
}

class _SavingsTermsAndConditionState extends State<SavingsTermsAndCondition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Material(
        color: AppColors.transparent,
        child: Stack(alignment: Alignment.center, children: [
          ScaleTransition(
            scale: scaleAnimation,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.black : AppColors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: AppColors.transparent),
                              padding:
                                  EdgeInsets.only(right: 12, top: 6, bottom: 6),
                              child: Icon(
                                Icons.close,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Terms And Conditions – Clever Digital Limited",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Terms Of Use",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Introduction",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "Welcome to Clever. These terms and conditions of use constitute a legally binding agreement by and between you, whether personally or on behalf of an entity (“you”) and Clever Digital Limited doing business as Clever (“Clever”, “company”, we”, “us”, or “our”), concerning your access to and use of the Clever app our https://www.sproutapp.co website and as well as any media form, media channel, mobile web or mobile application (collectively “service”, “services”, “app”) whether as a guest or registered user. We are registered in Nigeria and have our registered office at 19 Ezekuse Close, Admiralty Road, Lekki Phase 1, Lagos, Nigeria.",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          height: 1.5,
                                        )),
                                  ],
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Text(
                                "You agree that by accessing our services, you have read, understood, and agreed to be bound by all these terms of service.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Text(
                                "If you do not agree with all of these terms of use, then you are prohibited from using the app and must discontinue use immediately.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Text(
                                "Supplemental terms and conditions or documents that may be posted on the app from time to time are hereby expressly incorporated herein by reference. We reserve the right, in our sole discretion, to make changes or modifications to these terms of service from time to time. we will alert you about any changes by updating the “last updated” date of these terms of service, and you waive any right to receive specific notice of each such change. Please ensure that you check the applicable terms every time you use our app so that you understand which terms apply.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Text(
                                "You will be subject to and will be deemed to have been made aware of and to have accepted, the changes in any revised terms of service by your continued use of the app after the date such revised terms of use are posted.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Text(
                                "The app is intended for users who are at least 18 years old, however, persons under the age of 18 are also permitted and eligible to use or register for the app but must strictly adhere to the terms of use.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Text(
                                "To use our services, you must: ",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      bulletPoints(
                                          "Be 18 and/or above as earlier mentioned. Users under 18 years of age must have permission from, and be directly supervised by, their parent or guardian to use the Clever app. ",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "Have an account with at least one of the financial institutions in Nigeria",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "Provide all the information required at sign-up such as full name, phone number, email address, and any other information that may be requested from time to time.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Terms Of Use",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "This platform's goal is to make finance easy for you. The funds you credit into your Clever account via your virtual account number, debit card, and USSD are used as triggered by you to invest in the savings categories you want to invest in. Upon maturity of the investment, your funds (principal and interest) are moved to your account for you to either reinvest, transfer to a bank account, or pay bills.",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          height: 1.5,
                                        )),
                                  ],
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Scope of Clever Savings Services",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "Clever is a digital bank for emerging businesses, providing a range of services designed to meet your financial needs. Our services include POS withdrawal, Funds Transfer, Receivables, and Bills Payment. In addition, we now offer savings options that allow you to earn interest on your funds, up to 12% per annum by debiting your Clever wallet or your card.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(15.h),
                              Text(
                                  "With locked savings, you can safely lock your funds for a specified period and earn interest. During the duration of the investment, you will not have access to the locked funds until the investment matures. Target savings allows you to save towards a goal by periodically topping up your investment wallet. If you choose to withdraw your funds from your target savings before the expiration of the investment period. You consent to lose all your accrued interest and be charged 1% off your savings principal amount.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(40.h),
                              Text(
                                "Data Protection",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "By opening this account, you agree that Clever should process your personal data to",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      bulletPoints(
                                          "Provide products and services to you in terms of this agreement and any other product services for which you may apply",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "Carry out market research and analysis to identify potential market opportunities and trends to enable us to serve you better.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "We shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us for any such loss or corruption of such data.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Users",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "A user is referred to as an individual who uses our mobile application for personal, business, evaluation, research, and (or) educational purposes. while a client is an individual or entity who signs up on Clever, therefore, allowing his/her finance to be managed by Clever, and who makes payment via the mobile application bound by the terms of use, and any additional terms by agreeing to these terms and conditions, you are to which you agree when you create and fund a savings plan make payment and withdrawal at any time.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(15.h),
                              Text("The following will not be allowed:",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(15.h),
                              Text(
                                  "Illegal or fraudulent activities/services. ",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      bulletPoints(
                                          "Use of personal information and details meant to purposely mislead, misrepresent and defraud other parties.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "Use of Clever and/or the app’s products for activities that are prohibited by any laws, regulations, and/or third parties' terms of service, as well as for any marketing activity that negatively affects the app’s relationship with users or partners.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "User Registration",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "Only registered users may be allowed to carry out activities on Clever. This registration is free. in registering for an account, you represent and warrant:",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      bulletPoints(
                                          "That you agree to provide us with accurate, complete, and updated information and must not create an account for fraudulent or misleading purposes. note that some of our services are only for fully registered users.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You are solely responsible for any activity on your account after registration and for maintaining the confidentiality and security of your password and transaction pin. you are responsible for all use of your account and password.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You will not access the Clever service through automated or non-human means whether through a bot, script, or otherwise;",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You will not use Clever service for any illegal or unauthorized purpose; and,",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "Your use of Clever service will not violate any applicable law or regulations.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "Users undertake to comply with Clever standards, which are a set of behavior rules and guidelines, applicable to Clever and the marketplace in addition to these terms of service, as updated from time to time.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(15.h),
                              Text(
                                  "You agree that we may access, store, process, and use any personal information and data that you provided at sign-up following the privacy policy and your choices/settings.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(40.h),
                              Text(
                                "Users Information",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "We collect users personal information such as full names, phone number, and email address to create a Clever profile for our users.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(40.h),
                              Text(
                                "Users Contact",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "Some of the services provided on the Clever app require users to get direct access to their contact list for success purchases of bills. Please note that the access to your contact list only gives Clever the right to buy utilities through the phone number of the selected contact.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(40.h),
                              Text(
                                "Users' Feedback",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "By submitting feedback about Clever services, you agree that we can use and share such feedback for any purpose without further permission and without compensation to you. You will retain the full ownership of your feedback and as such we are not liable for any statements or representation in your feedback provided by you in using Clever and you expressly agree to exonerate us from all responsibility and to refrain from any legal action against us regarding your feedback.",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(40.h),
                              Text(
                                "User Review Guidelines",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                  "Clever may provide areas on the site or third-party sites to leave reviews and ratings. when posting such reviews and ratings, you must adhere to the following guidelines:",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontFamily: "Mont",
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  )),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      bulletPoints(
                                          "You should have firsthand experience with Clever service being reviewed",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "Your review should not contain discriminatory references based on religion, race, gender, national origin, age, marital status, sexual orientation, or disability,",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "Your review should not contain a reference to illegal activity,",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You should not be affiliated with competitors while posting reviews,",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You will not post any false or misleading statements; and",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You will not organize a campaign encouraging others to post reviews, whether positive or negative.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You must provide accurate, current and complete information during the registration process a your Clever Account profile page information up-to-date at all times.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "You are responsible for safeguarding the password that you use to access the service and for any activities or actions under your password, whether your password is with our service or a third-party service.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Commission and Penalty Fee",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "You also consent to lose all your accrued interest and be charged 1% off your savings principal amount if you want to withdraw from your target savings.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Notification",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "By agreeing to these terms and conditions, you agree to be receiving text messages (SMS), push notifications, and emails from us.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Added Debit Cards",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "By consenting to this agreement, Clever reserves the right to debit your debit card in other to fund your savings as you have requested on your account. Note that Clever will not debit you without activating a target savings and without giving a debit command on your account.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Language And Communication",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "The official language of the Clever app is the English language. We can also communicate with emojis.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Third-Party Product And Services",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "Clever may provide third-party services using its app (third-party services). Clever disclaims all liability, including express or implied warranties, whether oral or written, for such third-party services. the user acknowledges that no representation has been made by Clever as to the fitness of the third-party services for the user’s intended purpose. third-party services and content on Clever service do not imply approval or endorsement thereof by us. If you decide to use any third-party services through Clever services, you do so at your own risk, and you should be aware of these terms and conditions of Clever. services no longer govern you. any third-party service is used at your own risk and as such you should review the applicable terms and conditions including privacy policies and data-gathering practices of such third-party service. You agree and acknowledge that we do not endorse the product or services offered through our listed third party and you shall hold us harmless from any losses to you or harm caused to you in any way from any third-party service.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Customer Support",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "Users may report complaints on the products to customer support that may be in violation of Clever’s terms of service. Clever will respond to clear and complete notices of the alleged infringement.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Disputes And Resolutions",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "We encourage our users to try and settle conflicts amongst themselves. If for any reason this fails after using the resolution center or if you encounter non-permitted usage on the app, users can contact Clever's customer support department for assistance. If there is a legal dispute, users agree that it will take place in state or federal high courts under the relevant Nigerian laws. you agree that these terms of use shall be governed by and interpreted in accordance with the laws of the federation of the federal republic of Nigeria.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "User-Generated Contributions",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "Clever services does not offer users to submit or post content. We may provide you the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to use or on Clever site, including but not limited to writing, video, audio, graphics, suggestions, comments or other materials (collectively “contributions”). such contributions may be viewable by other users or the general public through third-party websites/services. Hence, any assistance you transmit may be treated in accordance with Clever’s privacy policy.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "When contributing, you thereby represent and warrant that:",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      orderedList(
                                          "I. ",
                                          "Your creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "II. ",
                                          "You are the sole creator and owner or have the necessary license, right, consent, releases, and permission to use and to authorize us, Clever, and other users of Clever service to use your contribution in any manner contemplated by Cleverand these terms and conditions of use.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "III. ",
                                          "You have the written consent, release, and/or permission of every identifiable individual person in your contributions to use the name or likeness of every such identifiable person to enable inclusion and use of your contributions in any manner contemplated by Clever and these terms and conditions of use.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "IV. ",
                                          "Your contributions are not false or misleading.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "V. ",
                                          "Your contributions are not unsolicited or unauthorized advertising, promotional materials, spam, or other forms of solicitation.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "VI. ",
                                          "Your contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by Clever).",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "VII. ",
                                          "Your contributions do not ridicule, mock, disparage, intimidate, or abuse any person or entity.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "VIII. ",
                                          "Your contributions are not used to harass or threaten (in the legal sense of those terms (any other person or entity and to",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Clever Account",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "By signing up on Clever, you have agreed to be assigned a wallet; users are permitted to fund their wallets with their personal bank debit cards using our third-party card processing gateway and bank transfer to the provided bank account (provided on the user’s Clever dashboard). the use of a third-party card is only accepted upon approval by the card owner. stolen cards and fraudulent usage of a third-party card are not permitted. In cases like this, if found guilty, the account holder would be required to face the law as provided by the federal republic of Nigeria. to withdraw from your wallet, Clever might at her own discretion ask for documents to further verify the owner of the account holder, and/or card owner. you can transfer, pay bills and withdraw from your Penn wallet. The restrictions on this are dependent on your KYC level.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Reporting Violations",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "If you come across anything that may violate our terms of service and/or our community standards, you should report it to us through the appropriate channels created to handle those issues as outlined in our terms of service.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Violations",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "Users may receive a warning to their account or have their account restricted for violations of our terms of service and/or our community standards or any user misconduct reported to our trust and safety team. a warning will be displayed for such users on the app. warnings may limit account activity, but can lead to your account becoming permanently disabled based on the severity of the violation except for such violations",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Non-Permitted Usage",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "The Authenticity Of Clever Profile – ",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        )),
                                    TextSpan(
                                        text:
                                            "You may not create a false identity on Clever, misrepresent your identity, create a Clever profile for anyone other than yourself (a real person), or use or attempt to use another user’s account or information; your profile information, including your description, BVN, bank details, location, etc., while may be kept anonymous, must be accurate and complete and may not be misleading, illegal, offensive or otherwise harmful. Clever reserves the right to require users to go through a verification process in order to use the app (whether by using id, phone, camera, etc.).",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          height: 1.5,
                                        )),
                                  ],
                                ),
                              ),
                              addVerticalSpace(15.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Fraud/Unlawful Use - ",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        )),
                                    TextSpan(
                                        text:
                                            "You may not use Clever for any unlawful purposes or to conduct illegal activities.",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          height: 1.5,
                                        )),
                                  ],
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Proprietary Restrictions",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "Clever services and mobile application, including its general layout, look and feel, design, information, content, and other materials available thereon, are exclusively owned by Clever and protected by copyright, trademark, and other intellectual property laws. users have no right, and specifically agree not to do the following with respect to the app or any part, component or extension of the app (including its mobile applications):",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      orderedList(
                                          "I. ",
                                          "Copy, transfer, adapt, modify, distribute, transmit, display, create derivative works, and publish or reproduce them, in any manner.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "II. ",
                                          "Reverse assembles, decompile, reverse engineer or otherwise attempt to derive its source code, underlying ideas, algorithms, structure, or organization.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "III. ",
                                          "Remove any copyright notice, identification, or other proprietary notices.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "IV. ",
                                          "Use automation software (bots), hacks, modifications (mods), or any other unauthorized third-party software designed to modify the app.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "V. ",
                                          "Attempt to gain unauthorized access to, interfere with, damage or disrupt the app or the computer systems or networks connected to the app.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "VI. ",
                                          "Circumvent, remove, alter, deactivate, degrade or thwart any technological measure or content protections of the app.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "VII. ",
                                          "Use any robot, spider, crawler, or other automatic devices, process, software, or queries that intercept, “mines,” scrapes, or otherwise access the app to monitor, extract, copy or collect information or data from or through the app, or engage in any manual process to do the same",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "VIII. ",
                                          "Introduce any viruses, trojan horses, worms, logic bombs, or other materials that are malicious or technologically harmful into our systems.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "IX. ",
                                          "Use the app in any manner that could damage, disable, overburden or impair the app, or interfere with any other user's enjoyment of the app or",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "X. ",
                                          "Access or use the app in any way not expressly permitted by these terms of service. Users also agree not to permit or authorize anyone else to do any of the foregoing.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Disclaimer and Limit of Liability",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "You recognize that Clever cannot guarantee the investment results you might achieve using the investment information and financial insights it offers, and that Clever is not liable. All investments come with the possibility and understanding that you could lose money. Your deliberate enrollment in and acceptance of these Terms of Use are requirements for your decision to use our investing services. You acknowledge and accept that PennyTee is only for educational reasons and not for the purpose of offering legal, tax, or financial planning advice. You acknowledge that Clever is merely one of many tools you may use as part of a thorough investing strategy, and that you, not Clever, are in charge of your own financial research and investment decisions.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Investment Risk",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "Despite the fact that we give illustrative interest rates and returns for some plans on our platform, you understand that the value of any investment and the assets may decline due to market value fluctuations, and as a result, the assets' or interest rates' value (as appropriate) in your User Account may increase or decrease depending on the state of the market. You affirm that neither we nor anyone on our behalf has given you any oral or written assurances that your investment goal will be met or that the value of any assets in your User Account won't decrease.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Termination",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      orderedList(
                                          "A. ",
                                          "You agree that Clever in its sole discretion, may modify, suspend or terminate your account (or any part thereof) or use of the service and remove and discard any content within the service, for any reason, including, without limitation, for lack of use or if Clever believes that you have violated or acted inconsistently with the letter or spirit of these terms of service.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "B. ",
                                          "Any suspected fraudulent, abusive, or illegal activity relating to the use of Clever services may be grounds for termination of your use of Clever service and such activity may be referred to appropriate law enforcement authorities for further prosecution as deemed necessary by Clever.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "C. ",
                                          "Clever may also in its sole discretion and at any time discontinue providing the service, or any part thereof, with or without notice. you agree that any termination of your access to the service under any provision of this terms of service can be affected without prior notice and acknowledge and agree that Clever may immediately deactivate or delete your account and all related information and files in your account and/or restrict any further access to such files or the service.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "D. ",
                                          "You may end this agreement and terminate your use of Clever service at any time but only subject to the maturity of all and any investment currently subscribed to on the Clever application.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      orderedList(
                                          "E. ",
                                          "Further, you agree that Clever will not be liable to you or any third party for any termination of your access to the service.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Limitations Of Liability",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "In no event will we or our directors, employees, or agents be liable to you or any third party for any direct, indirect, consequential, exemplary, incidental, special, or punitive damages arising from the use of Clever services, even if we have been advised of the possibility of such damages.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "Declaration",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "By consenting to this agreement, you agree that you have read and understood the above stated terms and conditions and that you now own a Clever account. you agree to abide by the above-listed terms and conditions, which govern our operations. you also agree that the information supplied is true and correct. by opening an account with us, we may from time to time carry out regular identity and fraud prevention checks.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Center(
                                child: Text(
                                  "Clever Indemnity Form",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "For being a client of Clever|Digital Limited  (\"Service Provider\") I confirm that I hereby authorize Clever Digital Limited to effect any and all transactions relating to my account held with Clever Digital Limited on the basis of Electronic Mail (email) or any internet device(s) reasonably assessed to be issued by me in accordance with the email address or telephone number I submitted Clever in the account opening form.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "I irrevocably authorize Clever to make any payments and comply with all instructions contained in such email or SMS without any reference to or further authority from me and without enquiry into the justification therefore or validity thereof and agree that Clever may assume the authenticity thereof and that any payment which Clever shall make or instructions which Clever may comply with in accordance or purporting to be in accordance with such email instructions shall be binding upon me and shall be accepted by me as conclusive evidence that Clever was authorized by me to make such payment or comply with such demand.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "The fact that any instruction may later be shown to be in any way false, incomplete, inaccurate, delayed, erroneous, unauthorized, or otherwise not authentic, should not be an impediment to the rights of Clever hereunder.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "I further hereby fully indemnify the Clever against all direct and indirect losses, damages, actions, or claims whatsoever suffered by myself or Clever as a result of Clever acting on the basis of the said instructions including any costs and charges incurred in recovering damages.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "I agree that should I or Clever suffer any loss as more fully enumerated above, I shall be liable for the full amount of such loss.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "I agree that this indemnity shall subsist and remain valid and binding throughout the duration of my relations with Clever Digital Limited.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(15.h),
                              Text(
                                "This document shall be governed by the laws of the Federal Republic of Nigeria and I hereby execute it as a Deed and cause it to be delivered by the acceptance of this indemnity form.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              addVerticalSpace(60.h),
                            ]),
                      )
                    ],
                  ),
                )),
          )
        ]));
  }
}

bulletPoints(String text, bool isDarkMode) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("• ",
          style: TextStyle(
            color: isDarkMode ? AppColors.white : AppColors.black,
            fontFamily: "Mont",
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            height: 1.5,
          )),
      Expanded(
        child: Text(text,
            style: TextStyle(
              color: isDarkMode ? AppColors.white : AppColors.black,
              fontFamily: "Mont",
              fontSize: 14.sp,
              height: 1.5,
            )),
      ),
    ],
  );
}

orderedList(String point, String text, bool isDarkMode) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(point,
          style: TextStyle(
            color: isDarkMode ? AppColors.white : AppColors.black,
            fontFamily: "Mont",
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: 1.5,
          )),
      Expanded(
        child: Text(text,
            style: TextStyle(
              color: isDarkMode ? AppColors.white : AppColors.black,
              fontFamily: "Mont",
              fontSize: 14.sp,
              height: 1.5,
            )),
      ),
    ],
  );
}
