import 'package:portfolio/src/features/portfolio/services/resume_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

ResumeService createResumeService() => _WebResumeService();

class _WebResumeService implements ResumeService {
  Uri _assetUri(String path) => Uri.base.resolve('assets/$path');

  @override
  Future<bool> viewResume(String assetPath) => launchUrl(
    _assetUri(assetPath),
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: '_blank',
  );

  @override
  Future<bool> downloadResume(String assetPath, String downloadName) async {
    final anchor = web.HTMLAnchorElement()
      ..href = _assetUri(assetPath).toString()
      ..download = downloadName
      ..style.display = 'none';
    web.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    return true;
  }
}
