import 'package:behnam_portfolio/core/error/result.dart';
import 'package:behnam_portfolio/features/projects/domain/entities/project_entity.dart';
import 'package:behnam_portfolio/features/projects/domain/repositories/project_repository.dart';

class GetProjects {
  final ProjectRepository repository;

  GetProjects(this.repository);

  Future<Result<List<ProjectEntity>>> call() {
    return repository.getProjects();
  }
}
