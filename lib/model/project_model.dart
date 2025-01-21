import 'package:flutter/material.dart';

class ProjectModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final List<Widget> usedTechnologies;
  final String exploreLink;
  final bool haveExploreLink;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.usedTechnologies,
    required this.exploreLink,
    required this.haveExploreLink,
  });
}
