import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';
import 'package:behnam_portfolio/core/utils/section_registry.dart';

class ScrollSpy {
  ScrollSpy._();

  static AppSectionType getActiveSection() {
    final screenHeight = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    for (final entry in SectionRegistry.entries) {
      final context = entry.value.currentContext;
      if (context == null) continue;

      final renderObject = context.findRenderObject();
      if (renderObject is! RenderBox) continue;

      final offset = renderObject.localToGlobal(Offset.zero).dy;

      if (offset >= 0 && offset < screenHeight * 0.6) {
        return entry.key;
      }
    }

    return AppSectionType.home;
  }
}
