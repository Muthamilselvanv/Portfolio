import 'resume_service_stub.dart'
    if (dart.library.js_interop) 'resume_service_web.dart'
    as implementation;

abstract interface class ResumeService {
  Future<bool> viewResume(String assetPath);
  Future<bool> downloadResume(String assetPath, String downloadName);
}

ResumeService createResumeService() => implementation.createResumeService();
