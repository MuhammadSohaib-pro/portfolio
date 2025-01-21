import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';

class HeroSection extends StatelessWidget {
  HeroSection({super.key});

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
                _buildTextContent(context),
                SizedBox(height: MySize.size30),
                _buildImageContentMobile(context),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 5,
                  child: _buildTextContent(context),
                ),
                Expanded(
                  flex: 5,
                  child: _buildImageContentMobile(context),
                ),
              ],
            ),
    );
  }

  Widget _buildTextContent(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Muhammad Sohaib',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteff,
            fontSize: MySize.size22,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Flutter Developer',
          textAlign:
              Responsive.isMobile(context) ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: AppColors.mainColor,
            fontSize: MySize.size42,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(
          width: 594,
          child: Text(
            'I specialize in building immersive user experiences with Flutter, leveraging '
            'its powerful UI toolkit to bring your vision to life across platforms. '
            'Additionally, I have expertise in geoinformatics, where I excel at utilizing '
            'spatial data to unlock actionable insights.',
            style: TextStyle(
              color: const Color(0xFFA9A9A9),
              fontSize: MySize.size22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: MySize.size40),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => controller.selectPage("Contact"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.mainColor,
              ),
              child: const Text(
                "Get in Touch",
                style: TextStyle(
                  color: AppColors.black00,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(width: MySize.size20),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: AppColors.mainColor,
                  size: MySize.size15,
                ),
                SizedBox(width: MySize.size8),
                Text(
                  'Available now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF888888),
                    fontSize: MySize.size22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageContentMobile(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adaptive height based on screen type
        double imageHeight;
        if (Responsive.isMobile(context)) {
          imageHeight = constraints.maxWidth * 0.7;
        } else if (Responsive.isTablet(context)) {
          imageHeight = constraints.maxWidth * 0.7;
        } else {
          imageHeight = constraints.maxWidth * 0.7;
        }

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 10 : 20,
              vertical: 10,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SvgPicture.asset(
                  "assets/svg/profilebg.svg",
                  width: constraints.maxWidth * 0.9,
                  fit: BoxFit.contain,
                ),
                Image.asset(
                  "assets/svg/profile.png",
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
