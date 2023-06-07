import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:get/get.dart';

class TermsAndCondition extends StatefulWidget {
  TermsAndCondition({required this.phone});
  final String phone;
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition>
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
                                "End-User License Agreement",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Revised: May 18, 2021",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 12.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(30.h),
                              Text(
                                "IMPORTANT -- READ CAREFULLY: BY DOWNLOADING, INSTALLING, OR USING THE APPLICATION, YOU REPRESENT THAT YOU PURCHASED THE APPLICATION FROM AN APPROVED SOURCE AND YOU AGREE TO BE BOUND BY THE TERMS OF THIS AGREEMENT. IF YOU ARE ACCEPTING THESE TERMS ON BEHALF OF ANOTHER PERSON, COMPANY OR OTHER LEGAL ENTITY, YOU REPRESENT AND WARRANT THAT YOU HAVE FULL AUTHORITY TO BIND THAT PERSON, COMPANY OR LEGAL ENTITY TO THESE TERMS.",
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
                                "IF YOU DO NOT AGREE TO THESE TERMS:\n* DO NOT DOWNLOAD, INSTALL, COPY, ACCESS OR USE THE APPLICATION; AND\n* PROMPTLY DELETE OR RETURN THE APPLICATION FOR A FULL REFUND.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(25.h),
                              Text(
                                "This End-User License Agreement (\"Agreement\") is a legal agreement hereby entered into between you, either an individual, company or other legal entity, and its affiliates (hereafter, “Customer”) and CLEVER DIGITAL LTD (\"CLEVER\") for the Application.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 13.sp,
                                  height: 1.5,
                                ),
                              ),
                              addVerticalSpace(50.h),
                              Text(
                                "1. DEFINITIONS",
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
                                        text: "“Affiliates” ",
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
                                            "means an entity controlled by, under common control with, or controlling a party. Subject to the terms and conditions of this Agreement, Affiliates may use the license granted hereunder. All references to CLEVER shall be deemed to be references to CLEVER and its Affiliates and all references to Customer shall be deemed to be references to Customer’s company or other legal entity and its Affiliate(s).",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "“Application” ",
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
                                            "means the object code version of the product, together with the Documentation, and all third-party Applications that CLEVER may have purchased or licensed from third parties and delivered to Customer as part of the Application, as well as any Updates provided by CLEVER to Customer pursuant to this Agreement.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "“Derivative Works” ",
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
                                            "means a revision, enhancement, modification, translation, abridgment, condensation, or expansion of Application or any other form in which such Application may be recast, transferred or adapted, which, if used without the consent of CLEVER, would constitute a copyright infringement.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "“Documentation” ",
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
                                            "means the official explanatory materials in printed, electronic or online form provided by CLEVER to Customer on the use of the Application. For the avoidance of doubt, any installation guide or end user documentation not prepared or provided by CLEVER, any online community site, unofficial documentation, videos, white papers, or feedback does not constitute Documentation.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "“Partners” ",
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
                                            "means distributors and resellers authorized by CLEVER or its distributors to resell the Application, or a co-branded version of the Application authorized by CLEVER.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "“Updates” ",
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
                                            "means all subsequent releases and versions of the Application that CLEVER makes generally available to its customers.",
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
                              addVerticalSpace(50.h),
                              Text(
                                "2. INTELLECTUAL PROPERTY RIGHTS",
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
                                        text: "2.1  Ownership. ",
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
                                            "Title to the Application, Documentation, Updates and all patents, copyrights, trade secrets and other worldwide proprietary and intellectual property rights in or related thereto are and will remain the exclusive property of CLEVER. Customer may not remove any titles, trademarks or trade names, copyright notices, legends, or other proprietary markings in or on the Application or Documentation and will not acquire any rights in the Application, except the limited license specified in this Agreement. CLEVER retains ownership of all rights in any copy, translation, modification, adaptation or Derivative Works of the Application, including any improvement or development thereof, as well as all rights not expressly granted to Customer in this Agreement. Customer shall promptly notify CLEVER in writing upon discovery of any unauthorized use of the Application or Documentation or infringement of CLEVER’s proprietary rights in the Application or Documentation.",
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
                              addVerticalSpace(50.h),
                              Text(
                                "3. LICENSE GRANT",
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
                                        text: "3.1  Application License. ",
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
                                            "Customer is hereby granted a non-exclusive, non-transferable, non-assignable, restricted license during the term set forth in this Agreement, to access, install, and use the Application in accordance with the relevant Documentation for Customer’s own personal or internal use only (the “Permitted Purpose”). Customer acknowledges the Application and Documentation is proprietary to CLEVER and may not be distributed to any third parties. Customer is not granted rights to Updates unless Customer has purchased Support Services. The license granted herein is subject to the specific restrictions and limitations set forth herein, and/or any additional licensing restrictions and limitations specified in the Documentation, or by notification and/or policy change posted at CLEVER’s website.",
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
                              addVerticalSpace(50.h),
                              Text(
                                "4. LICENSE RESTRICTIONS",
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
                                        text: "4.1  Restrictions on Use. ",
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
                                            "Clause 3 states the entirety of Customer’s rights with respect to the Application, and CLEVER reserves all rights not expressly granted to Customer in this Agreement. Without limiting the foregoing, Customer will not do, or authorize or permit any third party to do, any of the following: (a) distribute, sub-license, sell, assign, or otherwise transfer or make available the Application; (b) use the Application for any purpose other than the Permitted Purpose; (c) reverse engineer, decompile, disassemble or otherwise attempt to discover or re-create the source code for the Application; (d) modify, adapt, alter, improve or create any derivative works of the Application; (e) connect the Application with any other online services or use the Application in conjunction with other Application or services not provided by or permitted by Company; or (f) remove, circumvent or create or use any workaround to any copy protection or security feature in or relating to the Application.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "4.2  Trademarks. ",
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
                                            "Customer may not delete, remove, hide, move, or alter any trademark, logo, icon, image, or text that represents the CLEVER’s name, any derivation thereof, or any icon, image, or text that is likely to be confused with the same. All representations of the CLEVER’s name, logo or other mark of CLEVER or any of its Affiliates’ names or marks must remain as originally distributed regardless of the presence or absence of a trademark, copyright, or other intellectual property symbol or notice.",
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
                              addVerticalSpace(50.h),
                              Text(
                                "5. DISCLAIMERS AND LIMITATION OF LIABILITY",
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
                                        text: "5.1  Disclaimer. ",
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
                                            "THE APPLICATION IS PROVIDED ON AN “AS IS” BASIS WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED. CLEVER DOES NOT WARRANT THAT THE APPLICATION OR SUPPORT SERVICES WILL MEET CUSTOMER’S REQUIREMENTS OR THAT THE OPERATION THEREOF WILL BE FAIL SAFE, UNINTERRUPTED, ERROR FREE, OR THAT THE APPLICATION WILL PROTECT AGAINST ALL POSSIBLE THREATS. CLEVER DISCLAIMS ALL OTHER WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, NON-INTERFERENCE, AND ACCURACY OF INFORMATIONAL CONTENT.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "5.2  Limitation of liability. ",
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
                                            "IN NO EVENT, WHETHER IN TORT, CONTRACT, OR OTHERWISE, SHALL CLEVER OR ITS PARTNERS, OR SUPPLIERS BE LIABLE TO CUSTOMER OR ANY THIRD PARTIES UNDER THIS AGREEMENT FOR ANY INDIRECT, SPECIAL, INCIDENTAL, PUNITIVE, OR CONSEQUENTIAL DAMAGES, COSTS, LOSSES OR EXPENSE, (INCLUDING BUT NOT LIMITED TO LOST PROFITS, LOSS OR INTERRUPTION OF USE, LOSS OF DATA, LOSS OF GOODWILL, WORK STOPPAGE, DAMAGE TO NETWORKS, EQUIPMENT, OR HARDWARE, OR THE COST OF PROCUREMENT OF SUBSTITUTE GOODS OR TECHNOLOGY), regardless of whether the claim for such damages is based in contract, tort, or any other legal theory, even if CLEVER has been advised of such damages.  The foregoing limitations shall apply to the maximum extent permitted by applicable law.",
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
                              addVerticalSpace(50.h),
                              Text(
                                "6. CONFIDENTIALITY AND NOTIFICATIONS",
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
                                        text: "6.1  Confidentiality. ",
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
                                            "Customer acknowledges and agree that the Application incorporates confidential and proprietary information (“Confidential Information”) developed or acquired by CLEVER including, but not limited to, technical and non-technical data, formulas, patterns, compilations, devices, methods, techniques, drawings and processes related to the Application, which constitutes the valuable intellectual property of CLEVER.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "6.2  Use of Confidential Information. ",
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
                                            "Each party will comply with all laws and regulations that apply to use, transmission, storage, disclosure, or destruction of Confidential Information. Both Parties agree to hold the other party’s Confidential Information in the strictest confidence. Confidential Information shall not be disclosed by either party to anyone except an employee, or agent who has a need to know same, or who is bound by a non-disclosure and confidentiality provision at least as restrictive as those set forth in this Agreement. Each party agrees to ensure that its employees, agents, representatives, and contractors are advised of the confidential nature of the Confidential Information and are precluded from taking any action prohibited under this Agreement. CLEVER may use any technical information that Customer provides to CLEVER for any of CLEVER’s reasonable business purposes, including product support and development.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "6.3  Ownership of Information. ",
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
                                            "Except as explicitly stated in this Agreement, the party receiving the Confidential Information is granted no license or conveyance of disclosing party’s Confidential Information or any intellectual property rights therein. Title to the disclosing party’s Confidential Information shall remain solely with the party disclosing the Confidential Information.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "6.4  Remedies. ",
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
                                            "It is further understood and agreed that money damages may not be a sufficient remedy for any breach of the confidentiality provisions of this Agreement and that either party may be entitled to equitable relief, including injunction and specific performance, as a remedy for any such breach. Such remedies may not be deemed exclusive remedies for a breach of these provisions but may be deemed in addition to all other remedies available at law or in equity.",
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
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "6.5  Notices. ",
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
                                            "CLEVER may send Customer required legal notices and other communications about the Application, including special offers and pricing or other similar information, customer surveys or other requests for feedback (“Communications”). CLEVER will send Communications via in-product notices or email to registered email addresses of named contacts, or will post Communications on CLEVER’s website. Customer may notify CLEVER of Customer’s preference not to receive any such Communications. CLEVER reserves the right, at any time and from time to time, to revise, supplement, and otherwise modify this Agreement and to impose new or additional rules, policies, terms or conditions (collectively, “Additional Terms”) on Customer’s use of the Application. Such Additional Terms will be effective immediately and incorporated into this Agreement upon posting the revised agreement on CLEVER’s website and Customer waives any right to receive a specific notice of each such revision. Customer’s use of the Application signifies acceptance of the Agreement inclusive of future revisions.",
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
                              addVerticalSpace(50.h),
                              Text(
                                "7. TERM AND TERMINATION",
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
                                            "This Agreement and the licenses granted hereunder shall remain in effect until terminated by either party. CLEVER may terminate this Agreement and the licenses granted hereunder, upon written  notice  for  any  material  breach  of  this  Agreement  that  Customer  fails to cure within ____ days following written notice specifying such breach. Customer may terminate this  Agreement and the licenses granted hereunder upon written notice for any material breach of this Agreement that  CLEVER  fails  to  cure  within ___days  following  written  notice  specifying  such breach. Except as expressly provided herein, sections     of this Agreement shall survive termination.",
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
                              addVerticalSpace(50.h),
                              Text(
                                "8. INDEMNIFICATION",
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
                                            "CLEVER shall indemnify and hold harmless Customer and its officers, employees, agents and representatives and defend any action brought against same with respect to any third-party claim, demand or cause of action, including reasonable attorney’s fees, to the extent that it is based upon a claim that the Application infringes or violates any patents, copyrights, trade secrets, or other proprietary rights of a third-party. Customer may, at its own expense, assist in such defense if it so desires, provided that CLEVER shall control such defense and all negotiations relating to the settlement of any such claim. Customer shall promptly provide CLEVER with written notice of any claim which Customer believes falls within the scope of this indemnification provision of the Agreement. In the event that the Application or any portion thereof is held to constitute an infringement and its use is enjoined, CLEVER may, at its sole option and expense, (i) modify the infringing Application so that it is non-infringing, (ii) procure for Customer the right to continue to use the infringing Application, or (iii) replace said Application with suitable, non-infringing Application. Notwithstanding the foregoing, CLEVER will have  no obligation for any claims to the extent such claims result from (i) modifications or alterations of the Application made by or for Customer or any other party that were not provided by CLEVER or authorized by CLEVER in writing; (ii) use outside the scope of the license granted hereunder, (iii) use of a superseded or previous version of the Application if infringement would have been avoided by the use of a newer version which CLEVER made available to Customer, or (iv) use of the Application in combination with any other Application, hardware or products not supplied by CLEVER. This indemnity obligation is subject to the limitation of liability and does not apply to any open source components of the Application.]",
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
                              addVerticalSpace(50.h),
                              Text(
                                "9. GENERAL PROVISIONS",
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
                                        text: "9.1  Assignment. ",
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
                                            "Neither party may assign this Agreement or any right or obligation hereunder without the other party’s prior written consent. However, CLEVER may assign this Agreement in the event of a merger or consolidation or the purchase of all or substantially all of its assets. This Agreement will be binding upon and inure to the benefit of the permitted successors and assigns of each party.",
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
                                        text: "9.2  Force Majeure. ",
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
                                            "CLEVER will not be held responsible for any failure, delay or interruption caused by circumstances outside its control, such as network failure, network connection failure, earthquake, flooding, strikes, embargos or acts of government. If such event giving rise to Force Majeure lasts for more than 30 days, then either party may terminate this Agreement without such termination giving rise to any liability or right to any refund.",
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
                                            "9.3  Entire Agreement and Amendments. ",
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
                                            "This Agreement constitutes the entire agreement between the parties and supersedes all written or oral prior agreements or understandings between the parties. The terms of this Agreement may not be modified except by a written agreement signed by both parties.",
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
                                        text: "9.4  Severability. ",
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
                                            "If any provision of this Agreement is held illegal or unenforceable by any court of competent jurisdiction, such provision shall be deemed severed from the remaining provisions of this Agreement and shall not affect or impair the validity or enforceability of the remaining provisions of this Agreement.",
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
                                        text: "9.5  Waiver. ",
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
                                            "No failure of either party to exercise or enforce any of its rights under this Agreement will act as a waiver of those rights.",
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
                                            "9.6  Choice of Law and Jurisdiction. ",
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
                                            "The validity, interpretation and enforcement of this Agreement will be governed by and construed in accordance with the laws of the Federal Republic of Nigeria.",
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
                              addVerticalSpace(60.h),
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Contact Information\n\n",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => {},
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.mainGreen
                                              : AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          fontSize: 15.sp,
                                          fontFamily: 'Mont',
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "If you have any questions about this \nagreement, please ",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => {},
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? AppColors.mainGreen
                                                : AppColors.primaryColor,
                                            height: 1.5,
                                            fontSize: 14.sp,
                                            fontFamily: 'Mont',
                                          )),
                                      TextSpan(
                                        text: "Contact Us",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => launcher.launchUrl(
                                              Uri.parse("tel:${widget.phone}")),
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.mainGreen
                                              : AppColors.primaryColor,
                                          fontFamily: 'Mont',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
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
