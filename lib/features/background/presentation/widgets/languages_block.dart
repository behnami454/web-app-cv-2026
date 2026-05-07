import 'package:flutter/material.dart';
import 'package:behnam_portfolio/features/background/domain/entities/language_entity.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class LanguagesBlock extends StatelessWidget {
  const LanguagesBlock({
    super.key,
    required this.data,
  });

  final List<LanguageEntity> data;

  double _level(String level) {
    switch (level.toLowerCase()) {
      case 'native':
        return 1;
      case 'professional':
        return 0.85;
      case 'advanced':
        return 0.72;
      default:
        return 0.6;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).languagesTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 22),
        ...data.map(
          (l) => Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.light ? const Color(0xFFF1F5F9) : const Color(0xFF111827),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: theme.brightness == Brightness.light ? const Color(0xFFCBD5E1) : theme.dividerColor,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.language_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        l.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      l.level,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: _level(l.level),
                    minHeight: 8,
                    backgroundColor: theme.dividerColor.withOpacity(0.4),
                    valueColor: AlwaysStoppedAnimation(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
