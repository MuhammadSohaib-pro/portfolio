import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  Footer({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF26303E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MySize.size30),
          SvgPicture.asset(
            "assets/svg/initialLight.svg",
            height: MySize.size80,
            width: MySize.size80,
          ),
          SizedBox(height: MySize.size40),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: controller.selectedPage.value == "Home"
                        ? AppColors.mainColor
                        : const Color(0xFFA9A9A9),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: MySize.size40),
                Text(
                  'About',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: controller.selectedPage.value == "About"
                        ? AppColors.mainColor
                        : const Color(0xFFA9A9A9),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: MySize.size40),
                Text(
                  'Projects',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: controller.selectedPage.value == "Projects"
                        ? AppColors.mainColor
                        : const Color(0xFFA9A9A9),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: MySize.size40),
                Text(
                  'Contact',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: controller.selectedPage.value == "Contact"
                        ? AppColors.mainColor
                        : const Color(0xFFA9A9A9),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MySize.size40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  try {
                    await launchUrl(
                        Uri.parse("https://github.com/MuhammadSohaib-pro"));
                  } catch (e) {
                    print("$e");
                  }
                },
                child: Container(
                  width: MySize.size50,
                  height: MySize.size50,
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF343236), Color(0xFF38343F)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.mainColor,
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x7F000000),
                        blurRadius: 25,
                        offset: Offset(0, 15),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/svg/github.svg"),
                ),
              ),
              SizedBox(width: MySize.size40),
              InkWell(
                onTap: () async {
                  try {
                    await launchUrl(Uri.parse(
                        "https://www.linkedin.com/in/muhammad-sohaib-pro/"));
                  } catch (e) {
                    print("$e");
                  }
                },
                child: Container(
                  width: MySize.size50,
                  height: MySize.size50,
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF343236), Color(0xFF38343F)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.mainColor,
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x7F000000),
                        blurRadius: 25,
                        offset: Offset(0, 15),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/svg/linkedIn.svg"),
                ),
              ),
              SizedBox(width: MySize.size40),
              InkWell(
                onTap: () async {
                  try {
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: 'muhammadsohaib030@gmail.com',
                    );
                    await launchUrl(
                      emailUri,
                    );
                  } catch (e) {
                    print("$e");
                  }
                },
                child: Container(
                  width: MySize.size50,
                  height: MySize.size50,
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF343236), Color(0xFF38343F)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.mainColor,
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x7F000000),
                        blurRadius: 25,
                        offset: Offset(0, 15),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/svg/mail.svg"),
                ),
              ),
            ],
          ),
          SizedBox(height: MySize.size50),
          const Divider(color: Color(0xffA9A9A9)),
          SizedBox(height: MySize.size30),
          Text(
            '© 2024. All Rights Reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MySize.size18,
              color: const Color(0xFFA9A9A9),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: MySize.size50),
        ],
      ),
    );
  }
}
