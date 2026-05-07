class ProjectEntity {
  final String title;
  final String shortDescription;

  final String? problem;
  final String? solution;
  final String? architecture;
  final String? challenges;
  final String? impact;

  final List<String> tech;

  final List<String> highlights;

  final String image;
  final String? githubUrl;
  final String? liveUrl;
  final bool isFeatured;

  const ProjectEntity({
    required this.title,
    required this.shortDescription,
    this.problem,
    this.solution,
    this.architecture,
    this.challenges,
    this.impact,
    required this.tech,
    this.highlights = const [],
    required this.image,
    this.githubUrl,
    this.liveUrl,
    this.isFeatured = false,
  });
}
