import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:behnam_portfolio/features/experience/data/models/experience_model.dart';

class ExperienceLocalDataSource {
  const ExperienceLocalDataSource();

  Future<List<ExperienceModel>> getExperiences() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/experiences.json');

      final List decoded = json.decode(jsonString);

      return decoded.map((e) => ExperienceModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load experiences: $e');
    }
  }
}
