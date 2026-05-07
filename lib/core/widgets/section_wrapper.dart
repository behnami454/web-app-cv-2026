import 'package:flutter/material.dart';

class SectionWrapper extends StatelessWidget {
  const SectionWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final primary = theme.colorScheme.primary;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 46),
          child: Center(
            child: Container(
              width: 420,
              height: 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    primary.withOpacity(
                      isLight ? 0.10 : 0.22,
                    ),
                    primary.withOpacity(
                      isLight ? 0.45 : 0.85,
                    ),
                    primary.withOpacity(
                      isLight ? 0.10 : 0.22,
                    ),
                    Colors.transparent,
                  ],
                  stops: const [
                    0,
                    0.2,
                    0.5,
                    0.8,
                    1,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(
                      isLight ? 0.10 : 0.18,
                    ),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
