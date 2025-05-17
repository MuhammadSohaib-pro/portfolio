import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String exploreIOSLink;
  final String exploreAndroidLink;
  final bool haveIOSExploreLink;
  final bool haveAndroidExploreLink;
  final List<Widget> usedTechnologies;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.usedTechnologies,
    required this.exploreIOSLink,
    required this.exploreAndroidLink,
    required this.haveIOSExploreLink,
    required this.haveAndroidExploreLink,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  final RxBool isHovered = false.obs;
  final RxBool isExpanded = false.obs;

  // For 3D tilt effect
  final RxDouble rotateX = 0.0.obs;
  final RxDouble rotateY = 0.0.obs;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuad,
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

    return Obx(() => isExpanded.value
        ? _buildExpandedView(context)
        : _buildCardView(context, tablet, mobile));
  }

  Widget _buildCardView(BuildContext context, bool tablet, bool mobile) {
    if (mobile || tablet) {
      return _buildStandardCardView(context, tablet, mobile);
    } else {
      return _build3DCardView(context, tablet, mobile);
    }
  }

  Widget _build3DCardView(BuildContext context, bool tablet, bool mobile) {
    return MouseRegion(
      onEnter: (_) {
        isHovered.value = true;
        _animationController.forward();
      },
      onExit: (_) {
        isHovered.value = false;
        rotateX.value = 0;
        rotateY.value = 0;
        _animationController.reverse();
      },
      onHover: (event) {
        // Calculate the tilt based on mouse position
        final RenderBox box = context.findRenderObject() as RenderBox;
        final size = box.size;
        final offset = box.globalToLocal(event.position);

        // Calculate tilt angle (adjust the divisor to control tilt sensitivity)
        final tiltX =
            ((offset.dy - size.height / 2) / (size.height / 2)) * -0.1;
        final tiltY = ((offset.dx - size.width / 2) / (size.width / 2)) * 0.1;

        rotateX.value = tiltX;
        rotateY.value = tiltY;
      },
      child: GestureDetector(
        onTap: () => _showDetailsDialog(context),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(rotateX.value)
                ..rotateY(rotateY.value)
                ..scale(_scaleAnimation.value),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor
                          .withValues(alpha: isHovered.value ? 0.3 : 0.1),
                      blurRadius: isHovered.value ? 20 : 10,
                      offset: const Offset(0, 10),
                      spreadRadius: isHovered.value ? 2 : 0,
                    ),
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColors.mainColorLight,
                  clipBehavior: Clip
                      .antiAlias, // Important for the image to respect the rounded corners
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image and overlay
                      Stack(
                        children: [
                          Hero(
                            tag: 'project-${widget.title}',
                            child: CachedNetworkImage(
                              imageUrl: widget.imageUrl,
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          // Gradient overlay
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColors.mainColorLight,
                                    AppColors.mainColorLight
                                        .withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Hover overlay with animation
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: isHovered.value ? 1.0 : 0.0,
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.mainColor.withValues(alpha: 0.2),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.mainColor
                                            .withValues(alpha: 0.5),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "View Details",
                                        style: TextStyle(
                                          color: AppColors.black00,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.black00,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Card content
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.whiteff,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFFA9A9A9),
                                fontSize: 16,
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Technologies Used',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: widget.usedTechnologies.map((tech) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: tech,
                                  );
                                }).toList(),
                              ),
                            ),
                            if (widget.haveIOSExploreLink ||
                                widget.haveAndroidExploreLink)
                              const SizedBox(height: 15),
                            if (widget.haveIOSExploreLink ||
                                widget.haveAndroidExploreLink)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.haveIOSExploreLink)
                                    _buildStoreButton(
                                      "assets/svg/app_store.svg",
                                      widget.exploreIOSLink,
                                    ),
                                  SizedBox(
                                    width: (widget.haveIOSExploreLink &&
                                            widget.haveAndroidExploreLink)
                                        ? 16
                                        : 0,
                                  ),
                                  if (widget.haveAndroidExploreLink)
                                    _buildStoreButton(
                                      "assets/svg/play_store.svg",
                                      widget.exploreAndroidLink,
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStandardCardView(
      BuildContext context, bool tablet, bool mobile) {
    return MouseRegion(
      onEnter: (_) {
        isHovered.value = true;
        _animationController.forward();
      },
      onExit: (_) {
        isHovered.value = false;
        _animationController.reverse();
      },
      child: GestureDetector(
        onTap: () => _showDetailsDialog(context),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor
                          .withValues(alpha: isHovered.value ? 0.3 : 0.1),
                      blurRadius: isHovered.value ? 20 : 10,
                      offset: const Offset(0, 10),
                      spreadRadius: isHovered.value ? 2 : 0,
                    ),
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColors.mainColorLight,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Hero(
                            tag: 'project-${widget.title}',
                            child: CachedNetworkImage(
                              imageUrl: widget.imageUrl,
                              height: (mobile || tablet) ? 225 : 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColors.mainColorLight,
                                    AppColors.mainColorLight
                                        .withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // View details button on hover
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: isHovered.value ? 1.0 : 0.0,
                            child: Container(
                              height: (mobile || tablet) ? 225 : 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.mainColor.withValues(alpha: 0.2),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.mainColor
                                            .withValues(alpha: 0.5),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "View Details",
                                        style: TextStyle(
                                          color: AppColors.black00,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.black00,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.whiteff,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFFA9A9A9),
                                fontSize: 16,
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Technologies Used',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: widget.usedTechnologies.map((tech) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    child: tech,
                                  );
                                }).toList(),
                              ),
                            ),
                            if (widget.haveIOSExploreLink ||
                                widget.haveAndroidExploreLink)
                              const SizedBox(height: 20),
                            if (widget.haveIOSExploreLink ||
                                widget.haveAndroidExploreLink)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.haveIOSExploreLink)
                                    _buildStoreButton(
                                      "assets/svg/app_store.svg",
                                      widget.exploreIOSLink,
                                    ),
                                  SizedBox(
                                    width: (widget.haveIOSExploreLink &&
                                            widget.haveAndroidExploreLink)
                                        ? 20
                                        : 0,
                                  ),
                                  if (widget.haveAndroidExploreLink)
                                    _buildStoreButton(
                                      "assets/svg/play_store.svg",
                                      widget.exploreAndroidLink,
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: _buildExpandedView(context),
        );
      },
    );
  }

  Widget _buildExpandedView(BuildContext context) {
    final tablet = Responsive.isTablet(context);
    final mobile = Responsive.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Blurred background
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.7),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
              ),
            ),
            // Project detail card
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: constraints.maxWidth * 0.85,
                      height: constraints.maxHeight * 0.85,
                      decoration: BoxDecoration(
                        color: AppColors.mainColorLight,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainColor.withValues(alpha: 0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Image section with close button
                          Stack(
                            children: [
                              Hero(
                                tag: 'project-${widget.title}',
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.imageUrl,
                                    height: mobile
                                        ? 250
                                        : tablet
                                            ? 350
                                            : 450,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              // Gradient overlay
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                height: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.mainColorLight
                                            .withValues(alpha: 0.7),
                                        AppColors.mainColorLight
                                            .withValues(alpha: 0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Close button
                              Positioned(
                                top: 20,
                                right: 20,
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.mainColor
                                              .withValues(alpha: 0.5),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: AppColors.black00,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Content section
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title with glass effect
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColors.mainColor
                                            .withValues(alpha: 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      widget.title,
                                      style: const TextStyle(
                                        color: AppColors.whiteff,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Description
                                  const Text(
                                    'About Project',
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    widget.description,
                                    style: const TextStyle(
                                      color: Color(0xFFA9A9A9),
                                      fontSize: 18,
                                      height: 1.6,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // Technologies section
                                  const Text(
                                    'Technologies Used',
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTechnologiesGrid(),

                                  if (widget.haveIOSExploreLink ||
                                      widget.haveAndroidExploreLink)
                                    const SizedBox(height: 30),

                                  if (widget.haveIOSExploreLink ||
                                      widget.haveAndroidExploreLink)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Available On',
                                          style: TextStyle(
                                            color: AppColors.mainColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        _buildStoreButtonsRow(mobile, tablet),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTechnologiesGrid() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: widget.usedTechnologies
          .map(
            (tech) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.scaffoolBgColorDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.mainColor.withValues(alpha: 0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainColor.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: SizedBox(
                height: 40,
                width: 40,
                child: tech,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStoreButtonsRow(bool mobile, bool tablet) {
    if (mobile || tablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.haveIOSExploreLink)
            _buildExpandedStoreButton(
              "App Store",
              "assets/svg/app_store.svg",
              widget.exploreIOSLink,
            ),
          if (widget.haveIOSExploreLink && widget.haveAndroidExploreLink)
            const SizedBox(height: 16),
          if (widget.haveAndroidExploreLink)
            _buildExpandedStoreButton(
              "Play Store",
              "assets/svg/play_store.svg",
              widget.exploreAndroidLink,
            ),
        ],
      );
    } else {
      return Row(
        children: [
          if (widget.haveIOSExploreLink)
            Expanded(
              child: _buildExpandedStoreButton(
                "App Store",
                "assets/svg/app_store.svg",
                widget.exploreIOSLink,
              ),
            ),
          if (widget.haveIOSExploreLink && widget.haveAndroidExploreLink)
            const SizedBox(width: 16),
          if (widget.haveAndroidExploreLink)
            Expanded(
              child: _buildExpandedStoreButton(
                "Play Store",
                "assets/svg/play_store.svg",
                widget.exploreAndroidLink,
              ),
            ),
        ],
      );
    }
  }

  Widget _buildStoreButton(String iconPath, String link) {
    final RxBool isButtonHovered = false.obs;

    return Obx(() => MouseRegion(
          onEnter: (_) => isButtonHovered.value = true,
          onExit: (_) => isButtonHovered.value = false,
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
                  colors: isButtonHovered.value
                      ? [
                          AppColors.mainColor,
                          AppColors.mainColor.withValues(alpha: 0.8)
                        ]
                      : [const Color(0xFF343236), const Color(0xFF38343F)],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.mainColor,
                  width: isButtonHovered.value ? 2 : 1,
                ),
                boxShadow: isButtonHovered.value
                    ? [
                        BoxShadow(
                          color: AppColors.mainColor.withValues(alpha: 0.4),
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
                  isButtonHovered.value ? AppColors.black00 : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildExpandedStoreButton(String text, String iconPath, String link) {
    final RxBool isButtonHovered = false.obs;

    return Obx(() => MouseRegion(
          onEnter: (_) => isButtonHovered.value = true,
          onExit: (_) => isButtonHovered.value = false,
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: isButtonHovered.value
                    ? AppColors.mainColor
                    : AppColors.scaffoolBgColorDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.mainColor,
                  width: isButtonHovered.value ? 2 : 1,
                ),
                boxShadow: isButtonHovered.value
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      isButtonHovered.value ? AppColors.black00 : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      color: isButtonHovered.value
                          ? AppColors.black00
                          : AppColors.whiteff,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
