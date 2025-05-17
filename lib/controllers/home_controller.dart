import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'package:portfolio/model/project_model.dart';

class HomeController extends GetxController {
  var isProgrammaticScrolling = false.obs;
  var isScrollIndicatorHovered = false.obs;
  var isScrollIndicatorVisible = true.obs;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupScrollListener();
    });

    super.onInit();
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      // Skip scroll updates during programmatic scrolling
      if (isProgrammaticScrolling.value) return;
      // Get the current scroll position
      final double offset = scrollController.offset;

      // Safely get positions of each section
      final double aboutPosition = getWidgetPosition(aboutKey);
      final double projectPosition = getWidgetPosition(projectKey);
      final double contactPosition = getWidgetPosition(contactKey);

      // Update the selected page based on scroll position
      if (aboutPosition != -1 && offset < aboutPosition) {
        isSwapped.value = false;
        selectedPage.value = 'Home';
      } else if (projectPosition != -1 && offset < projectPosition) {
        selectedPage.value = 'About';
        isSwapped.value = false;
      } else if (contactPosition != -1 && offset < contactPosition) {
        selectedPage.value = 'Projects';
        isSwapped.value = false;
      } else if (contactPosition != -1 && offset >= contactPosition) {
        selectedPage.value = 'Contact';
      }
    });
  }

// Helper method to safely get the position of a widget
  double getWidgetPosition(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return -1;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero).dy;
    return position;
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      // Set flag before programmatic scrolling
      isProgrammaticScrolling.value = true;

      Scrollable.ensureVisible(context,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut)
          .then((_) {
        // Reset flag after scrolling completes
        isProgrammaticScrolling.value = false;
      });
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
        // Set flag before programmatic scrolling
        isProgrammaticScrolling.value = true;

        scrollController
            .animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut)
            .then((_) {
          // Reset flag after scrolling completes
          isProgrammaticScrolling.value = false;
        });
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
        imageUrl:
            "https://lh3.googleusercontent.com/d/1gcBEgVo144grIcuAmIMEbjGcQw4JVdZZ",
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
        iosLink:
            "https://apps.apple.com/pk/app/motorcut-mobile/id6633439138?platform=iphone",
        androidLink:
            "https://play.google.com/store/apps/details?id=com.cortech.motorcut",
        haveIOSExploreLink: true,
        haveAndroidExploreLink: true,
      ),
      ProjectModel(
        id: 2,
        title: "Rent N Roam",
        description:
            "Renting a car through Rent n Roam is just a tap away. Our verified profiles make it easy to find the perfect vehicle, offering peace of mind and 24/7 support from our team. Explore our extensive inventory and enjoy unbeatable prices – rent your ideal car today!",
        imageUrl:
            "https://lh3.googleusercontent.com/d/1oXJ0g1THog9QB2pSZ8JK2ce6W0q_fTxp",
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
        iosLink: "",
        androidLink: "",
        haveIOSExploreLink: false,
        haveAndroidExploreLink: false,
      ),
      ProjectModel(
        id: 3,
        title: "Route Master",
        description:
            "Route Master is the ultimate mobile app for vehicle owners, designed to work seamlessly on both Apple and Android devices. It offers an all-in-one solution to manage vehicles and drivers, ensuring smooth operations through real-time tracking, email updates, and communication.",
        imageUrl:
            "https://lh3.googleusercontent.com/d/1cFh-Uat-DPcK8h3BU7mtAqnLyrjhBzY6",
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
        iosLink: "",
        androidLink: "",
        haveIOSExploreLink: false,
        haveAndroidExploreLink: false,
      ),
      ProjectModel(
        id: 4,
        title: "Falcon Esports",
        description:
            "Falcon Esport lets users complete quests, earn points, and redeem rewards, with seamless Twitch integration for tracking watch time. Admins can manage products, events, and quests, creating an engaging experience for all.",
        imageUrl:
            "https://lh3.googleusercontent.com/d/1AxINSWN9pNwN4qdNxiTghDJZj3xEio4k",
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
        iosLink: "",
        androidLink: "",
        haveIOSExploreLink: false,
        haveAndroidExploreLink: false,
      ),
      ProjectModel(
        id: 5,
        title: "Waleemah - Owner",
        description:
            "Waleema Owner is a powerful app for restaurant owners to manage their main operations and multiple branches from one platform. It allows you to create a restaurant profile, assign managers with specific roles, and monitor performance in real time. The app ensures full control for owners, while Waleema Manager offers limited features for branch-level use.",
        imageUrl:
            "https://lh3.googleusercontent.com/d/10rTpKYMKdOy_FeNEm9ICO7GNKhtB6Tk8",
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
        ],
        iosLink: "https://apps.apple.com/pk/app/waleemah-owner/id6738472485",
        androidLink: "",
        haveIOSExploreLink: true,
        haveAndroidExploreLink: false,
      ),
      ProjectModel(
        id: 6,
        title: "Waleemah",
        description:
            "Our app is your go-to platform for discovering and enjoying delicious food, whether at home or dining out. Easily browse top-rated restaurants, place customized orders for delivery, pickup, or dine-in, and receive personalized recommendations. Satisfy your cravings with just a few taps.",
        imageUrl:
            "https://lh3.googleusercontent.com/d/1HvDAdFeXPZurwlNSZcZBJItcEQLRW7zW",
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
        ],
        iosLink:
            "https://apps.apple.com/pk/app/waleemah-%D9%88%D9%84%D9%8A%D9%85%D8%A9/id6738483173",
        androidLink: "",
        haveIOSExploreLink: true,
        haveAndroidExploreLink: false,
      ),
    ]);
  }
}
