import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/core/widgets/app_container.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < AppSizes.tablet) {
      return const _AboutMobile();
    }

    return const _AboutDesktop();
  }
}

class _AboutDesktop extends StatelessWidget {
  const _AboutDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: AppContainer.constrainedContent(
            child: const _AboutContent(),
          ),
        ),
        const SizedBox(width: AppSizes.xxl),
        const Expanded(
          flex: 5,
          child: _SkillsSection(),
        ),
      ],
    );
  }
}

class _AboutMobile extends StatelessWidget {
  const _AboutMobile();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AboutContent(),
        SizedBox(height: AppSizes.xxl),
        _SkillsSection(),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          s.aboutTitle,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          width: 54,
          height: 4,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          s.aboutDescription1,
          style: theme.textTheme.headlineSmall?.copyWith(
            height: 1.45,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          s.aboutDescription2,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.9,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.85),
          ),
        ),
        const SizedBox(height: 34),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: [
            _InfoCard(
              icon: Icons.code_rounded,
              title: s.flutterDartTitle,
              subtitle: s.flutterDartSubtitle,
            ),
            _InfoCard(
              icon: Icons.web_rounded,
              title: s.responsiveUiTitle,
              subtitle: s.responsiveUiSubtitle,
            ),
            _InfoCard(
              icon: Icons.architecture_rounded,
              title: s.cleanArchitectureTitle,
              subtitle: s.cleanArchitectureSubtitle,
            ),
            _InfoCard(
              icon: Icons.speed_rounded,
              title: s.performanceTitle,
              subtitle: s.performanceSubtitle,
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoCard extends StatefulWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: 240,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: hovered ? theme.colorScheme.primary.withOpacity(0.08) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: hovered ? theme.colorScheme.primary.withOpacity(0.3) : theme.dividerColor,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.14),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.icon,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    final skills = [
      Skill('Flutter', 95),
      Skill('Bloc', 90),
      Skill('REST APIs', 90),
      Skill('Flutter Web', 88),
      Skill('Responsive UI', 92),
      Skill('SQLite', 85),
      Skill('Git', 88),
      Skill('Jira', 80),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.skillsTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            mainAxisExtent: 170,
          ),
          itemBuilder: (_, index) {
            return _SkillCard(skill: skills[index]);
          },
        ),
      ],
    );
  }
}

class Skill {
  final String name;
  final int level;

  Skill(this.name, this.level);
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({
    required this.skill,
  });

  final Skill skill;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> with SingleTickerProviderStateMixin {
  bool hovered = false;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.skill.level / 100,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _icon(String skill) {
    switch (skill) {
      case 'Flutter':
        return Icons.flutter_dash_rounded;
      case 'Bloc':
        return Icons.account_tree_rounded;
      case 'REST APIs':
        return Icons.api_rounded;
      case 'Flutter Web':
        return Icons.web_rounded;
      case 'Responsive UI':
        return Icons.devices_rounded;
      case 'SQLite':
        return Icons.storage_rounded;
      case 'Git':
        return Icons.commit_rounded;
      case 'Jira':
        return Icons.task_alt_rounded;
      default:
        return Icons.code_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: hovered ? theme.colorScheme.primary.withOpacity(0.08) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: hovered ? theme.colorScheme.primary.withOpacity(0.28) : theme.dividerColor,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.14),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _icon(widget.skill.name),
                color: theme.colorScheme.primary,
              ),
            ),
            const Spacer(),
            Text(
              widget.skill.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      height: 8,
                      color: theme.dividerColor.withOpacity(0.35),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (_, __) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: _animation.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.primary,
                                      theme.colorScheme.primary.withOpacity(0.65),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${widget.skill.level}%',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
