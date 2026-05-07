import 'package:flutter/material.dart';
import 'package:behnam_portfolio/core/constants/app_sizes.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  static const double maxWidth = 1120;

  static const double contentWidth = 640;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding(width),
          ),
          child: child,
        ),
      ),
    );
  }

  double _horizontalPadding(double width) {
    if (width < AppSizes.mobile) return 20;
    if (width < AppSizes.tablet) return 32;
    return 24;
  }

  static Widget constrainedContent({
    required Widget child,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: contentWidth,
        ),
        child: child,
      ),
    );
  }
}
