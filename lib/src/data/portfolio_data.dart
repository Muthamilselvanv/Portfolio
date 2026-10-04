import 'package:flutter/material.dart';
import 'package:portfolio/src/data/models/portfolio_models.dart';

abstract final class PortfolioData {
  static const name = 'Muthamilselvan V';
  static const fullName = name;

  static const role = 'Flutter Mobile App Developer';

  static const valueStatement =
      'Building dependable mobile products with Flutter, APIs, Firebase, '
      'and thoughtful engineering workflows.';

  static const location = 'Coimbatore, Tamil Nadu, India';

  static const email = 'muthamilselvan251@gmail.com';

  static const linkedIn = 'https://www.linkedin.com/in/muthamilselvanv/';

  static const github = 'https://github.com/Muthamilselvanv';

  static const resumeAsset = 'assets/resume/Muthamilselvan_V_Resume.pdf';

  static const bio =
      'I build responsive and maintainable cross-platform mobile '
      'applications using Flutter and Dart. My hands-on experience '
      'includes REST API integration, GetX, Firebase, SQLite, payment '
      'workflows, video calling, responsive UI development, and '
      'debugging real-world application issues.';

  static const about =
      'I am a Flutter Mobile App Developer focused on building reliable '
      'and user-friendly cross-platform applications. I have hands-on '
      'experience working with REST APIs, GetX state management, '
      'Firebase services, local storage, payment integrations, video '
      'consultation workflows, and responsive interfaces. I enjoy '
      'solving application problems, improving user flows, and writing '
      'clean, maintainable Flutter code.';

  static const navigationItems = <NavigationItem>[
    NavigationItem('Home', Icons.home_outlined),
    NavigationItem('About', Icons.person_outline),
    NavigationItem('Skills', Icons.code),
    NavigationItem('Experience', Icons.work_outline),
    NavigationItem('Projects', Icons.apps),
    NavigationItem('Resume', Icons.description_outlined),
    NavigationItem('Contact', Icons.mail_outline),
  ];

  static const skills = <SkillCategory>[
    SkillCategory('Mobile Development', Icons.flutter_dash, [
      'Flutter',
      'Dart',
      'Responsive UI',
      'Material Design',
    ]),

    SkillCategory('State & Architecture', Icons.account_tree_outlined, [
      'GetX',
      'Clean Architecture',
      'SOLID Principles',
      'Dependency Injection',
    ]),

    SkillCategory('API & Firebase', Icons.hub_outlined, [
      'REST APIs',
      'JSON',
      'HTTP',
      'Firebase Authentication',
      'Firebase',
    ]),

    SkillCategory('Local Storage', Icons.storage_outlined, [
      'SQLite',
      'GetStorage',
    ]),

    SkillCategory('Third-Party Integrations', Icons.extension_outlined, [
      'Razorpay',
      'ZegoCloud',
      'Image Picker',
      'Notifications',
    ]),

    SkillCategory('Engineering Quality', Icons.verified_outlined, [
      'Error Handling',
      'Debugging',
    ]),

    SkillCategory('Development Tools', Icons.handyman_outlined, [
      'Git',
      'GitHub',
      'VS Code',
      'Android Studio',
      'Figma',
    ]),
  ];

  static const learningSkills = <String>[
    'BLoC fundamentals',
    'Python',
    'GitHub Actions / CI/CD',
    'AI application development',
  ];

  static const experiences = <Experience>[
    Experience(
      company: 'TeckZy Research Analytics IT Solutions Pvt. Ltd.',
      position: 'Flutter Mobile App Developer',
      dates: 'March 2025 - Present',
      project: 'Inspection Management & Healthcare Applications',

      responsibilities: [
        'Developed and maintained responsive Flutter application features for real-world mobile products.',

        'Integrated REST APIs and managed reactive application state using GetX.',

        'Worked with local storage and server-driven workflows to maintain reliable application data.',

        'Debugged state synchronization, API lifecycle, responsive UI, and navigation issues.',

        'Implemented and maintained payment workflows using Razorpay.',

        'Worked on video consultation functionality using ZegoCloud.',

        'Handled loading, validation, API failure, and user feedback states across application workflows.',
      ],

      technologies: [
        'Flutter',
        'Dart',
        'GetX',
        'REST APIs',
        'GetStorage',
        'Razorpay',
        'ZegoCloud',
      ],

      achievements: [
        'Contributed to production Flutter applications across inspection and healthcare workflows.',

        'Resolved complex state and API synchronization issues affecting application workflows.',

        'Worked with third-party payment and video communication integrations.',
      ],
    ),
  ];

  static const projects = <PortfolioProject>[
    PortfolioProject(
      name: 'Nilora – Mood Journal App',

      type: 'Personal Flutter Application',

      description:
          'A personal mood tracking and journaling application that '
          'helps users record their emotions, daily activities, weather, '
          'journal notes, and understand mood patterns over time.',

      role:
          'Flutter Developer responsible for UI development, '
          'architecture, state management, local storage, Firebase '
          'authentication, responsive design, and debugging.',

      problem:
          'Users need a simple and private way to record emotional '
          'context and understand how their mood changes over time.',

      features: [
        'Firebase email authentication',
        'Daily mood tracking',
        'Mood intensity tracking',
        'Weather selection',
        'Activity tracking',
        'Personal journal entries',
        'Mood history',
        'Mood trends and statistics',
        'User profile management',
        'Dark and light themes',
        'Local data persistence',
      ],

      technologies: [
        'Flutter',
        'Dart',
        'GetX',
        'Firebase Authentication',
        'SQLite',
        'GetStorage',
        'fl_chart',
        'Responsive UI',
      ],

      screenshots: [
        'assets/projects/nilora-home.png',
        'assets/projects/nilora-login.png',
        'assets/projects/nilora-register.png',
      ],

      challenges: [
        'Keeping mood and journal information synchronized across multiple screens.',

        'Displaying trend and statistics information clearly across different mobile screen sizes.',

        'Managing authentication and local profile information reliably.',
      ],

      solutions: [
        'Used structured GetX state management and separated application responsibilities.',

        'Created responsive layouts and adaptive chart components.',

        'Separated authentication and local application data responsibilities.',
      ],

      learnings: [
        'Plan application data flow before increasing UI complexity.',

        'Design loading, empty, success, and error states as part of the main user experience.',

        'Build reusable responsive components instead of relying on fixed screen dimensions.',
      ],
    ),

    PortfolioProject(
      name: 'Inspection Management Application',

      type: 'Production Company Project',

      description:
          'A Flutter-based field inspection application supporting '
          'inspection assignments, checklists, evidence capture, '
          'status tracking, submission, re-submission, and '
          'certificate/report workflows.',

      role:
          'Flutter Developer responsible for feature development, '
          'REST API integration, GetX state management, debugging, '
          'and workflow improvements.',

      problem:
          'Inspection teams require reliable mobile workflows where '
          'inspection progress and server-side status changes remain '
          'consistent throughout the inspection lifecycle.',

      features: [
        'Today\'s inspection assignments',
        'Ongoing inspections',
        'Upcoming inspections',
        'Inspection checklists',
        'Inspection progress tracking',
        'API-based status updates',
        'Image and evidence handling',
        'Signature capture',
        'Inspection submission',
        'Inspection re-submission',
        'Certificate and report viewing',
      ],

      technologies: [
        'Flutter',
        'Dart',
        'GetX',
        'REST APIs',
        'HTTP',
        'GetStorage',
      ],

      challenges: [
        'Synchronizing inspection status between different API responses.',

        'Managing complex state transitions across multiple inspection items.',

        'Maintaining predictable application state after submissions and re-submissions.',
      ],

      solutions: [
        'Reviewed API lifecycle and identified conflicting sources of inspection state.',

        'Improved state ownership and controller lifecycle management.',

        'Added clearer validation and predictable status handling throughout inspection workflows.',
      ],

      learnings: [
        'Server-driven state transitions should have a clearly defined source of truth.',

        'Controller lifecycle management is important in complex GetX applications.',

        'Critical workflows should include retry, validation, and user feedback from the beginning.',
      ],
    ),

    PortfolioProject(
      name: 'Healthcare / Doctor-Patient Application',

      type: 'Production Flutter Application',

      description:
          'A healthcare mobile application supporting doctor and '
          'patient workflows, paid consultation sessions, payment '
          'processing, profile integration, and remote video consultations.',

      role:
          'Flutter Developer working on application integrations, '
          'payment flows, video consultation functionality, API '
          'handling, and user experience.',

      problem:
          'Patients need a reliable flow from selecting a consultation '
          'session through payment and finally joining a remote '
          'consultation with a doctor.',

      features: [
        'Doctor and patient workflows',
        'Consultation session purchasing',
        'Razorpay payment integration',
        'Payment success handling',
        'Payment failure handling',
        'Video consultation',
        'Profile integration',
        'REST API integration',
        'User feedback and error states',
      ],

      technologies: [
        'Flutter',
        'Dart',
        'GetX',
        'REST APIs',
        'Razorpay',
        'ZegoCloud',
      ],

      challenges: [
        'Managing asynchronous payment results reliably.',

        'Handling success, failure, and retry states during payment workflows.',

        'Managing video consultation lifecycle and third-party integration errors.',
      ],

      solutions: [
        'Separated payment processing states and handled success and failure paths explicitly.',

        'Integrated user feedback for payment and API responses.',

        'Handled video consultation lifecycle events and integration failures carefully.',
      ],

      learnings: [
        'Payment success should always be validated through a reliable backend workflow.',

        'Third-party integrations require clear loading, failure, and recovery states.',

        'Business-critical actions should never depend only on UI state.',
      ],
    ),
  ];
}
