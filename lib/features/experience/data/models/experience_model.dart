import 'package:behnam_portfolio/features/experience/domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.role,
    required super.company,
    required super.period,
    required super.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      period: json['period'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
