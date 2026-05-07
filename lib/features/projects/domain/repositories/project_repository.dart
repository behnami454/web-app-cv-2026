import 'package:behnam_portfolio/core/error/result.dart';
import 'package:behnam_portfolio/features/projects/domain/entities/project_entity.dart';

abstract class ProjectRepository {
  Future<Result<List<ProjectEntity>>> getProjects();
}
