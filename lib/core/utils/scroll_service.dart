import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';
import 'package:behnam_portfolio/core/utils/section_registry.dart';

class ScrollService {
  ScrollService._();

  static const _duration = Duration(milliseconds: 500);

  static void scrollTo(AppSectionType section) {
    final context = SectionRegistry.getContext(section);
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: _duration,
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }
}
