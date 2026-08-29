import 'package:portfolio/src/features/portfolio/services/resume_service.dart';
import 'package:url_launcher/url_launcher.dart';

ResumeService createResumeService() => _PlatformResumeService();

class _PlatformResumeService implements ResumeService {
  Uri _assetUri(String path) => Uri.base.resolve('assets/$path');

  @override
  Future<bool> viewResume(String assetPath) => launchUrl(_assetUri(assetPath));

  @override
  Future<bool> downloadResume(String assetPath, String downloadName) =>
      viewResume(assetPath);
}
