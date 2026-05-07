import 'package:url_launcher/url_launcher.dart';
import 'package:behnam_portfolio/core/error/result.dart';

class UrlLauncherService {
  UrlLauncherService._();

  static Future<Result<void>> open(String url) async {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null) {
        return Result.failure('error_invalid_url');
      }

      final success = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!success) {
        return Result.failure('error_could_not_open');
      }

      return Result.success(null);
    } catch (e) {
      return Result.failure('error_unexpected');
    }
  }
}
