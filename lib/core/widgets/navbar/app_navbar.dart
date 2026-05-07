import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/Language/widgets/language_picker.dart';
import 'package:behnam_portfolio/core/Language/widgets/language_switcher_button.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/core/navigation/navigation_cubit.dart';
import 'package:behnam_portfolio/core/navigation/navigation_helper.dart';
import 'package:behnam_portfolio/core/theme/theme_cubit.dart';
import 'package:behnam_portfolio/core/utils/responsive.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSizes.navbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: Responsive.width(context) < AppSizes.navbarCollapse ? const _MobileNavbar() : const _DesktopNavbar(),
    );
  }
}

class _DesktopNavbar extends StatelessWidget {
  const _DesktopNavbar();

  @override
  Widget build(BuildContext context) {
    final activeSection = context.watch<NavigationCubit>().state;
    final s = S.of(context);
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          s.appName,
          style: theme.textTheme.titleLarge,
        ),
        const Spacer(),
        Row(
          children: [
            _NavItem(
              title: s.heroTitle,
              section: AppSectionType.home,
              active: activeSection == AppSectionType.home,
            ),
            _NavItem(
              title: s.aboutTitle,
              section: AppSectionType.about,
              active: activeSection == AppSectionType.about,
            ),
            _NavItem(
              title: s.experienceTitle,
              section: AppSectionType.experience,
              active: activeSection == AppSectionType.experience,
            ),
            _NavItem(
              title: s.projectsTitle,
              section: AppSectionType.projects,
              active: activeSection == AppSectionType.projects,
            ),
            _NavItem(
              title: s.backgroundTitle,
              section: AppSectionType.background,
              active: activeSection == AppSectionType.background,
            ),
            _NavItem(
              title: s.contactTitle,
              section: AppSectionType.contact,
              active: activeSection == AppSectionType.contact,
            ),
          ],
        ),
        const SizedBox(width: AppSizes.lg),
        Row(
          children: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final isDark = themeMode == ThemeMode.dark;

                return IconButton(
                  tooltip: s.toggleTheme,
                  icon: Icon(
                    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  ),
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                );
              },
            ),
            const SizedBox(width: AppSizes.sm),
            const LanguageSwitcherButton(),
          ],
        ),
      ],
    );
  }
}

class _MobileNavbar extends StatelessWidget {
  const _MobileNavbar();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s.appName,
          style: theme.textTheme.titleLarge,
        ),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              builder: (_) => const _MobileMenu(),
            );
          },
        ),
      ],
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu();

  @override
  Widget build(BuildContext context) {
    final activeSection = context.watch<NavigationCubit>().state;
    final s = S.of(context);

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NavItem(
                  title: s.heroTitle,
                  section: AppSectionType.home,
                  active: activeSection == AppSectionType.home,
                ),
                _NavItem(
                  title: s.aboutTitle,
                  section: AppSectionType.about,
                  active: activeSection == AppSectionType.about,
                ),
                _NavItem(
                  title: s.experienceTitle,
                  section: AppSectionType.experience,
                  active: activeSection == AppSectionType.experience,
                ),
                _NavItem(
                  title: s.projectsTitle,
                  section: AppSectionType.projects,
                  active: activeSection == AppSectionType.projects,
                ),
                _NavItem(
                  title: s.backgroundTitle,
                  section: AppSectionType.background,
                  active: activeSection == AppSectionType.background,
                ),
                _NavItem(
                  title: s.contactTitle,
                  section: AppSectionType.contact,
                  active: activeSection == AppSectionType.contact,
                ),
                const SizedBox(height: AppSizes.lg),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    final isDark = themeMode == ThemeMode.dark;

                    return TextButton.icon(
                      onPressed: () async {
                        Navigator.of(context).pop();

                        await Future.delayed(
                          const Duration(milliseconds: 180),
                        );

                        if (context.mounted) {
                          context.read<ThemeCubit>().toggleTheme();
                        }
                      },
                      icon: Icon(
                        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      ),
                      label: Text(s.toggleTheme),
                    );
                  },
                ),
                const SizedBox(height: AppSizes.md),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    showLanguagePicker(context);
                  },
                  icon: const Icon(Icons.language),
                  label: Text(s.languagesTitle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.title,
    required this.section,
    required this.active,
  });

  final String title;
  final AppSectionType section;
  final bool active;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = widget.active;

    final color = isActive
        ? theme.colorScheme.primary
        : isHovered
            ? theme.colorScheme.primary.withOpacity(0.7)
            : theme.textTheme.bodyLarge?.color;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
        child: InkWell(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            NavigationHelper.navigate(context, widget.section);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.sm,
              vertical: AppSizes.sm,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: theme.textTheme.bodyLarge!.copyWith(color: color),
                  child: Text(widget.title),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: isActive ? 20 : 0,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
