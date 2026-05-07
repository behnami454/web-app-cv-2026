import 'package:behnam_portfolio/core/error/result.dart';
import 'package:behnam_portfolio/features/experience/domain/entities/experience_entity.dart';

abstract class ExperienceRepository {
  Future<Result<List<ExperienceEntity>>> getExperiences();
}
