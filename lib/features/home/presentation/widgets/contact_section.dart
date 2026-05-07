import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/constants/app_links.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/core/utils/url_launcher_service.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < AppSizes.tablet;
    final s = S.of(context);

    final isLight = theme.brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          s.contactTitle,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          width: 52,
          height: 4,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            s.contactSubtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.8,
            ),
          ),
        ),
        const SizedBox(height: 36),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 36,
            vertical: 36,
          ),
          decoration: BoxDecoration(
            color: isLight ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: isLight ? const Color(0xFFD8E0EA) : theme.dividerColor,
            ),
            boxShadow: [
              BoxShadow(
                color: isLight ? Colors.black.withOpacity(0.03) : Colors.black.withOpacity(0.22),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: _ContactActions(
            theme: theme,
            compact: isMobile,
          ),
        ),
      ],
    );
  }
}

class _ContactActions extends StatelessWidget {
  const _ContactActions({
    required this.theme,
    required this.compact,
  });

  final ThemeData theme;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 320,
            ),
            child: _EmailButton(),
          ),
        ),
        const SizedBox(height: 18),
        compact
            ? Column(
                children: [
                  _SocialButton(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    onTap: () {
                      UrlLauncherService.open(AppLinks.github);
                    },
                  ),
                  const SizedBox(height: 14),
                  _SocialButton(
                    icon: Icons.phone_rounded,
                    label: 'WhatsApp',
                    onTap: () {
                      UrlLauncherService.open(AppLinks.whatsapp);
                    },
                  ),
                  const SizedBox(height: 14),
                  _SocialButton(
                    icon: Icons.telegram,
                    label: 'Telegram',
                    onTap: () {
                      UrlLauncherService.open(AppLinks.telegram);
                    },
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.code_rounded,
                      label: 'GitHub',
                      onTap: () {
                        UrlLauncherService.open(AppLinks.github);
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.phone_rounded,
                      label: 'WhatsApp',
                      onTap: () {
                        UrlLauncherService.open(AppLinks.whatsapp);
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.telegram,
                      label: 'Telegram',
                      onTap: () {
                        UrlLauncherService.open(AppLinks.telegram);
                      },
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
        decoration: BoxDecoration(
          color: hovered
              ? theme.colorScheme.primary.withOpacity(0.08)
              : isLight
                  ? Colors.white
                  : const Color(0xFF111827),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hovered
                ? theme.colorScheme.primary.withOpacity(0.3)
                : isLight
                    ? const Color(0xFFD6DCE5)
                    : theme.dividerColor,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailButton extends StatefulWidget {
  const _EmailButton();

  @override
  State<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<_EmailButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: hovered ? theme.colorScheme.primary.withOpacity(0.9) : theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.24),
              blurRadius: hovered ? 30 : 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            UrlLauncherService.open(AppLinks.email);
          },
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 18,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.send_rounded,
                    size: 18,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  s.sendEmail,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
