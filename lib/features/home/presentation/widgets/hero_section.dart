import 'package:behnam_portfolio/core/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/constants/app_assets.dart';
import 'package:behnam_portfolio/core/constants/app_links.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/core/di/service_locator.dart';
import 'package:behnam_portfolio/core/utils/file_downloader.dart';
import 'package:behnam_portfolio/core/utils/scroll_service.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';
import 'package:behnam_portfolio/core/utils/url_launcher_service.dart';
import 'package:behnam_portfolio/core/widgets/app_container.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final verticalPadding = width < AppSizes.mobile
        ? 72.0
        : width < AppSizes.tablet
            ? 96.0
            : 96.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: _buildLayout(width),
    );
  }

  Widget _buildLayout(double width) {
    if (width < AppSizes.mobile) {
      return const _HeroMobile();
    }

    if (width < AppSizes.tablet) {
      return const _HeroTablet();
    }

    return const _HeroDesktop();
  }
}

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: AppContainer.constrainedContent(
            child: const _HeroContent(),
          ),
        ),
        const SizedBox(width: AppSizes.xxl),
        const Expanded(
          flex: 4,
          child: _HeroImage(size: 250),
        ),
      ],
    );
  }
}

class _HeroTablet extends StatelessWidget {
  const _HeroTablet();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppContainer.constrainedContent(
          alignment: Alignment.center,
          child: const _HeroContent(),
        ),
        const SizedBox(height: 56),
        const _HeroImage(size: 230),
      ],
    );
  }
}

class _HeroMobile extends StatelessWidget {
  const _HeroMobile();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppContainer.constrainedContent(
          alignment: Alignment.center,
          child: const _HeroContent(),
        ),
        const SizedBox(height: 44),
        const _HeroImage(size: 150),
      ],
    );
  }
}

class _HeroStatTag extends StatefulWidget {
  const _HeroStatTag({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  State<_HeroStatTag> createState() => _HeroStatTagState();
}

class _HeroStatTagState extends State<_HeroStatTag> {
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: hovered ? theme.colorScheme.primary.withOpacity(0.12) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hovered ? theme.colorScheme.primary.withOpacity(0.35) : theme.dividerColor,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.icon,
                size: 18,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroContent extends StatefulWidget {
  const _HeroContent();

  @override
  State<_HeroContent> createState() => _HeroContentState();
}

class _HeroContentState extends State<_HeroContent> {
  late final FileDownloader downloader;

  @override
  void initState() {
    super.initState();
    downloader = getIt<FileDownloader>();
  }

  bool _isCentered(BuildContext context) {
    return MediaQuery.sizeOf(context).width < AppSizes.tablet;
  }

  double _nameFontSize(double width) {
    if (width < AppSizes.mobile) return 36;
    if (width < AppSizes.tablet) return 40;
    return 44;
  }

  CrossAxisAlignment _alignment(BuildContext context) {
    return _isCentered(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start;
  }

  TextAlign _textAlign(BuildContext context) {
    return _isCentered(context) ? TextAlign.center : TextAlign.start;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final centered = _isCentered(context);

    return Column(
      crossAxisAlignment: _alignment(context),
      children: [
        Text(
          s.heroGreeting,
          textAlign: _textAlign(context),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.7),
            ],
          ).createShader(bounds),
          child: Text(
            s.appName,
            textAlign: _textAlign(context),
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: _nameFontSize(width),
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 18),
        RichText(
          textAlign: _textAlign(context),
          text: TextSpan(
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
            children: [
              TextSpan(text: s.heroLine1),
              TextSpan(
                text: s.heroHighlight,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              TextSpan(text: '\n${s.heroLine2}'),
            ],
          ),
        ),
        const SizedBox(height: 26),
        Text(
          s.heroDescription,
          textAlign: _textAlign(context),
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.75,
          ),
        ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.download, size: 18),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                shadowColor: theme.colorScheme.primary.withOpacity(0.3),
              ),
              onPressed: () async {
                await downloader.download(
                  path: AppAssets.cvPdf,
                  filename: 'Behnam-Iranmanesh-cv.pdf',
                );

                if (!context.mounted) return;

                AppSnackbar.success(
                  context,
                  message: s.cvDownloadStarted,
                  subtitle: 'PDF • CV Resume',
                );
              },
              label: Text(s.downloadCv),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: centered ? WrapAlignment.center : WrapAlignment.start,
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.mail_outline, size: 18),
                  onPressed: () {
                    ScrollService.scrollTo(AppSectionType.contact);
                  },
                  label: Text(s.contactMe),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.code, size: 18),
                  onPressed: () {
                    UrlLauncherService.open(AppLinks.sourceCode);
                  },
                  label: Text(s.viewCode),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Wrap(
              alignment: centered ? WrapAlignment.center : WrapAlignment.start,
              spacing: 12,
              runSpacing: 12,
              children: [
                _HeroStatTag(
                  label: s.heroStatApps,
                  icon: Icons.apps_rounded,
                ),
                _HeroStatTag(
                  label: s.heroStatScratch,
                  icon: Icons.construction_rounded,
                ),
                _HeroStatTag(
                  label: s.heroStatExperience,
                  icon: Icons.workspace_premium_rounded,
                ),
                _HeroStatTag(
                  label: s.heroStatEnterprise,
                  icon: Icons.business_center_rounded,
                ),
                _HeroStatTag(
                  label: s.heroStatPlatforms,
                  icon: Icons.devices_rounded,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroImage extends StatefulWidget {
  const _HeroImage({
    required this.size,
  });

  final double size;

  @override
  State<_HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<_HeroImage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    _scale = Tween<double>(
      begin: 0.94,
      end: 1,
    ).animate(curve);

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(curve);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: ScaleTransition(
          scale: _scale,
          child: Center(
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.16),
                          theme.colorScheme.primary.withOpacity(0.05),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.58, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    width: widget.size * 0.9,
                    height: widget.size * 0.9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0F172A),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.22),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.18),
                          blurRadius: 42,
                          spreadRadius: 4,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: ClipOval(
                        child: Image.asset(
                          AppAssets.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
