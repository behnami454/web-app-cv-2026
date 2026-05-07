import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/Language/models/app_language_model.dart';
import 'package:behnam_portfolio/core/Language/widgets/locale_cubit.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';

class LanguageTile extends StatefulWidget {
  final AppLanguageModel language;

  const LanguageTile({super.key, required this.language});

  @override
  State<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends State<LanguageTile> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final current = context.watch<LocaleCubit>().state;

    final isSelected = current.languageCode == widget.language.code;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: () {
          context.read<LocaleCubit>().setLocale(
                Locale(widget.language.code),
              );
          Navigator.pop(context);
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: hovered ? 1.05 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected ? theme.colorScheme.primary.withOpacity(0.1) : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
                width: isSelected ? 1.5 : 1,
              ),
              boxShadow: [
                if (hovered || isSelected)
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.language.flag,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: AppSizes.sm),
                Text(
                  widget.language.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
