import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/Language/constants/app_languages.dart';
import 'package:behnam_portfolio/core/Language/widgets/language_tile.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

void showLanguagePicker(BuildContext context) {
  final theme = Theme.of(context);
  final s = S.of(context);

  showModalBottomSheet(
    context: context,
    backgroundColor: theme.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              s.selectLanguage,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.lg),
            Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.sm,
              children: appLanguages.map((lang) => LanguageTile(language: lang)).toList(),
            ),
            const SizedBox(height: AppSizes.md),
          ],
        ),
      );
    },
  );
}
