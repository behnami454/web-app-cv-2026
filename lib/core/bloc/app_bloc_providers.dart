import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/Language/widgets/locale_cubit.dart';
import 'package:behnam_portfolio/core/navigation/navigation_cubit.dart';
import 'package:behnam_portfolio/core/theme/theme_cubit.dart';

class AppBlocProviders extends StatelessWidget {
  const AppBlocProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: child,
    );
  }
}
