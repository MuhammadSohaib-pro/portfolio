import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/mySize.dart';
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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile || tablet ? MySize.size20 : MySize.size50,
        vertical: mobile || tablet ? MySize.size20 : MySize.size70,
      ),
      child: Column(
        children: [
          Text(
            'Projects',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.whiteff,
              fontSize: MySize.size42,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: MySize.size40),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: tablet || mobile ? 1 : 2,
              crossAxisSpacing:
                  tablet || mobile ? MySize.size20 : MySize.size50,
              mainAxisSpacing: tablet || mobile ? MySize.size20 : MySize.size50,
              mainAxisExtent:
                  tablet || mobile ? MySize.size550 : MySize.size575,
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
                exploreLink: item.exploreLink,
                haveExploreLink: item.haveExploreLink,
              );
            },
          ),
        ],
      ),
    );
  }
}
