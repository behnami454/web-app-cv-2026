import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/di/service_locator.dart';
import 'package:behnam_portfolio/core/navigation/navigation_cubit.dart';
import 'package:behnam_portfolio/core/navigation/navigation_mapper.dart';
import 'package:behnam_portfolio/core/utils/scroll_service.dart';
import 'package:behnam_portfolio/core/utils/scroll_spy.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';
import 'package:behnam_portfolio/core/widgets/animated_section.dart';
import 'package:behnam_portfolio/core/widgets/app_container.dart';
import 'package:behnam_portfolio/core/widgets/app_section.dart';
import 'package:behnam_portfolio/core/widgets/navbar/app_navbar.dart';
import 'package:behnam_portfolio/core/widgets/section_wrapper.dart';
import 'package:behnam_portfolio/features/background/presentation/widgets/background_section.dart';
import 'package:behnam_portfolio/features/experience/blocs/experience_bloc.dart';
import 'package:behnam_portfolio/features/experience/domain/usecases/get_experiences.dart';
import 'package:behnam_portfolio/features/experience/presentation/widgets/experience_section.dart';
import 'package:behnam_portfolio/features/home/presentation/widgets/about_section.dart';
import 'package:behnam_portfolio/features/home/presentation/widgets/contact_section.dart';
import 'package:behnam_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:behnam_portfolio/features/home/presentation/widgets/projects_section.dart';
import 'package:behnam_portfolio/features/projects/blocs/project_bloc.dart';
import 'package:behnam_portfolio/features/projects/domain/usecases/get_projects.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.initialSection});

  final String? initialSection;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  Timer? _scrollDebounce;

  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialSection != null) {
        final section = NavigationMapper.routeToSection[widget.initialSection!];

        if (section != null) {
          _scrollToSection(section);
        }
      }
    });
  }

  void _scrollToSection(AppSectionType section) {
    _isProgrammaticScroll = true;

    ScrollService.scrollTo(section);

    Future.delayed(const Duration(milliseconds: 500), () {
      _isProgrammaticScroll = false;
    });
  }

  void _onScroll() {
    if (_isProgrammaticScroll) return;

    _scrollDebounce?.cancel();

    _scrollDebounce = Timer(
      const Duration(milliseconds: 120),
      () {
        var section = ScrollSpy.getActiveSection();

        final scrollPosition = _controller.position;

        if (scrollPosition.pixels >= scrollPosition.maxScrollExtent - 200) {
          section = AppSectionType.contact;
        }

        final navCubit = context.read<NavigationCubit>();

        if (navCubit.state != section) {
          navCubit.setSection(section);
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppNavbar(),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  _onScroll();
                }

                return false;
              },
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: [
                    AnimatedSection(
                      delay: const Duration(milliseconds: 0),
                      child: AppSection(
                        type: AppSectionType.home,
                        child: const AppContainer(
                          child: HeroSection(),
                        ),
                      ),
                    ),
                    AnimatedSection(
                      delay: const Duration(milliseconds: 100),
                      child: AppSection(
                        type: AppSectionType.about,
                        child: SectionWrapper(
                          child: const AppContainer(
                            child: AboutSection(),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSection(
                      delay: const Duration(milliseconds: 300),
                      child: AppSection(
                        type: AppSectionType.experience,
                        child: SectionWrapper(
                          child: AppContainer(
                            child: BlocProvider(
                              create: (_) {
                                final cubit = ExperienceCubit(
                                  getIt<GetExperiences>(),
                                );

                                cubit.load();

                                return cubit;
                              },
                              child: const ExperienceSection(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSection(
                      delay: const Duration(milliseconds: 200),
                      child: AppSection(
                        type: AppSectionType.projects,
                        child: SectionWrapper(
                          child: AppContainer(
                            child: BlocProvider(
                              create: (_) {
                                final cubit = ProjectsCubit(getIt<GetProjects>());

                                cubit.load();

                                return cubit;
                              },
                              child: const ProjectsSection(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSection(
                      delay: const Duration(milliseconds: 350),
                      child: AppSection(
                        type: AppSectionType.background,
                        child: SectionWrapper(
                          child: AppContainer(
                            child: const BackgroundSection(),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSection(
                      delay: const Duration(milliseconds: 400),
                      child: AppSection(
                        type: AppSectionType.contact,
                        child: SectionWrapper(
                          child: const AppContainer(
                            child: ContactSection(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
