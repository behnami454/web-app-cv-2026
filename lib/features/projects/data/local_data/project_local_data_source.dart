import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:behnam_portfolio/features/projects/data/models/project_model.dart';

class ProjectLocalDataSource {
  const ProjectLocalDataSource();

  Future<List<ProjectModel>> getProjects() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/projects.json');

      final List decoded = json.decode(jsonString);

      return decoded.map((e) => ProjectModel.fromJson(e)).toList();
    } catch (e, stack) {
      return [];
    }
  }
}
