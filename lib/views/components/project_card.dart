import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String exploreLink;
  final bool haveExploreLink;
  final List<Widget> usedTechnologies;

  ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.usedTechnologies,
    required this.exploreLink,
    required this.haveExploreLink,
  });

  final RxBool isHovered = false.obs;

  @override
  Widget build(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final mobile = Responsive.isMobile(context);
    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: Obx(
        () => AnimatedScale(
          scale: isHovered.value ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: isHovered.value
                  ? [
                      BoxShadow(
                        color: const Color(0xFF55E5A4).withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                        spreadRadius: 1.5,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                        spreadRadius: 1,
                      ),
                    ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColors.mainColorLight,
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.asset(
                      imageUrl,
                      height: (mobile || tablet) ? 225 : 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MySize.size20, 0, MySize.size20, MySize.size10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MySize.size5),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whiteff,
                            fontSize: MySize.size24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFA9A9A9),
                            fontSize: MySize.size18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        Text(
                          'Technologies Used',
                          style: TextStyle(
                            color: AppColors.whiteff,
                            fontSize: MySize.size18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        SizedBox(
                          height: MySize.size25,
                          width: double.infinity,
                          child: Center(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  usedTechnologies[index],
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: MySize.size10),
                              itemCount: usedTechnologies.length,
                            ),
                          ),
                        ),
                        SizedBox(height: haveExploreLink ? MySize.size20 : 0),
                        haveExploreLink
                            ? ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await launchUrl(Uri.parse(exploreLink));
                                  } catch (e) {
                                    print("$e");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  backgroundColor: AppColors.mainColor,
                                ),
                                child: Text(
                                  "Visit Live",
                                  style: TextStyle(
                                    fontSize: MySize.size14,
                                    color: AppColors.black00,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
