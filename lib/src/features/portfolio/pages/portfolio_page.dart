import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/src/app/theme/portfolio_theme.dart';
import 'package:portfolio/src/data/models/portfolio_models.dart';
import 'package:portfolio/src/data/portfolio_data.dart';
import 'package:portfolio/src/features/portfolio/controllers/portfolio_controller.dart';
import 'package:portfolio/src/features/portfolio/pages/project_details_page.dart';
import 'package:portfolio/src/features/portfolio/widgets/contact_section.dart';
import 'package:portfolio/src/features/portfolio/widgets/portfolio_widgets.dart';

class PortfolioPage extends GetView<PortfolioController> {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final compact =
        MediaQuery.sizeOf(context).width < AppBreakpoints.desktopNavigation;
    return Scaffold(
      drawer: compact ? _MobileDrawer(controller: controller) : null,
      body: SelectionArea(
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              toolbarHeight: AppSpacing.navigationHeight,
              backgroundColor: Theme.of(
                context,
              ).scaffoldBackgroundColor.withValues(alpha: .94),
              surfaceTintColor: Colors.transparent,
              shape: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(alpha: .35),
                ),
              ),
              title: const _Logo(),
              actions: [
                if (!compact)
                  ...List.generate(
                    PortfolioData.navigationItems.length,
                    (i) => Obx(
                      () => _NavLink(
                        label:
                            PortfolioData.navigationItems[i].label == 'Projects'
                            ? 'Work'
                            : PortfolioData.navigationItems[i].label,
                        active: controller.activeSection.value == i,
                        onTap: () => controller.scrollTo(i),
                      ),
                    ),
                  ),
                Obx(
                  () => IconButton(
                    tooltip: controller.isDarkMode.value
                        ? 'Switch to light theme'
                        : 'Switch to dark theme',
                    onPressed: controller.toggleTheme,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      transitionBuilder: (child, animation) =>
                          RotationTransition(
                            turns: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          ),
                      child: Icon(
                        controller.isDarkMode.value
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        key: ValueKey(controller.isDarkMode.value),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _Section(
                    key: controller.sectionKeys[0],
                    child: const _HeroSection(),
                  ),
                  _Section(
                    key: controller.sectionKeys[1],
                    child: const _AboutSection(),
                  ),
                  _Section(
                    key: controller.sectionKeys[2],
                    child: const _SkillsSection(),
                  ),
                  _Section(
                    key: controller.sectionKeys[3],
                    child: const _ExperienceSection(),
                  ),
                  _Section(
                    key: controller.sectionKeys[4],
                    child: const _ProjectsSection(),
                  ),
                  _Section(
                    key: controller.sectionKeys[5],
                    child: const _ResumeSection(),
                  ),
                  _Section(
                    key: controller.sectionKeys[6],
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: _Footer()),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => AnimatedScale(
          scale: controller.showBackToTop.value ? 1 : 0,
          duration: const Duration(milliseconds: 220),
          child: FloatingActionButton.small(
            tooltip: 'Back to top',
            onPressed: () => controller.scrollTo(0),
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => child;
}

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          'assets/profile/muthu.jpeg',
          fit: BoxFit.cover,
          alignment: const Alignment(0, -0.35),
        ),
      ),
      const SizedBox(width: 11),
      if (MediaQuery.sizeOf(context).width > 430)
        const Text(
          PortfolioData.name,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
    ],
  );
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });
  final String label;
  final bool active;
  final VoidCallback onTap;
  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => hover = true),
    onExit: (_) => setState(() => hover = false),
    child: TextButton(
      onPressed: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: widget.active || hover
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.active || hover ? 20 : 0,
            height: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    ),
  );
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({required this.controller});
  final PortfolioController controller;
  @override
  Widget build(BuildContext context) => Drawer(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Logo(),
            const SizedBox(height: 28),
            ...List.generate(
              PortfolioData.navigationItems.length,
              (i) => ListTile(
                leading: Icon(PortfolioData.navigationItems[i].icon),
                title: Text(
                  PortfolioData.navigationItems[i].label == 'Projects'
                      ? 'Work'
                      : PortfolioData.navigationItems[i].label,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Future<void>.delayed(
                    const Duration(milliseconds: 180),
                    () => controller.scrollTo(i),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _HeroSection extends GetView<PortfolioController> {
  const _HeroSection();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final stacked = width < AppBreakpoints.tablet;
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EntranceAnimation(
          delay: const Duration(milliseconds: 80),
          child: _Badge(),
        ),
        const SizedBox(height: 22),
        EntranceAnimation(
          delay: const Duration(milliseconds: 150),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'MUTHAMILSELVAN\n'),
                TextSpan(
                  text: 'BUILDS MOBILE\nPRODUCTS.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            style:
                (stacked
                        ? Theme.of(context).textTheme.displaySmall
                        : Theme.of(context).textTheme.displayLarge)
                    ?.copyWith(
                      fontSize: stacked ? (width < 390 ? 38 : 44) : null,
                    ),
          ),
        ),
        const SizedBox(height: 18),
        EntranceAnimation(
          delay: const Duration(milliseconds: 230),
          child: Text(
            PortfolioData.role,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 16),
        EntranceAnimation(
          delay: const Duration(milliseconds: 310),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              PortfolioData.valueStatement,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        const SizedBox(height: 26),
        EntranceAnimation(
          delay: const Duration(milliseconds: 390),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => controller.scrollTo(4),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('View Projects'),
              ),
              OutlinedButton.icon(
                onPressed: controller.downloadResume,
                icon: const Icon(Icons.download_outlined),
                label: const Text('Download Resume'),
              ),
              TextButton(
                onPressed: () => controller.scrollTo(6),
                child: const Text('Contact Me  →'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const EntranceAnimation(
          delay: Duration(milliseconds: 470),
          child: Text(
            'Flutter  •  Dart  •  GetX  •  Firebase  •  REST APIs',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 12),
        EntranceAnimation(
          delay: const Duration(milliseconds: 540),
          child: Row(
            children: [
              IconButton(
                tooltip: 'GitHub profile',
                onPressed: () => controller.openLink(PortfolioData.github),
                icon: const Icon(Icons.code),
              ),
              IconButton(
                tooltip: 'LinkedIn profile',
                onPressed: () => controller.openLink(PortfolioData.linkedIn),
                icon: const Icon(Icons.work_outline),
              ),
              IconButton(
                tooltip: 'Email Muthamilselvan V',
                onPressed: controller.openEmail,
                icon: const Icon(Icons.mail_outline),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  PortfolioData.location,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    final visual = const EntranceAnimation(
      delay: Duration(milliseconds: 300),
      child: _HeroVisual(),
    );
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).colorScheme.primary.withValues(alpha: .045),
          ],
        ),
      ),
      child: ContentContainer(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: stacked ? 0 : 720),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: stacked ? 52 : 72),
            child: stacked
                ? Column(children: [copy, const SizedBox(height: 36), visual])
                : Row(
                    children: [
                      Expanded(flex: 56, child: copy),
                      const SizedBox(width: 36),
                      Expanded(flex: 44, child: visual),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: .12),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .28),
      ),
      borderRadius: BorderRadius.circular(99),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 9),
        Flexible(
          child: Text(
            'AVAILABLE FOR FLUTTER OPPORTUNITIES',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    ),
  );
}

class _HeroVisual extends StatefulWidget {
  const _HeroVisual();
  @override
  State<_HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<_HeroVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);
  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _ShapesPainter(
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (_, child) => Transform.translate(
              offset: Offset(
                0,
                reduce ? 0 : math.sin(animation.value * math.pi) * 7,
              ),
              child: child,
            ),
            child: FractionallySizedBox(
              widthFactor: .72,
              heightFactor: .82,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(42),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: .22),
                      blurRadius: 42,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(37),
                  child: Image.asset(
                    'assets/profile/muthu.jpeg',
                    semanticLabel: 'Portrait of Muthamilselvan V',
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -.12),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 3,
            bottom: 55,
            child: _FloatingLabel(
              icon: Icons.hub_outlined,
              text: 'APIs & Firebase',
            ),
          ),
          Positioned(
            left: 4,
            top: 58,
            child: _FloatingLabel(
              icon: Icons.flutter_dash,
              text: 'Built with Flutter',
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingLabel extends StatelessWidget {
  const _FloatingLabel({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 20),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}

class _ShapesPainter extends CustomPainter {
  const _ShapesPainter(this.primary, this.secondary);
  final Color primary;
  final Color secondary;
  @override
  void paint(Canvas c, Size s) {
    c.drawCircle(
      Offset(s.width * .55, s.height * .48),
      s.width * .37,
      Paint()..color = primary.withValues(alpha: .11),
    );
    c.save();
    c.translate(s.width * .2, s.height * .2);
    c.rotate(-.22);
    c.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, s.width * .22, s.height * .1),
        const Radius.circular(18),
      ),
      Paint()..color = secondary.withValues(alpha: .2),
    );
    c.restore();
    c.drawCircle(
      Offset(s.width * .87, s.height * .2),
      13,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = primary.withValues(alpha: .35),
    );
  }

  @override
  bool shouldRepaint(covariant _ShapesPainter old) =>
      old.primary != primary || old.secondary != secondary;
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();
  @override
  Widget build(BuildContext context) => ContentContainer(
    child: SectionShell(
      number: '01',
      eyebrow: 'About',
      title: 'Turning requirements into useful mobile experiences.',
      child: Column(
        children: [
          LayoutBuilder(
            builder: (_, c) {
              final stack = c.maxWidth < 760;
              final a = Text(
                PortfolioData.about,
                style: Theme.of(context).textTheme.bodyLarge,
              );
              final b = Text(
                'I work across interface development, application integrations, local data, state management, and the debugging work that makes product flows dependable.',
                style: Theme.of(context).textTheme.headlineMedium,
              );
              return stack
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [b, const SizedBox(height: 20), a],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: b),
                        const SizedBox(width: 72),
                        Expanded(child: a),
                      ],
                    );
            },
          ),
          const SizedBox(height: 42),
          const _ProofStrip(),
          const SizedBox(height: 42),
          LayoutBuilder(
            builder: (_, c) => Wrap(
              spacing: 18,
              runSpacing: 18,
              children:
                  [
                        (
                          'Cross-platform development',
                          'Responsive Flutter interfaces.',
                          Icons.devices,
                        ),
                        (
                          'Application integrations',
                          'APIs, Firebase, payments and video.',
                          Icons.hub_outlined,
                        ),
                        (
                          'Reliable engineering',
                          'State, debugging and error handling.',
                          Icons.verified_outlined,
                        ),
                      ]
                      .map(
                        (item) => SizedBox(
                          width: c.maxWidth < 620
                              ? c.maxWidth
                              : (c.maxWidth - 36) / 3,
                          child: _FocusItem(
                            title: item.$1,
                            body: item.$2,
                            icon: item.$3,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ProofStrip extends StatelessWidget {
  const _ProofStrip();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('1.5+ years', 'Hands-on Flutter'),
      ('3 products', 'Built & maintained'),
      ('Production', 'Payments & video'),
      ('REST + Firebase', 'Backend integration'),
    ];
    return LayoutBuilder(
      builder: (_, constraints) {
        final columns = constraints.maxWidth < 560 ? 2 : 4;
        const gap = 14.0;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: items
              .map(
                (item) => Container(
                  width: width,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$1,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(item.$2),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _FocusItem extends StatelessWidget {
  const _FocusItem({
    required this.title,
    required this.body,
    required this.icon,
  });
  final String title, body;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 6),
              Text(body),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorScheme.primary.withValues(alpha: .045),
    child: ContentContainer(
      child: SectionShell(
        number: '02',
        eyebrow: 'Skills',
        title: 'A practical mobile engineering toolkit',
        description:
            'A practical toolkit shaped by production features, integrations, responsive UI and debugging.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (_, constraints) => Wrap(
                spacing: 16,
                runSpacing: 16,
                children: PortfolioData.skills
                    .map(
                      (group) => SizedBox(
                        width: constraints.maxWidth < 620
                            ? constraints.maxWidth
                            : (constraints.maxWidth - 32) / 3,
                        height: constraints.maxWidth < 620 ? null : 254,
                        child: SkillGroupCard(group: group),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'CURRENTLY LEARNING',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            TechWrap(PortfolioData.learningSkills),
            const SizedBox(height: 40),
            const EngineeringFlowVisual(),
          ],
        ),
      ),
    ),
  );
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();
  @override
  Widget build(BuildContext context) => ContentContainer(
    child: SectionShell(
      number: '03',
      eyebrow: 'Experience',
      title: 'Real-world Flutter delivery',
      child: Column(
        children: PortfolioData.experiences
            .map((e) => _ExperienceItem(e))
            .toList(),
      ),
    ),
  );
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem(this.experience);
  final Experience experience;
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 3,
        ),
      ),
    ),
    padding: const EdgeInsets.only(left: 28, bottom: 12),
    child: LayoutBuilder(
      builder: (_, c) {
        final stack = c.maxWidth < 760;
        final meta = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (experience.dates != null)
              Text(
                experience.dates!.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              experience.position,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (experience.company != null) ...[
              const SizedBox(height: 7),
              Text(
                experience.company!,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
            const SizedBox(height: 8),
            Text(experience.project),
          ],
        );
        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...experience.responsibilities.map(AppBullet.new),
            const SizedBox(height: 16),
            TechWrap(experience.technologies),
          ],
        );
        return stack
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [meta, const SizedBox(height: 28), details],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: meta),
                  const SizedBox(width: 60),
                  Expanded(flex: 2, child: details),
                ],
              );
      },
    ),
  );
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();
  @override
  Widget build(BuildContext context) => Column(
    children: [
      ContentContainer(
        child: SectionShell(
          number: '04',
          eyebrow: 'Selected work',
          title: 'Apps and workflows built around real problems',
          description:
              'Three case studies showing mobile product thinking, application integration, state management, and real-world Flutter delivery.',
          child: const SizedBox.shrink(),
        ),
      ),
      ...List.generate(
        PortfolioData.projects.length,
        (i) => _ProjectShowcase(index: i, project: PortfolioData.projects[i]),
      ),
    ],
  );
}

class _ProjectShowcase extends StatelessWidget {
  const _ProjectShowcase({required this.index, required this.project});
  final int index;
  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFFEDE8FF), Color(0xFFE5F6FA), Color(0xFFE8F6EE)];
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ColoredBox(
      color: dark ? colors[index].withValues(alpha: .06) : colors[index],
      child: ContentContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.sectionFor(MediaQuery.sizeOf(context).width),
          ),
          child: LayoutBuilder(
            builder: (_, c) {
              final stack = c.maxWidth < AppBreakpoints.tablet;
              final text = EntranceAnimation(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      project.name,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.type.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 22),
                    TechWrap(project.technologies.take(5).toList()),
                    const SizedBox(height: 22),
                    HoverLink(
                      label: 'View Case Study',
                      onTap: () => showDialog<void>(
                        context: context,
                        builder: (_) => Dialog.fullscreen(
                          child: ProjectDetailsPage(project: project),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              final visual = EntranceAnimation(
                delay: const Duration(milliseconds: 120),
                child: index == 0
                    ? const _NiloraVisual()
                    : ProjectWorkflowVisual(healthcare: index == 2),
              );
              if (stack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [text, const SizedBox(height: 36), visual],
                );
              }
              return Row(
                textDirection: index.isOdd
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: text,
                    ),
                  ),
                  const SizedBox(width: 64),
                  Expanded(child: visual),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NiloraVisual extends StatelessWidget {
  const _NiloraVisual();
  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1.45,
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Align(
          alignment: Alignment(-.7, .12),
          child: FractionallySizedBox(
            widthFactor: .34,
            child: AppPhoneMockup(
              screenshotAsset: 'assets/projects/nilora-login.png',
              rotation: -.07,
              compact: true,
            ),
          ),
        ),
        const Align(
          alignment: Alignment(0, -.08),
          child: FractionallySizedBox(
            widthFactor: .36,
            child: AppPhoneMockup(
              screenshotAsset: 'assets/projects/nilora-register.png',
              rotation: -.025,
              compact: true,
            ),
          ),
        ),
        const Align(
          alignment: Alignment(.7, .1),
          child: FractionallySizedBox(
            widthFactor: .36,
            child: AppPhoneMockup(
              screenshotAsset: 'assets/projects/nilora-home.png',
              rotation: .025,
              compact: true,
            ),
          ),
        ),
      ],
    ),
  );
}

class _ResumeSection extends GetView<PortfolioController> {
  const _ResumeSection();
  @override
  Widget build(BuildContext context) => ContentContainer(
    child: SectionShell(
      number: '05',
      eyebrow: 'Resume',
      title: 'My experience, projects and skills—in one place.',
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          MediaQuery.sizeOf(context).width < 600 ? 24 : 44,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: .16),
              Theme.of(context).colorScheme.secondary.withValues(alpha: .1),
            ],
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 24,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                'Ready to know more? Open the verified resume in a new tab or download a professionally named copy.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: controller.viewResume,
                  icon: const Icon(Icons.visibility_outlined),
                  label: const Text('View Resume'),
                ),
                FilledButton.icon(
                  onPressed: controller.downloadResume,
                  icon: const Icon(Icons.download),
                  label: const Text('Download Resume'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _Footer extends GetView<PortfolioController> {
  const _Footer();
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: Theme.of(context).colorScheme.surface,
    padding: EdgeInsets.symmetric(
      vertical: MediaQuery.sizeOf(context).width < 600 ? 32 : 44,
    ),
    child: ContentContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth < 680;
          final identity = Column(
            crossAxisAlignment: mobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              const Text(
                PortfolioData.name,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                PortfolioData.role,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );
          final links = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'GitHub',
                onPressed: () => controller.openLink(PortfolioData.github),
                icon: const Icon(Icons.code),
              ),
              IconButton(
                tooltip: 'LinkedIn',
                onPressed: () => controller.openLink(PortfolioData.linkedIn),
                icon: const Icon(Icons.work_outline),
              ),
              IconButton(
                tooltip: 'Email',
                onPressed: controller.openEmail,
                icon: const Icon(Icons.mail_outline),
              ),
            ],
          );
          final credit = Text(
            'Designed & built with Flutter  •  © 2026',
            textAlign: mobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
          if (mobile) {
            return Column(
              children: [
                identity,
                const SizedBox(height: 16),
                links,
                const SizedBox(height: 16),
                credit,
              ],
            );
          }
          return Row(
            children: [
              Expanded(child: identity),
              credit,
              const SizedBox(width: 24),
              links,
            ],
          );
        },
      ),
    ),
  );
}
