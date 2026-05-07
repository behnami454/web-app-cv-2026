import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/constants/app_links.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/core/utils/url_launcher_service.dart';
import 'package:behnam_portfolio/core/widgets/app_empty_state.dart';
import 'package:behnam_portfolio/core/widgets/app_error_state.dart';
import 'package:behnam_portfolio/features/projects/blocs/project_bloc.dart';
import 'package:behnam_portfolio/features/projects/domain/entities/project_entity.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        if (state.status == ProjectsStatus.initial) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == ProjectsStatus.failure) {
          return AppErrorState(message: s.errorUnexpected);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              s.projectsTitle,
              style: theme.textTheme.displaySmall?.copyWith(
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
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                s.projectsSubtitle,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.75),
              ),
            ),
            const SizedBox(height: 28),
            const _FilterBar(),
            const SizedBox(height: 32),
            const _ProjectsGrid(),
          ],
        );
      },
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  static const allowedFilters = [
    'Flutter',
    'Flutter Web',
    'Bloc',
    'Provider',
    'Firebase',
    'REST API',
    'SQLite',
    'Maps',
    'QR Scanner',
    'OCR',
    'NFC',
    'WebView',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        final cubit = context.read<ProjectsCubit>();
        final s = S.of(context);

        final techs = state.all
            .expand((project) => project.tech)
            .where((tech) => allowedFilters.contains(tech))
            .toSet()
            .toList()
          ..sort();

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _FilterChipButton(
              label: s.all,
              selected: state.activeFilter == null,
              onTap: cubit.clearFilter,
            ),
            ...techs.map(
              (tech) => _FilterChipButton(
                label: tech,
                selected: state.activeFilter == tech,
                onTap: () => cubit.filter(tech),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  const _FilterChipButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? theme.colorScheme.primary : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: selected ? theme.colorScheme.primary : theme.dividerColor,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        if (state.filtered.isEmpty) {
          return AppEmptyState(
            title: S.of(context).noProjectsFound,
            subtitle: S.of(context).tryDifferentFilter,
          );
        }

        final featured = state.filtered.where((p) => p.isFeatured).toList();
        final others = state.filtered.where((p) => !p.isFeatured).toList();
        final featuredCount = featured.length;

        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final isMobile = maxWidth < AppSizes.tablet;
            final gap = isMobile ? AppSizes.md : AppSizes.lg;
            final cardWidth = isMobile ? maxWidth : ((maxWidth - gap) / 2).clamp(300, 520).toDouble();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (featured.isNotEmpty) ...[
                  Wrap(
                    spacing: AppSizes.lg,
                    runSpacing: AppSizes.lg,
                    children: List.generate(
                      featured.length,
                      (index) => _ProjectCard(
                        data: featured[index],
                        index: index,
                        expanded: state.expandedIndex == index,
                        width: cardWidth,
                        featured: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                ],
                Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: List.generate(
                    others.length,
                    (index) => _ProjectCard(
                      data: others[index],
                      index: index + featuredCount,
                      expanded: state.expandedIndex == index + featuredCount,
                      width: cardWidth,
                      featured: false,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.data,
    required this.index,
    required this.expanded,
    required this.width,
    required this.featured,
  });

  final ProjectEntity data;
  final int index;
  final bool expanded;
  final double width;
  final bool featured;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final theme = Theme.of(context);
    final s = S.of(context);
    final cubit = context.read<ProjectsCubit>();

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedScale(
        scale: hovered ? 1.015 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: widget.width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: hovered
                  ? theme.colorScheme.primary
                  : widget.featured
                      ? theme.colorScheme.primary.withOpacity(0.6)
                      : theme.dividerColor,
              width: widget.featured ? 1.4 : 1,
            ),
            boxShadow: [
              if (widget.featured || hovered)
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(
                    hovered ? 0.2 : 0.12,
                  ),
                  blurRadius: hovered ? 30 : 22,
                  offset: const Offset(0, 12),
                ),
            ],
          ),
          child: _ProjectContent(
            data: data,
            expanded: widget.expanded,
            onToggle: () => cubit.toggleExpand(widget.index),
            featured: widget.featured,
          ),
        ),
      ),
    );
  }
}

class _FeaturedProjectContent extends StatelessWidget {
  const _FeaturedProjectContent({
    required this.data,
    required this.expanded,
    required this.onToggle,
  });

  final ProjectEntity data;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 1100;

    if (!isWide) {
      return _ProjectContent(
        data: data,
        expanded: expanded,
        onToggle: onToggle,
        featured: true,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: _ProjectImage(data: data),
          ),
          const SizedBox(width: AppSizes.lg),
          Expanded(
            flex: 6,
            child: _ProjectBody(
              data: data,
              expanded: expanded,
              onToggle: onToggle,
              featured: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectContent extends StatelessWidget {
  const _ProjectContent({
    required this.data,
    required this.expanded,
    required this.onToggle,
    this.featured = false,
  });

  final ProjectEntity data;
  final bool expanded;
  final VoidCallback onToggle;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectImage(data: data),
          const SizedBox(height: AppSizes.md),
          _ProjectBody(
            data: data,
            expanded: expanded,
            onToggle: onToggle,
            featured: featured || data.isFeatured,
          ),
        ],
      ),
    );
  }
}

class _ProjectImage extends StatefulWidget {
  const _ProjectImage({required this.data});

  final ProjectEntity data;

  @override
  State<_ProjectImage> createState() => _ProjectImageState();
}

class _ProjectImageState extends State<_ProjectImage> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedScale(
          scale: hovered ? 1.03 : 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  widget.data.image,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  errorBuilder: (_, __, ___) => Container(
                    color: theme.dividerColor,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 28,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.35),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectBody extends StatelessWidget {
  const _ProjectBody({
    required this.data,
    required this.expanded,
    required this.onToggle,
    required this.featured,
  });

  final ProjectEntity data;
  final bool expanded;
  final VoidCallback onToggle;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (featured) ...[
          _FeaturedBadge(label: s.featured),
          const SizedBox(height: AppSizes.sm),
        ],
        Text(
          data.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        _HighlightsRow(items: data.highlights),
        Text(
          data.shortDescription,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.65),
        ),
        const SizedBox(height: AppSizes.md),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: data.tech.map((t) => _TechChip(label: t)).toList(),
        ),
        const SizedBox(height: AppSizes.md),
        Row(
          children: [
            if (data.githubUrl != null)
              OutlinedButton.icon(
                icon: const Icon(Icons.code_rounded, size: 18),
                onPressed: () {
                  UrlLauncherService.open(data.githubUrl!);
                },
                label: Text(s.viewCode),
              ),
            if (data.liveUrl != null) ...[
              if (data.githubUrl != null) const SizedBox(width: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.open_in_new_rounded, size: 18),
                onPressed: () {
                  UrlLauncherService.open(data.liveUrl!);
                },
                label: Text(s.liveDemo),
              ),
            ],
            const SizedBox(width: 12),
            _ReadMoreButton(
              expanded: expanded,
              onTap: onToggle,
            ),
          ],
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          sizeCurve: Curves.easeOutCubic,
          firstCurve: Curves.easeOut,
          secondCurve: Curves.easeOut,
          crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(width: double.infinity),
          secondChild: _ExpandedDetails(data: data),
        ),
      ],
    );
  }
}

class _FeaturedBadge extends StatelessWidget {
  const _FeaturedBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.24),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ReadMoreButton extends StatelessWidget {
  const _ReadMoreButton({
    required this.expanded,
    required this.onTap,
  });

  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Row(
          children: [
            Text(
              expanded ? s.showLess : s.readMore,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              expanded ? Icons.expand_less : Icons.expand_more,
              size: 18,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandedDetails extends StatelessWidget {
  const _ExpandedDetails({required this.data});

  final ProjectEntity data;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.problem != null) _DetailBlock(s.problem, data.problem!),
          if (data.solution != null) _DetailBlock(s.solution, data.solution!),
          if (data.architecture != null) _DetailBlock(s.architecture, data.architecture!),
          if (data.challenges != null) _DetailBlock(s.challenges, data.challenges!),
          if (data.impact != null) _DetailBlock(s.impact, data.impact!),
        ],
      ),
    );
  }
}

class _HighlightsRow extends StatelessWidget {
  const _HighlightsRow({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items.map((item) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: Text(
              item,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock(this.title, this.content);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.045),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.18),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
