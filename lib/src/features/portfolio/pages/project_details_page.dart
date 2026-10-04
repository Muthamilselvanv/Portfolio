import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/src/data/models/portfolio_models.dart';
import 'package:portfolio/src/features/portfolio/controllers/portfolio_controller.dart';
import 'package:portfolio/src/features/portfolio/widgets/portfolio_widgets.dart';

class ProjectDetailsPage extends GetView<PortfolioController> {
  const ProjectDetailsPage({super.key, required this.project});
  final PortfolioProject project;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(project.name),
      leading: IconButton(
        tooltip: 'Close project details',
        icon: const Icon(Icons.close),
        onPressed: Get.back,
      ),
    ),
    body: SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: EntranceAnimation(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlaceholderArtwork(
                    icon: Icons.phone_android,
                    label: project.name,
                    height: 300,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    project.type.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project.name,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  _DetailBlock('Problem', [project.problem]),
                  _DetailBlock('My role', [project.role]),
                  const SizedBox(height: 30),
                  const EngineeringFlowVisual(),
                  _DetailBlock('Main features', project.features),
                  const SizedBox(height: 20),
                  TechWrap(project.technologies),
                  if (project.screenshots.isNotEmpty) ...[
                    const SizedBox(height: 30),
                    Text(
                      'App screens',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = constraints.maxWidth < 520 ? 2 : 4;
                        final gap = constraints.maxWidth < 520 ? 12.0 : 16.0;
                        final itemWidth =
                            (constraints.maxWidth - gap * (columns - 1)) /
                            columns;
                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: project.screenshots
                              .map(
                                (asset) => SizedBox(
                                  width: itemWidth,
                                  child: AppPhoneMockup(
                                    screenshotAsset: asset,
                                    compact: true,
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                  _DetailBlock('Challenges', project.challenges),
                  _DetailBlock('Solutions', project.solutions),
                  _DetailBlock('Learnings', project.learnings),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      if (project.hasGithub)
                        OutlinedButton.icon(
                          onPressed: () =>
                              controller.openLink(project.githubUrl),
                          icon: const Icon(Icons.code),
                          label: const Text('GitHub'),
                        ),
                      if (project.hasDemo)
                        FilledButton.icon(
                          onPressed: () => controller.openLink(project.demoUrl),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Live Demo / Store'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock(this.title, this.items);
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        ...items.map(AppBullet.new),
      ],
    ),
  );
}
