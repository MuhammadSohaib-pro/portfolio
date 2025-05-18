import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTabletOrMobile =
        Responsive.isTablet(context) || Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTabletOrMobile ? 20 : 50,
        vertical: isTabletOrMobile ? 20 : 70,
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 40),
          _buildMainContent(context, isTabletOrMobile),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Section title with animation
        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [
                AppColors.whiteff,
                AppColors.mainColor,
                AppColors.whiteff,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'Get In Touch',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.whiteff,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Subtitle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.mainColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.mainColor.withValues(alpha: 0.3),
            ),
          ),
          child: const Text(
            "Let's work together on your next project",
            style: TextStyle(
              color: Color(0xFFA9A9A9),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context, bool isTabletOrMobile) {
    return MouseRegion(
      onEnter: (_) {
        controller.isHoveringForward.value = true;
        controller.isSwapped.value = true;
      },
      child:
          isTabletOrMobile
              ? _buildMobileContent(context)
              : _buildDesktopContent(context),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(children: [_buildContactForm(true)]);
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildAnimatedContainer(context)),
        Expanded(child: _buildAnimatedContactForm(context)),
      ],
    );
  }

  Widget _buildAnimatedContainer(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final miniDesktop = Responsive.isMiniDesktop(context);

    return Obx(
      () => AnimatedContainer(
        width: MediaQuery.of(context).size.width / 2.5,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          controller.isSwapped.value
              ? (controller.isHoveringForward.value
                  ? ((MediaQuery.of(context).size.width / 2.5) +
                      ((tablet || miniDesktop) ? 20 : 60))
                  : -((MediaQuery.of(context).size.width / 2.5) +
                      ((tablet || miniDesktop) ? 20 : 60)))
              : 0,
          0,
          0,
        ),
        height: 700,
        decoration: BoxDecoration(
          borderRadius:
              controller.isSwapped.value
                  ? const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  )
                  : const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
          image: const DecorationImage(
            image: AssetImage("assets/images/contactbg.png"),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainColor.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            // Text overlay
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.mainColorLight.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.mainColor.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: _buildRichText(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Let's discuss \non something ",
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 40,
              fontWeight: FontWeight.w700,
              height: 1.4,
              letterSpacing: 1.2,
            ),
          ),
          TextSpan(
            text: 'cool ',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 42,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          TextSpan(
            text: '\ntogether',
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 40,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(bool isTabletOrMobile) {
    return Container(
      height: 820,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment:
              isTabletOrMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
          children: [
            const Text(
              "I'm interested in...",
              style: TextStyle(
                color: Color(0xFF151C25),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            isTabletOrMobile
                ? _buildInterestMobileButtons()
                : _buildInterestButtons(),
            const SizedBox(height: 30),
            Expanded(child: _buildContactFormFields()),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContactForm(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final miniDesktop = Responsive.isMiniDesktop(context);

    return Obx(
      () => AnimatedContainer(
        width: MediaQuery.of(context).size.width / 2.5,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          controller.isSwapped.value
              ? (controller.isHoveringForward.value
                  ? -((MediaQuery.of(context).size.width / 2.5) +
                      ((tablet || miniDesktop) ? 20 : 60))
                  : ((MediaQuery.of(context).size.width / 2.5) +
                      ((tablet || miniDesktop) ? 20 : 60)))
              : 0,
          0,
          0,
        ),
        height: 700,
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius:
              controller.isSwapped.value
                  ? const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )
                  : const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "I'm interested in...",
                style: TextStyle(
                  color: Color(0xFF151C25),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              _buildInterestButtons(),
              const SizedBox(height: 15),
              Expanded(child: _buildContactFormFields()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterestButtons() {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Expanded(child: _buildButton("Flutter UI")),
              const SizedBox(width: 15),
              Expanded(child: _buildButton("Flutter Android")),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Row(
            children: [
              Expanded(child: _buildButton("Flutter IOS")),
              const SizedBox(width: 15),
              Expanded(child: _buildButton("Flutter Web")),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInterestMobileButtons() {
    return Obx(
      () => Column(
        children: [
          SizedBox(width: double.infinity, child: _buildButton("Flutter UI")),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: _buildButton("Flutter Android"),
          ),
          const SizedBox(height: 10),
          SizedBox(width: double.infinity, child: _buildButton("Flutter IOS")),
          const SizedBox(height: 10),
          SizedBox(width: double.infinity, child: _buildButton("Flutter Web")),
        ],
      ),
    );
  }

  Widget _buildButton(String type) {
    bool isSelected = controller.selectedType.value == type;
    final RxBool isHovered = false.obs;

    return Obx(
      () => MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child:
              isSelected
                  ? ElevatedButton(
                    onPressed: () => controller.selectType(type),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.mainColor,
                      foregroundColor: AppColors.black00,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: isHovered.value ? 8 : 4,
                      shadowColor: AppColors.mainColor.withValues(alpha: 0.5),
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                  : OutlinedButton(
                    onPressed: () => controller.selectType(type),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(
                        color:
                            isHovered.value
                                ? AppColors.mainColor
                                : const Color(0x4C2E0249),
                        width: isHovered.value ? 2 : 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor:
                          isHovered.value
                              ? AppColors.mainColor.withValues(alpha: 0.1)
                              : Colors.transparent,
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            isHovered.value
                                ? AppColors.mainColor
                                : const Color(0x4C2E0249),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildContactFormFields() {
    return Form(
      key: controller.contactFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedTextField(
            controller: controller.nameController,
            labelText: 'Your name',
            hintText: 'John Doe',
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          _buildAnimatedTextField(
            controller: controller.emailController,
            labelText: 'Your email',
            hintText: 'johndoe@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              } else if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          _buildAnimatedTextField(
            controller: controller.messageController,
            labelText: 'Your message',
            hintText: 'Tell me about your project...',
            prefixIcon: Icons.message_outlined,
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Message is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Center(child: _buildSendMessageButton()),
        ],
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    final RxBool isFocused = false.obs;

    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              isFocused.value
                  ? [
                    BoxShadow(
                      color: AppColors.mainColor.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]
                  : null,
        ),
        child: Focus(
          onFocusChange: (hasFocus) => isFocused.value = hasFocus,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                prefixIcon,
                color: isFocused.value ? AppColors.mainColor : Colors.grey[600],
              ),
              labelStyle: TextStyle(
                fontSize: 16,
                color: isFocused.value ? AppColors.mainColor : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.mainColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.red, width: 2),
              ),
              errorStyle: const TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            validator: validator,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.black00,
              fontWeight: FontWeight.w500,
            ),
            maxLines: maxLines,
          ),
        ),
      ),
    );
  }

  Widget _buildSendMessageButton() {
    final RxBool isHovered = false.obs;

    return Obx(
      () => MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(isHovered.value ? 1.05 : 1.0),
          child: ElevatedButton(
            onPressed: () {
              if (controller.contactFormKey.currentState?.validate() ?? false) {
                controller.sendMessage();
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: AppColors.mainColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              elevation: isHovered.value ? 10 : 4,
              shadowColor: AppColors.mainColor.withValues(alpha: 0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isHovered.value ? Icons.send : Icons.send_outlined,
                  color: AppColors.black00,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  "Send Message",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black00,
                    fontWeight: FontWeight.w600,
                    letterSpacing: isHovered.value ? 1.2 : 1.0,
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
