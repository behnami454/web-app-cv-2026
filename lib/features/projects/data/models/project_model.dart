import 'package:behnam_portfolio/features/projects/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.title,
    required super.shortDescription,
    super.problem,
    super.solution,
    super.architecture,
    super.challenges,
    super.impact,
    required super.tech,
    super.highlights,
    required super.image,
    super.githubUrl,
    super.liveUrl,
    super.isFeatured,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      problem: json['problem'],
      solution: json['solution'],
      architecture: json['architecture'],
      challenges: json['challenges'],
      impact: json['impact'],
      tech: json['tech'] != null ? List<String>.from(json['tech']) : const [],
      highlights: json['highlights'] != null ? List<String>.from(json['highlights']) : const [],
      image: json['image'] ?? '',
      githubUrl: json['githubUrl'],
      liveUrl: json['liveUrl'],
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}
