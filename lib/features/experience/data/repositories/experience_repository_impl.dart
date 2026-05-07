import 'package:behnam_portfolio/core/error/result.dart';
import 'package:behnam_portfolio/features/experience/data/local_data/experience_local_data_source.dart';
import 'package:behnam_portfolio/features/experience/domain/entities/experience_entity.dart';
import 'package:behnam_portfolio/features/experience/domain/repositories/experience_repository.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceLocalDataSource dataSource;

  const ExperienceRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<ExperienceEntity>>> getExperiences() async {
    try {
      final data = await dataSource.getExperiences();
      return Result.success(data);
    } catch (e) {
      return Result.failure('Failed to load experience');
    }
  }
}
