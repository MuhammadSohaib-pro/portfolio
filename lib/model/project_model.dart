import 'package:flutter/material.dart';

class ProjectModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final List<Widget> usedTechnologies;
  final String iosLink;
  final String androidLink;
  final bool haveIOSExploreLink;
  final bool haveAndroidExploreLink;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.usedTechnologies,
    required this.iosLink,
    required this.androidLink,
    required this.haveIOSExploreLink,
    required this.haveAndroidExploreLink,
  });
}
