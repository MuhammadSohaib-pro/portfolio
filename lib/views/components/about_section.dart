import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'dart:math' as math;

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find();
  late AnimationController _animationController;
  late Animation<double> _profileImageAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _profileImageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController..forward(),
        curve: Curves.easeInOut,
      ),
    );
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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile || tablet ? 20 : 50,
        vertical: mobile || tablet ? 20 : 70,
      ),
      child:
          tablet || mobile
              ? Column(
                children: [
                  _buildTextContent(context, mobile: mobile, tablet: tablet),
                  const SizedBox(height: 30),
                  _buildProfileImage(context),
                ],
              )
              : Row(
                children: [
                  Expanded(flex: 5, child: _buildProfileImage(context)),
                  Expanded(
                    flex: 5,
                    child: _buildTextContent(
                      context,
                      mobile: mobile,
                      tablet: tablet,
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildTextContent(
    context, {
    required bool mobile,
    required bool tablet,
  }) {
    return Column(
      crossAxisAlignment:
          mobile || tablet
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              mobile || tablet
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  mobile || tablet
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [AppColors.whiteff, AppColors.mainColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: const Text(
                        'About Me',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteff,
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.mainColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Text(
                        'Who Am I?',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                if (!mobile && !tablet) const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          "I am a professional Flutter developer with expertise in building cross-platform applications. I am passionate about creating engaging and functional user interfaces that deliver seamless experiences. My goal is to leverage my skills to develop innovative, customizable, and sustainable software solutions.",
          style: TextStyle(
            color: Color(0xFFA9A9A9),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 30),

        // Skill section title
        const Text(
          "Technical Skills",
          style: TextStyle(
            color: AppColors.whiteff,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),

        // Enhanced skill cards
        _buildSkillsGrid(mobile, tablet),
        const SizedBox(height: 40),
        _buildResumeButton(),
      ],
    );
  }

  Widget _buildSkillsGrid(bool mobile, bool tablet) {
    final skills = [
      {
        "name": "Flutter",
        "icon": "assets/svg/flutter_icon.svg",
        "isSvg": true,
        "proficiency": 1.0,
      },
      {
        "name": "Dart",
        "icon": "assets/svg/dartlang_icon.svg",
        "isSvg": true,
        "proficiency": 1.0,
      },
      {
        "name": "Bloc",
        "icon": "assets/images/bloc_icon.png",
        "isSvg": false,
        "proficiency": 1.0,
      },
      {
        "name": "Firebase",
        "icon": "assets/svg/firebase_icon.svg",
        "isSvg": true,
        "proficiency": 0.85,
      },
      {
        "name": "Git",
        "icon": "assets/svg/git_icon.svg",
        "isSvg": true,
        "proficiency": 1.0,
      },
      {
        "name": "Android Studio",
        "icon": "assets/images/androidstudio_icon.png",
        "isSvg": false,
        "proficiency": 1.0,
      },
      {
        "name": "XCode",
        "icon": "assets/images/xcode_icon.png",
        "isSvg": false,
        "proficiency": 1.0,
      },
    ];

    return Wrap(
      spacing: mobile || tablet ? 10 : 15,
      runSpacing: mobile || tablet ? 10 : 15,
      alignment: mobile || tablet ? WrapAlignment.center : WrapAlignment.start,
      children: skills.map((skill) => _buildSkillCard(skill)).toList(),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill) {
    final RxBool isHovered = false.obs;

    return Obx(
      () => MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color:
                isHovered.value
                    ? AppColors.mainColor.withValues(alpha: 0.1)
                    : AppColors.scaffoolBgColorDark,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color:
                  isHovered.value
                      ? AppColors.mainColor
                      : AppColors.mainColor.withValues(alpha: 0.3),
              width: isHovered.value ? 2 : 1,
            ),
            boxShadow:
                isHovered.value
                    ? [
                      BoxShadow(
                        color: AppColors.mainColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ]
                    : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              skill["isSvg"]
                  ? SvgPicture.asset(
                    skill["icon"],
                    height: isHovered.value ? 40 : 35,
                    width: isHovered.value ? 40 : 35,
                  )
                  : Image.asset(
                    skill["icon"],
                    height: isHovered.value ? 40 : 35,
                    width: isHovered.value ? 40 : 35,
                  ),
              const SizedBox(height: 10),
              Text(
                skill["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      isHovered.value
                          ? AppColors.mainColor
                          : const Color(0xFFA9A9A9),
                  fontSize: 16,
                  fontWeight:
                      isHovered.value ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 80,
                height: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: skill["proficiency"],
                    backgroundColor: AppColors.mainColorLight,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isHovered.value
                          ? AppColors.mainColor
                          : AppColors.mainColor.withValues(alpha: 0.7),
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

  Widget _buildProfileImage(context) {
    final tablet = Responsive.isTablet(context);
    final mobile = Responsive.isMobile(context);

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
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final sineValue = math.sin(
                _animationController.value * math.pi * 2,
              );
              return Transform.translate(
                offset: Offset(0, sineValue * 5), // Subtle floating animation
                child: Container(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor.withValues(alpha: 0.5),
                        blurRadius:
                            20 + (sineValue.abs() * 10), // Pulsating glow
                        offset: const Offset(-5, -5),
                        spreadRadius: 1,
                      ),
                    ],
                    border: const Border(
                      top: BorderSide(color: AppColors.mainColor, width: 5),
                      left: BorderSide(color: AppColors.mainColor, width: 5),
                    ),
                  ),
                  child: Container(
                    height:
                        (mobile || tablet)
                            ? imageHeight
                            : _profileImageAnimation.value * imageHeight,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(5, 5),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildResumeButton() {
    final RxBool isHovered = false.obs;

    return Obx(
      () => MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: controller.downloadResume,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            decoration: BoxDecoration(
              color: isHovered.value ? AppColors.mainColor : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.mainColor, width: 2),
              boxShadow:
                  isHovered.value
                      ? [
                        BoxShadow(
                          color: AppColors.mainColor.withValues(alpha: 0.5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                      : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isHovered.value
                      ? Icons.file_download_done
                      : Icons.download_rounded,
                  color:
                      isHovered.value ? AppColors.black00 : AppColors.mainColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  "Download Resume",
                  style: TextStyle(
                    color:
                        isHovered.value
                            ? AppColors.black00
                            : AppColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
