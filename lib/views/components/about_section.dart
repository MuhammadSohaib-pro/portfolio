import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';

class AboutSection extends StatelessWidget {
  AboutSection({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final mobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile || tablet ? MySize.size20 : MySize.size50,
        vertical: mobile || tablet ? MySize.size20 : MySize.size70,
      ),
      child: tablet || mobile
          ? Column(
              children: [
                _buildTextContent(context, mobile: mobile, tablet: tablet),
                SizedBox(height: MySize.size30),
                _buildImageContentMobile(context),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 5,
                  child: _buildImageContentMobile(context),
                ),
                Expanded(
                  flex: 5,
                  child: _buildTextContent(context,
                      mobile: mobile, tablet: tablet),
                ),
              ],
            ),
    );
  }

  Widget _buildTextContent(context,
      {required bool mobile, required bool tablet}) {
    return Column(
      crossAxisAlignment: mobile || tablet
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: mobile || tablet
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: mobile || tablet
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'About Me',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteff,
                        fontSize: MySize.size42,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Who Am I?',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                if (!mobile && !tablet) const Expanded(child: SizedBox()),
              ],
            )
          ],
        ),
        SizedBox(height: MySize.size22),
        Text(
          "I am a professional Flutter developer with expertise in building cross-platform applications. I am passionate about creating engaging and functional user interfaces that deliver seamless experiences. My goal is to leverage my skills to develop innovative, customizable, and sustainable software solutions. Below are the tech stacks I use regularly:",
          style: TextStyle(
            color: const Color(0xFFA9A9A9),
            fontSize: MySize.size22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: MySize.size30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  "assets/svg/flutter_icon.svg",
                  height: mobile || tablet ? 24 : 40,
                  width: mobile || tablet ? 24 : 40,
                ),
                Text(
                  'Flutter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA9A9A9),
                    fontSize: mobile || tablet ? MySize.size12 : MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SvgPicture.asset(
                  "assets/svg/dartlang_icon.svg",
                  height: mobile || tablet ? 24 : 40,
                  width: mobile || tablet ? 24 : 40,
                ),
                Text(
                  'Dart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA9A9A9),
                    fontSize: mobile || tablet ? MySize.size12 : MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/bloc_icon.png",
                  height: mobile || tablet ? 24 : 40,
                  width: mobile || tablet ? 24 : 40,
                ),
                Text(
                  'Bloc',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA9A9A9),
                    fontSize: mobile || tablet ? MySize.size12 : MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SvgPicture.asset(
                  "assets/svg/firebase_icon.svg",
                  height: mobile || tablet ? 24 : 40,
                  width: mobile || tablet ? 24 : 40,
                ),
                Text(
                  'Firebase',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA9A9A9),
                    fontSize: mobile || tablet ? MySize.size12 : MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SvgPicture.asset(
                  "assets/svg/git_icon.svg",
                  height: mobile || tablet ? 24 : 40,
                  width: mobile || tablet ? 24 : 40,
                ),
                Text(
                  'Git',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA9A9A9),
                    fontSize: mobile || tablet ? MySize.size12 : MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/androidstudio_icon.png",
                  height: mobile || tablet ? 24 : 40,
                  width: mobile || tablet ? 24 : 40,
                ),
                Text(
                  'Android Studio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA9A9A9),
                    fontSize: mobile || tablet ? MySize.size12 : MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/xcode_icon.png",
                  height: mobile || tablet ? 24 : 40,
                  width: mobile || tablet ? 24 : 40,
                ),
                Text(
                  'XCode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA9A9A9),
                    fontSize: mobile || tablet ? MySize.size12 : MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: MySize.size40),
        OutlinedButton(
          onPressed: controller.downloadResume,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.mainColor, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: const BorderSide(
                color: AppColors.mainColor,
              ),
            ),
          ),
          child: const Text(
            "Download Resume",
            style: TextStyle(
              color: AppColors.mainColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContentMobile(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageHeight;
        if (Responsive.isMobile(context)) {
          imageHeight = constraints.maxWidth * 0.7;
        } else if (Responsive.isTablet(context)) {
          imageHeight = constraints.maxWidth * 0.7;
        } else {
          imageHeight = constraints.maxWidth * 0.7;
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size50),
          child: Container(
            padding: const EdgeInsets.only(top: 8, left: 8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF55E5A4).withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(-5, -5),
                  spreadRadius: 1,
                )
              ],
              border: const Border(
                top: BorderSide(
                  color: AppColors.mainColor,
                  width: 5,
                ),
                left: BorderSide(
                  color: AppColors.mainColor,
                  width: 5,
                ),
              ),
            ),
            child: Container(
              height: imageHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/profile.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
