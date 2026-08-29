import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/src/app/theme/portfolio_theme.dart';
import 'package:portfolio/src/data/portfolio_data.dart';
import 'package:portfolio/src/features/portfolio/controllers/portfolio_controller.dart';
import 'package:portfolio/src/features/portfolio/pages/portfolio_page.dart';
import 'package:portfolio/src/features/portfolio/services/contact_service.dart';
import 'package:portfolio/src/features/portfolio/services/resume_service.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Muthamilselvan V | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: PortfolioTheme.light,
      darkTheme: PortfolioTheme.dark,
      themeMode: ThemeMode.system,
      initialBinding: BindingsBuilder(() {
        Get.put(
          PortfolioController(
            contactService: const MailContactService(PortfolioData.email),
            resumeService: createResumeService(),
          ),
        );
      }),
      home: const PortfolioPage(),
    );
  }
}
