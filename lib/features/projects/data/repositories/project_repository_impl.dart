import 'package:behnam_portfolio/core/error/result.dart';
import 'package:behnam_portfolio/features/projects/data/local_data/project_local_data_source.dart';
import 'package:behnam_portfolio/features/projects/domain/entities/project_entity.dart';
import 'package:behnam_portfolio/features/projects/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectLocalDataSource dataSource;

  const ProjectRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<ProjectEntity>>> getProjects() async {
    try {
      final data = await dataSource.getProjects();
      return Result.success(data);
    } catch (e) {
      return Result.failure('Failed to load projects');
    }
  }
}
