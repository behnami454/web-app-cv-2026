import 'package:behnam_portfolio/core/routing/app_routes.dart';
import 'package:behnam_portfolio/core/utils/section_keys.dart';

class NavigationMapper {
  NavigationMapper._();

  static const Map<AppSectionType, String> sectionToRoute = {
    AppSectionType.home: AppRoutes.home,
    AppSectionType.about: AppRoutes.about,
    AppSectionType.projects: AppRoutes.projects,
    AppSectionType.experience: AppRoutes.experience,
    AppSectionType.contact: AppRoutes.contact,
  };

  static const Map<String, AppSectionType> routeToSection = {
    AppRoutes.home: AppSectionType.home,
    AppRoutes.about: AppSectionType.about,
    AppRoutes.projects: AppSectionType.projects,
    AppRoutes.experience: AppSectionType.experience,
    AppRoutes.contact: AppSectionType.contact,
  };
}
