import 'package:behnam_portfolio/app.dart';
import 'package:behnam_portfolio/core/di/service_locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const PortfolioApp());
}
