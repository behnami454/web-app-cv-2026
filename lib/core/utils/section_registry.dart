import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';

class SectionRegistry {
  SectionRegistry._();

  static final Map<AppSectionType, GlobalKey> _keys = {
    for (final type in AppSectionType.values) type: GlobalKey(),
  };

  static GlobalKey register(AppSectionType type) {
    final key = _keys[type]!;

    return key;
  }

  static BuildContext? getContext(AppSectionType type) {
    return _keys[type]?.currentContext;
  }

  static Iterable<MapEntry<AppSectionType, GlobalKey>> get entries => _keys.entries;
}
