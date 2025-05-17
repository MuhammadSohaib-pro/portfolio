import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'package:portfolio/views/components/about_section.dart';
import 'package:portfolio/views/components/contact_section.dart';
import 'package:portfolio/views/components/footer.dart';
import 'package:portfolio/views/components/header.dart';
import 'package:portfolio/views/components/hero_section.dart';
import 'package:portfolio/views/components/particle_background.dart';
import 'package:portfolio/views/components/project_section.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final tablet = Responsive.isTablet(context);
    final miniDesktop = Responsive.isMiniDesktop(context);
    return Scaffold(
      backgroundColor: AppColors.mainColorLight,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          mobile ? 100 : 90,
        ),
        child: Container(
          color: AppColors.scaffoolBgColorDark,
          child: const Center(
            child: SizedBox(
              width: double.infinity,
              child: Header(),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ParticleBackground(
            numberOfParticles: 70,
            child: Scrollbar(
              controller: controller.scrollController,
              scrollbarOrientation: ScrollbarOrientation.right,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      key: controller.homekey,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mobile
                                      ? 0
                                      : (tablet || miniDesktop)
                                          ? 20
                                          : 60),
                              child: const HeroSection(),
                            ),
                          ),
                        ),
                        Divider(
                            key: controller.aboutKey,
                            color: AppColors.mainColor),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mobile
                                      ? 0
                                      : (tablet || miniDesktop)
                                          ? 20
                                          : 60),
                              child: AboutSection(),
                            ),
                          ),
                        ),
                        Divider(
                            key: controller.projectKey,
                            color: AppColors.mainColor),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mobile
                                        ? 0
                                        : (tablet || miniDesktop)
                                            ? 20
                                            : 60),
                                child: ProjectSection()),
                          ),
                        ),
                        Divider(
                            key: controller.contactKey,
                            color: AppColors.mainColor),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mobile
                                      ? 0
                                      : (tablet || miniDesktop)
                                          ? 20
                                          : 60),
                              child: const ContactSection(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Footer(),
                  ],
                ),
              ),
            ),
          ),
          (mobile || tablet) ? Container() : _buildScrollIndicator(context),
        ],
      ),
      floatingActionButton: (mobile || tablet)
          ? FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              onPressed: () {
                controller.selectPage('Home');
              },
              child: const Icon(Icons.arrow_upward),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Updated Animated Scroll Indicator with better dimensions
  Widget _buildScrollIndicator(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height / 2;

    return Obx(() => AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          right: controller.isScrollIndicatorVisible.value
              ? -30
              : -120, // Add this RxBool to your controller
          top: maxHeight - 150,
          child: MouseRegion(
            onEnter: (_) => controller.isScrollIndicatorHovered.value =
                true, // Add this RxBool to your controller
            onExit: (_) => controller.isScrollIndicatorHovered.value = false,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: controller.isScrollIndicatorHovered.value
                    ? AppColors.mainColorLight.withValues(alpha: 0.9)
                    : AppColors.mainColorLight.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.mainColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainColor.withValues(
                        alpha: controller.isScrollIndicatorHovered.value
                            ? 0.4
                            : 0.2),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildScrollDot('Home'),
                  const SizedBox(height: 16),
                  _buildScrollDot('About'),
                  const SizedBox(height: 16),
                  _buildScrollDot('Projects'),
                  const SizedBox(height: 16),
                  _buildScrollDot('Contact'),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildScrollDot(String section) {
    bool isActive = controller.selectedPage.value == section;
    final RxBool isHovered = false.obs;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: GestureDetector(
        onTap: () => controller.selectPage(section),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive || isHovered.value ? 150 : 120,
          height: 40,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.mainColor
                : (isHovered.value
                    ? AppColors.mainColor.withValues(alpha: 0.1)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
            boxShadow: isActive || isHovered.value
                ? [
                    BoxShadow(
                      color: AppColors.mainColor
                          .withValues(alpha: isActive ? 0.5 : 0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? AppColors.black00
                      : (isHovered.value
                          ? AppColors.mainColor.withValues(alpha: 0.2)
                          : Colors.transparent),
                  border: Border.all(
                    color: isActive || isHovered.value
                        ? AppColors.mainColor
                        : AppColors.mainColor.withValues(alpha: 0.3),
                    width: isActive ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isActive
                        ? Icon(
                            _getSectionIcon(section),
                            color: AppColors.mainColor,
                            size: 18,
                            key: ValueKey<bool>(true),
                          )
                        : Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isHovered.value
                                  ? AppColors.mainColor
                                  : AppColors.whiteff,
                            ),
                            key: ValueKey<bool>(false),
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    section,
                    style: TextStyle(
                      color: isActive
                          ? AppColors.black00
                          : (isHovered.value
                              ? AppColors.mainColor
                              : AppColors.whiteff),
                      fontSize: 14,
                      fontWeight: isActive || isHovered.value
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSectionIcon(String section) {
    switch (section) {
      case 'Home':
        return Icons.home_rounded;
      case 'About':
        return Icons.person_rounded;
      case 'Projects':
        return Icons.work_rounded;
      case 'Contact':
        return Icons.email_rounded;
      default:
        return Icons.circle;
    }
  }
}
