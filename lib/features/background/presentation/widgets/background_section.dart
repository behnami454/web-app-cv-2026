import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/features/background/data/local_data/background_data.dart';
import 'package:behnam_portfolio/features/background/presentation/widgets/certifications_block.dart';
import 'package:behnam_portfolio/features/background/presentation/widgets/education_block.dart';
import 'package:behnam_portfolio/features/background/presentation/widgets/languages_block.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class BackgroundSection extends StatelessWidget {
  const BackgroundSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        Text(
          s.backgroundTitle,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),

        Container(
          width: 56,
          height: 4,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),

        const SizedBox(height: 20),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            s.backgroundSubtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.82),
            ),
          ),
        ),

        const SizedBox(height: 42),

        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < AppSizes.tablet;

            if (isMobile) {
              return Column(
                children: [
                  _Panel(
                    child: EducationBlock(data: education),
                  ),

                  const SizedBox(height: 24),

                  _Panel(
                    child: CertificationsBlock(data: certifications),
                  ),

                  const SizedBox(height: 24),

                  _Panel(
                    child: LanguagesBlock(data: languages),
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      _Panel(
                        child: EducationBlock(data: education),
                      ),

                      const SizedBox(height: 24),

                      _Panel(
                        child: LanguagesBlock(data: languages),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  flex: 5,
                  child: _Panel(
                    child: CertificationsBlock(data: certifications),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Panel extends StatefulWidget {
  const _Panel({
    required this.child,
  });

  final Widget child;

  @override
  State<_Panel> createState() => _PanelState();
}

class _PanelState extends State<_Panel> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isLight = theme.brightness == Brightness.light;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: hovered
              ? theme.colorScheme.primary.withOpacity(
            isLight ? 0.04 : 0.08,
          )
              : isLight
              ? const Color(0xFFF8FAFC)
              : const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: hovered
                ? theme.colorScheme.primary.withOpacity(0.22)
                : isLight
                ? const Color(0xFFE2E8F0)
                : theme.dividerColor,
          ),
          boxShadow: [
            BoxShadow(
              color: hovered
                  ? theme.colorScheme.primary.withOpacity(
                isLight ? 0.08 : 0.12,
              )
                  : Colors.black.withOpacity(
                isLight ? 0.03 : 0.22,
              ),
              blurRadius: hovered ? 34 : 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}