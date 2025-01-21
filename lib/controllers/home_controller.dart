import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/model/project_model.dart';
import 'dart:html' as html;

class HomeController extends GetxController {
  GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  List<ProjectModel> projectList = <ProjectModel>[].obs;
  var selectedPage = 'Home'.obs;
  var selectedType = 'Flutter UI'.obs;
  var isSwapped = false.obs;
  var isHoveringForward = true.obs;

  final ScrollController scrollController = ScrollController();

  final homekey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void onInit() {
    initializedList();
    super.onInit();
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void selectPage(String page) {
    selectedPage.value = page;
    switch (page) {
      case 'Home':
        scrollToSection(homekey);
        break;
      case 'About':
        scrollToSection(aboutKey);
        break;
      case 'Projects':
        scrollToSection(projectKey);
        break;
      case 'Contact':
        scrollToSection(contactKey);
        break;
      default:
        scrollController.animateTo(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
    }
  }

  void selectType(String type) {
    selectedType.value = type;
  }

  sendMessage() {
    if (contactFormKey.currentState!.validate()) {}
  }

  void downloadResume() {
    const String url = 'assets/Muhammad%20Sohaib%20Flutter.pdf';
    html.AnchorElement(href: url)
      ..setAttribute('download', 'Muhammad Sohaib Flutter.pdf')
      ..click();
  }

  initializedList() {
    projectList.addAll([
      ProjectModel(
        id: 1,
        title: "MotorCut",
        description:
            "MotorCut photo editing app is the ultimate tool for car enthusiasts, dealers, and photographers! Our app is designed to make your car photo editing experience seamless and professional, allowing you to create stunning visuals easily.",
        imageUrl: "assets/images/motorcut.png",
        usedTechnologies: [
          SvgPicture.asset(
            "assets/svg/flutter_icon.svg",
            height: 24,
            width: 24,
          ),
          SvgPicture.asset(
            "assets/svg/dartlang_icon.svg",
            height: 24,
            width: 24,
          ),
          SvgPicture.asset(
            "assets/svg/firebase_icon.svg",
            height: 24,
            width: 24,
          ),
          Image.asset(
            "assets/images/restapi_icon.png",
            height: 24,
            width: 24,
          ),
        ],
        exploreLink:
            "https://apps.apple.com/pk/app/motorcut-mobile/id6633439138?platform=iphone",
        haveExploreLink: true,
      ),
      ProjectModel(
        id: 2,
        title: "Rent N Roam",
        description:
            "Renting a car through Rent n Roam is just a tap away. Our verified profiles make it easy to find the perfect vehicle, offering peace of mind and 24/7 support from our team. Explore our extensive inventory and enjoy unbeatable prices – rent your ideal car today!",
        imageUrl: "assets/images/rentnroam.png",
        usedTechnologies: [
          SvgPicture.asset(
            "assets/svg/flutter_icon.svg",
            height: 24,
            width: 24,
          ),
          SvgPicture.asset(
            "assets/svg/dartlang_icon.svg",
            height: 24,
            width: 24,
          ),
          SvgPicture.asset(
            "assets/svg/firebase_icon.svg",
            height: 24,
            width: 24,
          ),
          Image.asset(
            "assets/images/restapi_icon.png",
            height: 24,
            width: 24,
          ),
        ],
        exploreLink:
            "https://play.google.com/store/apps/details?id=com.plandstudios.rent_n_roam",
        haveExploreLink: true,
      ),
      ProjectModel(
        id: 3,
        title: "Route Master",
        description:
            "Route Master is the ultimate mobile app for vehicle owners, designed to work seamlessly on both Apple and Android devices. It offers an all-in-one solution to manage vehicles and drivers, ensuring smooth operations through real-time tracking, email updates, and communication.",
        imageUrl: "assets/images/routemaster.png",
        usedTechnologies: [
          SvgPicture.asset(
            "assets/svg/flutter_icon.svg",
            height: 24,
            width: 24,
          ),
          SvgPicture.asset(
            "assets/svg/dartlang_icon.svg",
            height: 24,
            width: 24,
          ),
          SvgPicture.asset(
            "assets/svg/supabase_icon.svg",
            height: 24,
            width: 24,
          ),
        ],
        exploreLink: "",
        haveExploreLink: false,
      ),
      ProjectModel(
        id: 3,
        title: "Falcon Esports",
        description:
            "Falcon Esport lets users complete quests, earn points, and redeem rewards, with seamless Twitch integration for tracking watch time. Admins can manage products, events, and quests, creating an engaging experience for all.",
        imageUrl: "assets/images/falconesport.png",
        usedTechnologies: [
          SvgPicture.asset(
            "assets/svg/flutter_icon.svg",
            height: 24,
            width: 24,
          ),
          SvgPicture.asset(
            "assets/svg/dartlang_icon.svg",
            height: 24,
            width: 24,
          ),
        ],
        exploreLink: "",
        haveExploreLink: false,
      ),
    ]);
  }
}
