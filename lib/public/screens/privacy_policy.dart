import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy>
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
                              Center(
                                child: Text(
                                  "PRIVACY POLICY",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              addVerticalSpace(50.h),
                              Text(
                                "INTRODUCTION",
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
                                            "CLEVER DIGITAL LIMITED (“we” “our” “us”) values your privacy and the security of the information you share with us. This Privacy Policy explains how we collect, use, disclose and safeguard the information we obtain from you in relation your use of this site.",
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
                                "Last Updated and Effective: February 14, 2022.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 12.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "UPDATES TO OUR POLICY",
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
                                            "We may amend or update our Privacy Policy. We will provide you notice of amendments to this Privacy Policy, as appropriate, and update the “Last Updated” date above. By visiting and entering your details on this site, you consent to the terms and practices contained in this Privacy Policy and you grant us the right to collect and process your data in accordance with the terms of this Policy. If you do not agree to the terms contained in this Privacy Policy, please do not continue on this site. Please review our Privacy Policy from time to time.",
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
                                "THE INFORMATION WE COLLECT",
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
                                            "When you use this site, we may collect certain types of information about you including the following:",
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
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Information you provide to us",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                      addVerticalSpace(10.h),
                                      Text(
                                          "This includes but is not limited to your personal data (such as your name, phone number(s), email address, home and office addresses, delivery address, product and service preferences, and responses) and your social network data (such as your social media profiles and usernames).",
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontFamily: "Mont",
                                            fontSize: 14.sp,
                                            height: 1.5,
                                          )),
                                      addVerticalSpace(20.h),
                                      Text(
                                        "Information we collect automatically",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                      addVerticalSpace(10.h),
                                      Text(
                                          "This includes but is not limited to your IP address, browser type, mobile device ID, device type, operating system version, connection information, mobile network information, location derived from GPS-enabled services, information based on your usage of the Site such as time, date and duration of your use, referral URLs, search terms and search history, camera, contact list, browsing history, purchase history and advertisement interactions.",
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontFamily: "Mont",
                                            fontSize: 14.sp,
                                            height: 1.5,
                                          )),
                                      addVerticalSpace(20.h),
                                      Text(
                                        "Information we obtain from 3rd Parties",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                      addVerticalSpace(10.h),
                                      Text(
                                          "This includes information we obtain from social media sites such as your friends and followers lists, and your interests.",
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontFamily: "Mont",
                                            fontSize: 14.sp,
                                            height: 1.5,
                                          )),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "WHY WE COLLECT YOUR INFORMATION",
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
                                            "We collect your information to ensure your easy and seamless access to the site. We use the information we collect for the following purposes:",
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
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      bulletPoints(
                                          "To enable us to provide you with a personalized experience of our site.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To communicate with you and provide you with information on our Services.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To provide support services to you.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To process your orders and requests.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To analyse and understand your use of the site.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To protect against illegal, malicious, and fraudulent activity.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To analyse and improve the quality of our services and offerings.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To facilitate your interactions with our social media platforms.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To analyse and learn about our users’ demographics, interests, and behaviour.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To identify and repair errors and bugs on our platforms.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "To facilitate dissemination of information about our services and our partners.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "COOKIES",
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
                                            "We may sometimes make use of cookies and other similar technology to track your use of this page. Cookies are small text files which are stored on your computer when you visit a website. Cookies help us deliver a personalised experience to you by remembering your interests and preferences.",
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
                                        text:
                                            "For further information, visit allaboutcookies.org.",
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
                                "GOVERNING PRINCIPLES OF DATA PROCESSING",
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
                                            "We process your information in accordance with the provisions of the Nigeria Data Protection Regulation and these principles:",
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
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      bulletPoints(
                                          "Your personal data is collected and processed in accordance with specific, legitimate and lawful purpose consented to by you, provided that further processing may be done by archiving the data for public interest, scientific or research purposes, or statistical purposes.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "The data collected is adequate, accurate and without prejudice to the dignity of the human person.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "The data collected is stored only for the period within which it is reasonably needed.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "The data collected is secured against all foreseeable hazards and breaches such as theft, cyberattack, viral attack, dissemination, manipulations of any kind, damage by rain, fire or exposure to other natural elements.",
                                          isDarkMode),
                                      addVerticalSpace(10.h),
                                      bulletPoints(
                                          "We owe a duty of care to you in respect of the data we have obtained from you.",
                                          isDarkMode),
                                    ]),
                              ),
                              addVerticalSpace(40.h),
                              Text(
                                "HOW WE SAFEGUARD YOUR INFORMATION",
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
                                "We protect your personal information through technical and organisational security measures. In addition to the security measures we employ, you must also ensure that you take responsibility for the protection of your personal information. The use of our site and storage of your information on our website is done at your own risk. We will not be liable for any loss or damage caused by the activities of hackers and fraudsters when we have taken all necessary and reasonable steps to protect your information in our possession. You are fully responsible for safeguarding your username, password, and financial information.",
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
                                "LINKS TO THIRD PARTY WEBSITES",
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
                                "Our website and mobile applications may contain links to other websites not subject to this Privacy Policy. When you access those websites, they may collect your personal information in accordance with their privacy and data collection policies. We are not responsible for the data collected by these third parties and you are advised to study their privacy policies before you make use of their service",
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
                                "YOUR PRIVACY RIGHTS",
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
                                "By providing us with your personal information, you have certain rights in accordance with the provisions of the Nigeria Data Protection Regulation which include the right to request for your personal data in our possession, the right to object to the processing of your personal data, the right to request that we correct any information which you believe is inaccurate or incomplete, the right to request that we restrict the processing of your personal data, under certain conditions, the right to object to our processing of your personal data, under certain conditions, the right to request that we transfer the data that we have collected to another organization, or directly to you, under certain condition, and the right to request for the deletion of your personal data in our possession. To exercise any of the rights listed here, please contact us through the details provided below. All such requests will be reviewed and considered in accordance with the provisions of the applicable data protection regulations.",
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
                                "You also have the right to opt-out of receiving the informative materials we send to our users by clicking the “Unsubscribe” button found at the bottom of such emails. Please note that by opting out of such emails, you may be unable to participate in our contests, sales and giveaways.",
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
                                "INTERNATIONAL TRANSFER OF YOUR INFORMATION",
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
                                "We may need to transfer your information in our possession to third parties outside Nigeria. Such transfers will only be done in accordance with the applicable data protection regulations. While undertaking the international transfer of your information, we will put security measures in place to reasonably protect your data during transmission. You consent to the transfer of your personal information to third parties outside Nigeria where necessary.",
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
                                "KEEPING YOUR INFORMATION ACCURATE",
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
                                "We take reasonable steps to ensure that the information we collect and store, use or disclose is accurate, up-to-date, and complete. However, we rely on you to advise us of any changes to your information to help us do so. If you believe your personal information is not accurate, up-to-date or complete, then please let us know.",
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
                                "DATA RETENTION PERIOD",
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
                                "We will only keep the information we collect from you for as long as is necessary and in accordance with legal and compliance regulations. If you unsubscribe, we will cease to collect your personal data but will continue to store the data collected before you unsubscribe as long as is necessary and in accordance with applicable data protection regulations.",
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
                                "HOW DOES OUR SITE HANDLE DO NOT TRACK (DNT) SIGNALS",
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
                                "We honor DNT signals. We do not track, plant cookies, or use advertising when a DNT browser mechanism is in place.",
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
                                "CONTACT DETAILS",
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
                                            "If you have any question, request or complaints, or you require further information not already provided in this Privacy Policy or to find out what information we have collected from you and request any changes, please contact us by sending an email to ",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          height: 1.5,
                                        )),
                                    TextSpan(
                                        text: COMPANY_EMAIL,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => launcher.launchUrl(
                                              Uri.parse(
                                                  "mailto:$COMPANY_EMAIL")),
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.mainGreen
                                              : AppColors.primaryColor,
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          height: 1.5,
                                        )),
                                  ],
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
