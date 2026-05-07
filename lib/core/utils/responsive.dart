import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';

class Responsive {
  Responsive._();

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) => width(context) < AppSizes.mobile;

  static bool isTablet(BuildContext context) {
    final w = width(context);
    return w >= AppSizes.mobile && w < AppSizes.tablet;
  }

  static bool isDesktop(BuildContext context) => width(context) >= AppSizes.tablet;

  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }

  static double spacing(BuildContext context, double base) {
    if (isMobile(context)) return base;
    if (isTablet(context)) return base * 1.2;
    return base * 1.4;
  }

  static double contentWidth(BuildContext context) {
    if (isDesktop(context)) return AppSizes.desktop;
    if (isTablet(context)) return 900;
    return double.infinity;
  }
}
