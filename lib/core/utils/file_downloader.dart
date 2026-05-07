abstract class FileDownloader {
  Future<void> download({
    required String path,
    required String filename,
  });
}
