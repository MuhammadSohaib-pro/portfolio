import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find();
  final RxBool isDrawerOpen = false.obs;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final mobile = Responsive.isMobile(context);
    final miniDesktop = Responsive.isMiniDesktop(context);
    final desktop = Responsive.isDesktop(context);

    return Container(
      height: mobile ? 100 : 90,
      padding: EdgeInsets.symmetric(
          horizontal: mobile
              ? 0
              : (tablet || miniDesktop)
                  ? 20
                  : 60),
      decoration: BoxDecoration(
        color: AppColors.scaffoolBgColorDark,
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: mobile ? 20 : 15,
          horizontal: mobile ? 20 : 0,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(),
              if (desktop)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => _buildNavigation(mobile, tablet)),
                    ],
                  ),
                ),
              if (mobile || tablet) _buildMobileMenuButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 300),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => controller.scrollToSection(controller.homekey),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/initialLight.svg",
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 20),
              const Text(
                "Muhammad Sohaib",
                style: TextStyle(
                  color: AppColors.whiteff,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation(bool mobile, bool tablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton('Home'),
        const SizedBox(width: 20),
        buildButton('About'),
        const SizedBox(width: 20),
        buildButton('Projects'),
        const SizedBox(width: 20),
        buildButton('Contact'),
      ],
    );
  }

  Widget buildButton(String pageName) {
    bool isSelected = controller.selectedPage.value == pageName;
    final RxBool isHovered = false.obs;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(isSelected || isHovered.value ? 1.05 : 1.0),
        child: GestureDetector(
          onTap: () => controller.selectPage(pageName),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pageName,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.mainColor
                      : (isHovered.value
                          ? Colors.white
                          : const Color(0xFFA9A9A9)),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: isSelected ? 30 : (isHovered.value ? 20 : 0),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isSelected || isHovered.value
                      ? [
                          BoxShadow(
                            color: AppColors.mainColor.withValues(alpha: 0.5),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return Obx(() => IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isDrawerOpen.value ? Icons.close_rounded : Icons.menu_rounded,
              key: ValueKey<bool>(isDrawerOpen.value),
              color: AppColors.whiteff,
              size: 40,
            ),
          ),
          onPressed: () {
            isDrawerOpen.toggle();
            _showMobileDrawer(context);
          },
        ));
  }

  void _showMobileDrawer(BuildContext context) {
    if (isDrawerOpen.value) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: AppColors.scaffoolBgColorDark,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mainColor.withValues(alpha: 0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: const Offset(0, -3),
                ),
              ],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                // Drawer header with drag handle
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      // Drag handle
                      Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Logo
                      SvgPicture.asset(
                        "assets/svg/initialLight.svg",
                        height: 60,
                        width: 60,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMobileNavItem('Home', context),
                        _buildMobileNavItem('About', context),
                        _buildMobileNavItem('Projects', context),
                        _buildMobileNavItem('Contact', context),
                      ],
                    ),
                  ),
                ),
                // Social links
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon("assets/svg/github.svg",
                          "https://github.com/MuhammadSohaib-pro"),
                      const SizedBox(width: 20),
                      _buildSocialIcon("assets/svg/linkedIn.svg",
                          "https://www.linkedin.com/in/muhammad-sohaib-pro/"),
                      const SizedBox(width: 20),
                      _buildSocialIcon("assets/svg/mail.svg",
                          "mailto:muhammadsohaib030@gmail.com"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ).then((_) => isDrawerOpen.value = false);
    }
  }

  Widget _buildMobileNavItem(String pageName, BuildContext context) {
    final bool isSelected = controller.selectedPage.value == pageName;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: InkWell(
        onTap: () {
          controller.selectPage(pageName);
          Navigator.of(context).pop();
          isDrawerOpen.value = false;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.mainColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? AppColors.mainColor : Colors.transparent,
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pageName,
                style: TextStyle(
                  color: isSelected ? AppColors.mainColor : AppColors.whiteff,
                  fontSize: 22,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: isSelected ? AppColors.mainColor : Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String iconPath, String link) {
    final RxBool isHovered = false.obs;

    return Obx(() => MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: InkWell(
            onTap: () async {
              try {
                await launchUrl(Uri.parse(link));
              } catch (e) {
                if (kDebugMode) {
                  print("$e");
                }
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isHovered.value
                      ? [
                          AppColors.mainColor,
                          AppColors.mainColor.withValues(alpha: 0.8)
                        ]
                      : [const Color(0xFF343236), const Color(0xFF38343F)],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.mainColor,
                  width: isHovered.value ? 2 : 1,
                ),
                boxShadow: isHovered.value
                    ? [
                        BoxShadow(
                          color: AppColors.mainColor.withValues(alpha: 0.5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  isHovered.value ? AppColors.black00 : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ));
  }
}
