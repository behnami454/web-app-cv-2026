import 'dart:html' as html;

import 'package:behnam_portfolio/core/utils/file_downloader.dart';

class WebFileDownloader implements FileDownloader {
  @override
  Future<void> download({
    required String path,
    required String filename,
  }) async {
    final anchor = html.AnchorElement(href: path)
      ..setAttribute('download', filename)
      ..style.display = 'none';

    html.document.body?.children.add(anchor);
    anchor.click();
    anchor.remove();
  }
}
