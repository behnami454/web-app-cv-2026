import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';
import 'package:behnam_portfolio/core/utils/section_registry.dart';

class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    required this.child,
    required this.type,
    this.backgroundColor,
  });

  final Widget child;
  final AppSectionType type;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final key = SectionRegistry.register(type);

    return Container(
      key: key,
      width: double.infinity,
      color: backgroundColor,
      child: child,
    );
  }
}
