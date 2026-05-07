import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/features/projects/domain/entities/project_entity.dart';
import 'package:behnam_portfolio/features/projects/domain/usecases/get_projects.dart';

enum ProjectsStatus { initial, success, failure }

class ProjectsState {
  final ProjectsStatus status;
  final List<ProjectEntity> all;
  final List<ProjectEntity> filtered;
  final String? activeFilter;
  final int? expandedIndex;
  final String? error;

  const ProjectsState({
    this.status = ProjectsStatus.initial,
    this.all = const [],
    this.filtered = const [],
    this.activeFilter,
    this.expandedIndex,
    this.error,
  });

  ProjectsState copyWith({
    ProjectsStatus? status,
    List<ProjectEntity>? all,
    List<ProjectEntity>? filtered,
    String? activeFilter,
    int? expandedIndex,
    String? error,
  }) {
    return ProjectsState(
      status: status ?? this.status,
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      activeFilter: activeFilter,
      expandedIndex: expandedIndex,
      error: error,
    );
  }
}

class ProjectsCubit extends Cubit<ProjectsState> {
  final GetProjects getProjects;

  ProjectsCubit(this.getProjects) : super(const ProjectsState());

  Future<void> load() async {
    final result = await getProjects();

    if (result.isSuccess) {
      final projects = result.data!;

      emit(state.copyWith(
        status: ProjectsStatus.success,
        all: projects,
        filtered: projects,
      ));
    } else {
      emit(state.copyWith(
        status: ProjectsStatus.failure,
        error: result.error,
      ));
    }
  }

  void filter(String tech) {
    final filtered = state.all.where((p) => p.tech.contains(tech)).toList();

    emit(state.copyWith(
      filtered: filtered,
      activeFilter: tech,
    ));
  }

  void clearFilter() {
    emit(state.copyWith(
      filtered: state.all,
      activeFilter: null,
    ));
  }

  void toggleExpand(int index) {
    emit(state.copyWith(
      expandedIndex: state.expandedIndex == index ? null : index,
    ));
  }
}
