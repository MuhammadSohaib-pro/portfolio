import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find();
  late AnimationController _animationController;
  late Animation<double> _nameAnimation;
  late Animation<double> _subtitleAnimation;
  late Animation<double> _descriptionAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _nameAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _subtitleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
      ),
    );

    _descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile || tablet ? 20 : 50,
        vertical: mobile || tablet ? 20 : 70,
      ),
      child: tablet || mobile
          ? Column(
              children: [
                _buildTextContent(context),
                const SizedBox(height: 30),
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
        FadeTransition(
          opacity: _nameAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
            ).animate(_nameAnimation),
            child: const Text(
              'Muhammad',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.whiteff,
                fontSize: 40,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: _nameAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.2, 0),
              end: Offset.zero,
            ).animate(_nameAnimation),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    AppColors.whiteff,
                    AppColors.mainColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Text(
                'Sohaib',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.whiteff,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeTransition(
          opacity: _subtitleAnimation,
          child: Row(
            children: [
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Flutter Developer',
                    textStyle: const TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Mobile App Expert',
                    textStyle: const TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'UI/UX Enthusiast',
                    textStyle: const TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        FadeTransition(
          opacity: _descriptionAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(_descriptionAnimation),
            child: const SizedBox(
              width: 594,
              child: Text(
                'I specialize in building immersive user experiences with Flutter, leveraging '
                'its powerful UI toolkit to bring your vision to life across platforms. '
                'Additionally, I have expertise in geoinformatics, where I excel at utilizing '
                'spatial data to unlock actionable insights.',
                style: TextStyle(
                  color: Color(0xFFA9A9A9),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeTransition(
          opacity: _buttonAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(_buttonAnimation),
            child: Row(
              children: [
                _buildAnimatedButton(),
                const SizedBox(width: 20),
                _buildAvailabilityIndicator(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedButton() {
    final RxBool isHovered = false.obs;

    return Obx(() => MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: GestureDetector(
            onTap: () => controller.selectPage("Contact"),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color:
                    isHovered.value ? AppColors.mainColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.mainColor, width: 2),
                boxShadow: isHovered.value
                    ? [
                        BoxShadow(
                          color: AppColors.mainColor.withValues(alpha: 0.4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Get in Touch",
                    style: TextStyle(
                      color: isHovered.value
                          ? AppColors.black00
                          : AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: isHovered.value
                        ? AppColors.black00
                        : AppColors.mainColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildAvailabilityIndicator() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer pulsing circle
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Container(
                  height: 20 + (value * 10),
                  width: 20 + (value * 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor
                        .withValues(alpha: (0.1 * (1 - value).clamp(0.0, 1.0))),
                  ),
                );
              },
              onEnd: () {
                setState(() {}); // restart animation
              },
            ),
            // Middle pulsing circle
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Container(
                  height: 18 + (value * 6),
                  width: 18 + (value * 6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor
                        .withValues(alpha: (0.2 * (1 - value).clamp(0.0, 1.0))),
                  ),
                );
              },
              onEnd: () {
                setState(() {}); // restart animation
              },
            ),
            // Core circle
            Container(
              height: 15,
              width: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        const Text(
          'Available now',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF888888),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildImageContentMobile(context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 10 : 20,
          vertical: 10,
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _nameAnimation.value,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: math.sin(_animationController.value * math.pi * 2) *
                        0.03,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow effect behind image
                        Container(
                          height: Responsive.isMobile(context) ? 260 : 360,
                          width: Responsive.isMobile(context) ? 260 : 360,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppColors.mainColor.withValues(alpha: 0.3),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        ColorFiltered(
                          colorFilter: const ColorFilter.matrix(<double>[
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]),
                          child: Container(
                            height: Responsive.isMobile(context) ? 250 : 350,
                            width: Responsive.isMobile(context) ? 250 : 350,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/profile-pic.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color:
                                    AppColors.mainColor.withValues(alpha: 0.5),
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
