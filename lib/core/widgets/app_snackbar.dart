import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success(
    BuildContext context, {
    required String message,
    String? subtitle,
  }) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 2600),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          elevation: 0,
          backgroundColor: theme.brightness == Brightness.dark ? const Color(0xFF052E16) : const Color(0xFFF0FDF4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(
              color: theme.brightness == Brightness.dark ? const Color(0xFF166534) : const Color(0xFFBBF7D0),
            ),
          ),
          content: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withOpacity(0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.download_done_rounded,
                  color: Color(0xFF22C55E),
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF14532D),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF166534),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
