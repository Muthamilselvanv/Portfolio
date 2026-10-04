import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/src/data/portfolio_data.dart';
import 'package:portfolio/src/features/portfolio/services/contact_service.dart';
import 'package:portfolio/src/features/portfolio/services/resume_service.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactStatus { idle, sending, success, error }

class PortfolioController extends GetxController {
  PortfolioController({
    required ContactService contactService,
    required ResumeService resumeService,
  }) : _contactService = contactService,
       _resumeService = resumeService;

  final ContactService _contactService;
  final ResumeService _resumeService;
  final scrollController = ScrollController();
  final sectionKeys = List.generate(
    PortfolioData.navigationItems.length,
    (_) => GlobalKey(),
  );
  final activeSection = 0.obs;
  final contactStatus = ContactStatus.idle.obs;
  final showBackToTop = false.obs;
  final isDarkMode =
      (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark)
          .obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_handleScroll);
  }

  @override
  void onClose() {
    scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.onClose();
  }

  void _handleScroll() {
    showBackToTop.value = scrollController.offset > 520;
    var visibleIndex = 0;
    for (var index = 0; index < sectionKeys.length; index++) {
      final context = sectionKeys[index].currentContext;
      final renderObject = context?.findRenderObject();
      if (renderObject is RenderBox &&
          renderObject.localToGlobal(Offset.zero).dy <= 150) {
        visibleIndex = index;
      }
    }
    if (activeSection.value != visibleIndex) activeSection.value = visibleIndex;
  }

  void scrollTo(int index) {
    if (index < 0 || index >= sectionKeys.length) return;
    activeSection.value = index;
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: .06,
      );
    }
  }

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> openLink(String value, {String? missingMessage}) async {
    if (value.startsWith('YOUR_') || value.isEmpty) {
      Get.snackbar(
        'Details needed',
        missingMessage ?? 'Update this link in portfolio_data.dart.',
      );
      return;
    }
    final uri = Uri.tryParse(value);
    if (uri == null ||
        !await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
          webOnlyWindowName: uri.scheme.startsWith('http') ? '_blank' : null,
        )) {
      Get.snackbar('Could not open link', 'Please check the configured URL.');
    }
  }

  Future<void> openEmail() async {
    if (PortfolioData.email.startsWith('YOUR_')) {
      Get.snackbar(
        'Email needed',
        'Add your email address in portfolio_data.dart.',
      );
      return;
    }
    await openLink('mailto:${PortfolioData.email}');
  }

  Future<void> viewResume() async {
    if (!await _resumeService.viewResume(PortfolioData.resumeAsset)) {
      Get.snackbar(
        'Could not open resume',
        'Unable to open the resume. Please try again.',
      );
    }
  }

  Future<void> downloadResume() async {
    const fileName = 'Muthamilselvan_V_Flutter_Developer_Resume.pdf';
    if (!await _resumeService.downloadResume(
      PortfolioData.resumeAsset,
      fileName,
    )) {
      Get.snackbar(
        'Download failed',
        'Unable to download the resume. Please try again.',
      );
    }
  }

  Future<void> submitContact(ContactMessage message) async {
    contactStatus.value = ContactStatus.sending;
    final result = await _contactService.send(message);
    contactStatus.value = switch (result) {
      ContactSubmissionResult.success => ContactStatus.success,
      ContactSubmissionResult.failure => ContactStatus.error,
    };
    switch (result) {
      case ContactSubmissionResult.success:
        _showContactNotice(
          'Email draft opened',
          'Review the prepared email in your email app, then press Send.',
          success: true,
        );
      case ContactSubmissionResult.failure:
        _showContactNotice(
          'Could not open email app',
          'Please email ${PortfolioData.email} directly.',
          success: false,
        );
    }
  }

  void _showContactNotice(
    String title,
    String message, {
    required bool success,
  }) {
    final context = Get.context;
    final theme = context == null ? ThemeData.light() : Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final accent = success
        ? (dark ? const Color(0xFF5EE0CA) : const Color(0xFF128C78))
        : (dark ? const Color(0xFFFFA8A8) : const Color(0xFFC63C3C));

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      borderRadius: 18,
      maxWidth: 520,
      backgroundColor: dark ? const Color(0xFF172237) : const Color(0xFFFFFFFF),
      colorText: dark ? Colors.white : const Color(0xFF132238),
      borderColor: accent.withValues(alpha: .45),
      borderWidth: 1,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: dark ? .32 : .12),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
      icon: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: .14),
          shape: BoxShape.circle,
        ),
        child: Icon(
          success ? Icons.mark_email_read_outlined : Icons.error_outline,
          color: accent,
          size: 23,
        ),
      ),
      shouldIconPulse: false,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
