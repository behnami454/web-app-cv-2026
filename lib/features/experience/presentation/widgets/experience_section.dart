import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/core/widgets/app_empty_state.dart';
import 'package:behnam_portfolio/core/widgets/app_error_state.dart';
import 'package:behnam_portfolio/features/experience/blocs/experience_bloc.dart';
import 'package:behnam_portfolio/features/experience/domain/entities/experience_entity.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final s = S.of(context);

    return BlocBuilder<ExperienceCubit, ExperienceState>(
      builder: (context, state) {
        if (state.status == ExperienceStatus.initial) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.status == ExperienceStatus.failure) {
          return AppErrorState(
            message: s.errorUnexpected,
          );
        }

        if (state.experiences.isEmpty) {
          return AppEmptyState(
            title: s.noExperienceFound,
            subtitle: s.tryDifferentFilter,
          );
        }

        final experiences = state.experiences;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              s.experienceTitle,
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              width: 48,
              height: 4,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return _ExperienceItem(
                  data: item,
                  isLast: index == experiences.length - 1,
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ExperienceItem extends StatefulWidget {
  const _ExperienceItem({
    required this.data,
    required this.isLast,
  });

  final ExperienceEntity data;
  final bool isLast;

  @override
  State<_ExperienceItem> createState() => _ExperienceItemState();
}

class _ExperienceItemState extends State<_ExperienceItem> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final data = widget.data;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.xl),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(
                          hovered ? 0.35 : 0.18,
                        ),
                        blurRadius: hovered ? 22 : 14,
                        spreadRadius: hovered ? 2 : 0,
                      ),
                    ],
                  ),
                ),
                if (!widget.isLast)
                  Container(
                    width: 2,
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.4),
                          theme.dividerColor,
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.light ? const Color(0xFFEFF3F8) : const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: hovered ? theme.colorScheme.primary.withOpacity(0.6) : theme.dividerColor,
                  ),
                  boxShadow: [
                    if (hovered)
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.12),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 12,
                      spacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          data.role,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: theme.colorScheme.primary.withOpacity(0.18),
                            ),
                          ),
                          child: Text(
                            data.period,
                            style: textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Icon(
                          Icons.business_center_outlined,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            data.company,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      data.description,
                      style: textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
