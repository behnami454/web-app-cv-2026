import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/navigation/navigation_cubit.dart';
import 'package:behnam_portfolio/core/utils/scroll_service.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';

class NavigationHelper {
  NavigationHelper._();

  static void navigate(BuildContext context, AppSectionType section) {
    context.read<NavigationCubit>().setSection(section);

    ScrollService.scrollTo(section);
  }
}
