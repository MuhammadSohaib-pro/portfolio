import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';

class ContactSection extends StatelessWidget {
  ContactSection({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final bool isTabletOrMobile =
        Responsive.isTablet(context) || Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTabletOrMobile ? MySize.size20 : MySize.size50,
        vertical: isTabletOrMobile ? MySize.size20 : MySize.size70,
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: MySize.size40),
          _buildMainContent(context, isTabletOrMobile),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Contact',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.whiteff,
        fontSize: MySize.size42,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isTabletOrMobile) {
    return MouseRegion(
      onEnter: (_) {
        controller.isHoveringForward.value = true;
        controller.isSwapped.value = true;
      },
      child: Row(
        children: [
          if (!isTabletOrMobile) _buildAnimatedContainer(),
          Expanded(
            child: isTabletOrMobile
                ? _buildContactForm(isTabletOrMobile)
                : _buildAnimatedContactForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedContainer() {
    return Obx(
      () => Expanded(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(
            controller.isSwapped.value
                ? (controller.isHoveringForward.value
                    ? MySize.safeWidth / 2.7
                    : -MySize.safeWidth / 2.7)
                : 0,
            0,
            0,
          ),
          height: 600,
          decoration: BoxDecoration(
            borderRadius: controller.isSwapped.value
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
          ),
          alignment: Alignment.center,
          child: _buildRichText(),
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Let's discuss \non something ",
            style: TextStyle(
              color: const Color(0xFFEEEEEE),
              fontSize: MySize.size40,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: 'cool ',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: MySize.size40,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '\ntogether',
            style: TextStyle(
              color: const Color(0xFFEEEEEE),
              fontSize: MySize.size40,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(bool isTabletOrMobile) {
    return Container(
      height: 700,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(MySize.size40),
        child: Column(
          crossAxisAlignment: isTabletOrMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Text(
              "I'm interested in...",
              style: TextStyle(
                color: const Color(0xFF151C25),
                fontSize: MySize.size20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            _buildInterestMobileButtons(),
            const Spacer(),
            _buildContactFormFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContactForm() {
    return Obx(() => AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(
            controller.isSwapped.value
                ? (controller.isHoveringForward.value
                    ? -MySize.safeWidth / 2.7
                    : MySize.safeWidth / 2.7)
                : 0,
            0,
            0,
          ),
          height: 600,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: controller.isSwapped.value
                ? const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
          ),
          child: Padding(
            padding: EdgeInsets.all(MySize.size40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I'm interested in...",
                  style: TextStyle(
                    color: const Color(0xFF151C25),
                    fontSize: MySize.size20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                _buildInterestButtons(),
                const Spacer(),
                _buildContactFormFields(),
              ],
            ),
          ),
        ));
  }

  Widget _buildInterestButtons() {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Expanded(child: _buildButton("Flutter UI")),
              SizedBox(width: MySize.size15),
              Expanded(child: _buildButton("Flutter Android")),
            ],
          ),
        ),
        SizedBox(height: MySize.size10),
        Obx(
          () => Row(
            children: [
              Expanded(child: _buildButton("Flutter IOS")),
              SizedBox(width: MySize.size15),
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
          SizedBox(height: MySize.size10),
          SizedBox(
              width: double.infinity, child: _buildButton("Flutter Android")),
          SizedBox(height: MySize.size10),
          SizedBox(width: double.infinity, child: _buildButton("Flutter IOS")),
          SizedBox(height: MySize.size10),
          SizedBox(width: double.infinity, child: _buildButton("Flutter Web")),
        ],
      ),
    );
  }

  Widget _buildButton(String type) {
    bool isSelected = controller.selectedType.value == type;

    return isSelected
        ? ElevatedButton(
            onPressed: () => controller.selectType(type),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: AppColors.mainColor,
              minimumSize: const Size(64, 50),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontSize: MySize.size20,
                color: AppColors.black00,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        : OutlinedButton(
            onPressed: () => controller.selectType(type),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(64, 50),
              side: const BorderSide(
                color: Color(0x4C2E0249),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontSize: MySize.size20,
                color: const Color(0x4C2E0249),
                fontWeight: FontWeight.normal,
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
          _buildTextField(
            controller: controller.nameController,
            labelText: 'Your name',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          SizedBox(height: MySize.size20),
          _buildTextField(
            controller: controller.emailController,
            labelText: 'Your email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          SizedBox(height: MySize.size20),
          _buildTextField(
            controller: controller.messageController,
            labelText: 'Your message',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Message is required';
              }
              return null;
            },
          ),
          SizedBox(height: MySize.size50),
          _buildSendMessageButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: MySize.size16,
          color: AppColors.black00,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black00,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black00,
          ),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: MySize.size16,
        color: AppColors.black00,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSendMessageButton() {
    return ElevatedButton(
      onPressed: controller.sendMessage,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.mainColor,
        minimumSize: const Size(64, 50),
        maximumSize: const Size(300, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/send_icon.svg",
            height: MySize.size20,
            width: MySize.size20,
          ),
          SizedBox(width: MySize.size15),
          Text(
            "Send Message",
            style: TextStyle(
              fontSize: MySize.size20,
              color: AppColors.black00,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
