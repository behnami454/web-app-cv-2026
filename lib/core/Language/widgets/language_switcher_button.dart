import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:behnam_portfolio/core/Language/widgets/language_picker.dart';
import 'package:behnam_portfolio/core/Language/widgets/locale_cubit.dart';

class LanguageSwitcherButton extends StatelessWidget {
  const LanguageSwitcherButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final code = locale.languageCode;

        final flag = _flag(code);
        final label = code.toUpperCase();

        return InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () {
            showLanguagePicker(context);
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            child: Container(
              key: ValueKey(code),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(flag, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.expand_more, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _flag(String code) {
    switch (code) {
      case 'de':
        return '🇩🇪';
      case 'fr':
        return '🇫🇷';
      case 'es':
        return '🇪🇸';
      case 'it':
        return '🇮🇹';
      case 'nl':
        return '🇳🇱';
      case 'pl':
        return '🇵🇱';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'tr':
        return '🇹🇷';
      case 'ro':
        return '🇷🇴';
      default:
        return '🇬🇧';
    }
  }
}
