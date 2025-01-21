import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'package:portfolio/views/components/about_section.dart';
import 'package:portfolio/views/components/contact_section.dart';
import 'package:portfolio/views/components/footer.dart';
import 'package:portfolio/views/components/header.dart';
import 'package:portfolio/views/components/hero_section.dart';
import 'package:portfolio/views/components/project_section.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: AppColors.mainColorLight,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  key: controller.homekey,
                  height: mobile ? MySize.size100 : MySize.size90,
                ),
                Center(
                  child: SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : MySize.safeWidth / 1.2,
                    child: HeroSection(),
                  ),
                ),
                Divider(key: controller.aboutKey, color: AppColors.mainColor),
                Center(
                  child: SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : MySize.safeWidth / 1.2,
                    child: AboutSection(),
                  ),
                ),
                Divider(key: controller.projectKey, color: AppColors.mainColor),
                Center(
                  child: SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : MySize.safeWidth / 1.2,
                    child: ProjectSection(),
                  ),
                ),
                Divider(key: controller.contactKey, color: AppColors.mainColor),
                Center(
                  child: SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : MySize.safeWidth / 1.2,
                    child: ContactSection(),
                  ),
                ),
                Footer()
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.scaffoolBgColorDark,
              child: Center(
                child: SizedBox(
                  width: Responsive.isMobile(context)
                      ? double.infinity
                      : MySize.safeWidth / 1.2,
                  child: Header(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
