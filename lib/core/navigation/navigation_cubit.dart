import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';

class NavigationCubit extends Cubit<AppSectionType> {
  NavigationCubit() : super(AppSectionType.home);

  void setSection(AppSectionType section) {
    if (state != section) {
      emit(section);
    }
  }
}
