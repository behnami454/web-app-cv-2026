import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/features/experience/domain/entities/experience_entity.dart';
import 'package:behnam_portfolio/features/experience/domain/usecases/get_experiences.dart';

enum ExperienceStatus { initial, success, failure }

class ExperienceState {
  final ExperienceStatus status;
  final List<ExperienceEntity> experiences;
  final String? error;

  const ExperienceState({
    this.status = ExperienceStatus.initial,
    this.experiences = const [],
    this.error,
  });

  ExperienceState copyWith({
    ExperienceStatus? status,
    List<ExperienceEntity>? experiences,
    String? error,
  }) {
    return ExperienceState(
      status: status ?? this.status,
      experiences: experiences ?? this.experiences,
      error: error,
    );
  }
}

class ExperienceCubit extends Cubit<ExperienceState> {
  final GetExperiences getExperiences;

  ExperienceCubit(this.getExperiences) : super(const ExperienceState());

  Future<void> load() async {
    final result = await getExperiences();

    if (result.isSuccess) {
      emit(state.copyWith(
        status: ExperienceStatus.success,
        experiences: result.data!,
      ));
    } else {
      emit(state.copyWith(
        status: ExperienceStatus.failure,
        error: result.error,
      ));
    }
  }
}
