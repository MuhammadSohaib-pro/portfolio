import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';

class Header extends StatelessWidget {
  Header({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final mobile = Responsive.isMobile(context);
    final desktop = Responsive.isDesktop(context);
    return SizedBox(
      height: mobile ? MySize.size100 : MySize.size90,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: mobile ? MySize.size20 : MySize.size15,
          horizontal: mobile ? MySize.size20 : MySize.size0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset("assets/svg/initialLight.svg"),
            if (desktop)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => buildButton('Home')),
                    SizedBox(width: MySize.size10),
                    Obx(() => buildButton('About')),
                    SizedBox(width: MySize.size10),
                    Obx(() => buildButton('Projects')),
                    SizedBox(width: MySize.size10),
                    Obx(() => buildButton('Contact')),
                  ],
                ),
              ),
            if (mobile || tablet)
              Icon(
                Icons.menu_rounded,
                color: AppColors.whiteff,
                size: MySize.size40,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String pageName) {
    bool isSelected = controller.selectedPage.value == pageName;

    return isSelected
        ? ElevatedButton(
            onPressed: () => controller.selectPage(pageName),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppColors.mainColor,
            ),
            child: Text(
              pageName,
              style: const TextStyle(
                color: AppColors.black00,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        : OutlinedButton(
            onPressed: () => controller.selectPage(pageName),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: AppColors.whiteff,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              pageName,
              style: const TextStyle(
                color: Color(0xffFFFFFF),
                fontWeight: FontWeight.normal,
              ),
            ),
          );
  }
}
