import 'package:flutter/material.dart';

class NavigationItem {
  const NavigationItem(this.label, this.icon);

  final String label;
  final IconData icon;
}

class SkillCategory {
  const SkillCategory(this.title, this.icon, this.skills);
  final String title;
  final IconData icon;
  final List<String> skills;
}

class Experience {
  const Experience({
    this.company,
    required this.position,
    this.dates,
    required this.project,
    required this.responsibilities,
    required this.technologies,
    required this.achievements,
  });
  final String? company;
  final String position;
  final String? dates;
  final String project;
  final List<String> responsibilities;
  final List<String> technologies;
  final List<String> achievements;
}

class PortfolioProject {
  const PortfolioProject({
    required this.name,
    required this.type,
    required this.description,
    required this.role,
    required this.problem,
    required this.features,
    required this.technologies,
    required this.challenges,
    required this.solutions,
    required this.learnings,
    this.screenshots = const [],
    this.githubUrl = 'YOUR_GITHUB_PROJECT_URL',
    this.demoUrl = 'YOUR_DEMO_OR_PLAY_STORE_URL',
  });
  final String name;
  final String type;
  final String description;
  final String role;
  final String problem;
  final List<String> features;
  final List<String> technologies;
  final List<String> challenges;
  final List<String> solutions;
  final List<String> learnings;
  final List<String> screenshots;
  final String githubUrl;
  final String demoUrl;

  bool get hasGithub => githubUrl.startsWith('https://');
  bool get hasDemo => demoUrl.startsWith('https://');
}
