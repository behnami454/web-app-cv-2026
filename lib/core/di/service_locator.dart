import 'package:get_it/get_it.dart';
import 'package:behnam_portfolio/core/utils/file_downloader.dart';
import 'package:behnam_portfolio/core/utils/file_downloader_web.dart';
import 'package:behnam_portfolio/features/experience/data/repositories/experience_repository_impl.dart';
import 'package:behnam_portfolio/features/experience/domain/repositories/experience_repository.dart';
import 'package:behnam_portfolio/features/experience/domain/usecases/get_experiences.dart';
import 'package:behnam_portfolio/features/projects/data/local_data/project_local_data_source.dart';
import 'package:behnam_portfolio/features/projects/data/repositories/project_repository_impl.dart';
import 'package:behnam_portfolio/features/projects/domain/repositories/project_repository.dart';
import 'package:behnam_portfolio/features/projects/domain/usecases/get_projects.dart';

import '../../features/experience/data/local_data/experience_local_data_source.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton(() => ProjectLocalDataSource());
  getIt.registerLazySingleton(() => ExperienceLocalDataSource());

  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<ExperienceRepository>(
    () => ExperienceRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetProjects(getIt()));
  getIt.registerLazySingleton(() => GetExperiences(getIt()));

  getIt.registerLazySingleton<FileDownloader>(
    () => WebFileDownloader(),
  );
}
