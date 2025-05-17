import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'package:portfolio/views/components/project_card.dart';

class ProjectSection extends StatelessWidget {
  ProjectSection({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final mobile = Responsive.isMobile(context);
    final miniDesktop = Responsive.isMiniDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile || tablet ? 20 : 50,
        vertical: mobile || tablet ? 20 : 70,
      ),
      child: Column(
        children: [
          const Text(
            'Projects',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.whiteff,
              fontSize: 42,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: tablet
                  ? 2
                  : mobile
                      ? 1
                      : 3,
              crossAxisSpacing: tablet || mobile
                  ? 20
                  : miniDesktop
                      ? 20
                      : 50,
              mainAxisSpacing: tablet || mobile
                  ? 20
                  : miniDesktop
                      ? 20
                      : 50,
              mainAxisExtent: tablet || mobile ? 500 : 520,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.projectList.length,
            itemBuilder: (context, index) {
              final item = controller.projectList[index];
              return ProjectCard(
                title: item.title,
                description: item.description,
                imageUrl: item.imageUrl,
                usedTechnologies: item.usedTechnologies,
                exploreIOSLink: item.iosLink,
                exploreAndroidLink: item.androidLink,
                haveIOSExploreLink: item.haveIOSExploreLink,
                haveAndroidExploreLink: item.haveAndroidExploreLink,
              );
            },
          ),
        ],
      ),
    );
  }
}
