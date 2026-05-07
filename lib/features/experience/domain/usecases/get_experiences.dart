import 'package:behnam_portfolio/core/error/result.dart';
import 'package:behnam_portfolio/features/experience/domain/entities/experience_entity.dart';
import 'package:behnam_portfolio/features/experience/domain/repositories/experience_repository.dart';

class GetExperiences {
  final ExperienceRepository repository;

  GetExperiences(this.repository);

  Future<Result<List<ExperienceEntity>>> call() {
    return repository.getExperiences();
  }
}
