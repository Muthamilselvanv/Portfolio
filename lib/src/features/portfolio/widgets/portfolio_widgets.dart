import 'package:flutter/material.dart';
import 'package:portfolio/src/app/theme/portfolio_theme.dart';
import 'package:portfolio/src/data/models/portfolio_models.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.child,
    this.description,
    this.number,
  });
  final String eyebrow;
  final String title;
  final String? description;
  final Widget child;
  final String? number;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sectionSpacing = AppSpacing.sectionFor(width);
    final scheme = Theme.of(context).colorScheme;
    return EntranceAnimation(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: sectionSpacing / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (number != null) ...[
                  Text(
                    number!,
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(width: 28, height: 1, color: scheme.primary),
                  const SizedBox(width: 12),
                ],
                Text(
                  eyebrow.toUpperCase(),
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: scheme.onSurface,
                fontSize: width < AppBreakpoints.mobile ? 32 : 40,
                letterSpacing: -.7,
              ),
            ),
            if (description != null) ...[
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  description!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 40),
            child,
          ],
        ),
      ),
    );
  }
}

class EntranceAnimation extends StatefulWidget {
  const EntranceAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });
  final Widget child;
  final Duration delay;

  @override
  State<EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<EntranceAnimation> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) return widget.child;
    return VisibilityDetector(
      key: ValueKey(widget.key ?? identityHashCode(this)),
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > .12) {
          Future<void>.delayed(widget.delay, () {
            if (mounted) setState(() => _visible = true);
          });
        }
      },
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, .035),
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 440),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}

class AppBullet extends StatelessWidget {
  const AppBullet(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•  ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

class HoverCard extends StatefulWidget {
  const HoverCard({super.key, required this.child, this.onTap});
  final Widget child;
  final VoidCallback? onTap;
  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: widget.onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(0, hovered ? -5 : 0, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(onTap: widget.onTap, child: widget.child),
      ),
    ),
  );
}

class TechWrap extends StatelessWidget {
  const TechWrap(this.items, {super.key});
  final List<String> items;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: items
        .map(
          (item) => Chip(
            label: Text(item),
            side: BorderSide.none,
            visualDensity: VisualDensity.compact,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: .1),
          ),
        )
        .toList(),
  );
}

class PlaceholderArtwork extends StatelessWidget {
  const PlaceholderArtwork({
    super.key,
    required this.icon,
    required this.label,
    this.height = 210,
  });
  final IconData icon;
  final String label;
  final double height;
  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary.withValues(alpha: .18),
          AppColors.secondary.withValues(alpha: .18),
        ],
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          right: -20,
          top: -24,
          child: Icon(
            icon,
            size: 180,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .12),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 52,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(label, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              const Text('Flutter application case study'),
            ],
          ),
        ),
      ],
    ),
  );
}

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppSpacing.contentMaxWidth),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width < AppBreakpoints.mobile
              ? 20
              : 32,
        ),
        child: child,
      ),
    ),
  );
}

class AppPhoneMockup extends StatelessWidget {
  const AppPhoneMockup({
    super.key,
    this.screenshotAsset,
    this.rotation = 0,
    this.compact = false,
  });
  final String? screenshotAsset;
  final double rotation;
  final bool compact;

  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: rotation,
    child: AspectRatio(
      aspectRatio: 9 / 18.7,
      child: Container(
        padding: EdgeInsets.all(compact ? 7 : 9),
        decoration: BoxDecoration(
          color: const Color(0xFF10131A),
          borderRadius: BorderRadius.circular(compact ? 26 : 34),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .2),
              blurRadius: 28,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(compact ? 20 : 27),
          child: screenshotAsset != null
              ? Image.asset(screenshotAsset!, fit: BoxFit.cover)
              : const _NiloraPreview(),
        ),
      ),
    ),
  );
}

class _NiloraPreview extends StatelessWidget {
  const _NiloraPreview();
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: const Color(0xFFF4F0FF),
    child: LayoutBuilder(
      builder: (_, c) => Padding(
        padding: EdgeInsets.all(c.maxWidth * .09),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Container(
                width: c.maxWidth * .32,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF151722),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: c.maxHeight * .09),
            const Text(
              'NILORA',
              style: TextStyle(
                color: Color(0xFF6C5CE7),
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: c.maxHeight * .035),
            const Text(
              'How are you feeling?',
              style: TextStyle(
                color: Color(0xFF1C2033),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: c.maxHeight * .03),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8778EF), Color(0xFF5BC8B8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                  child: Icon(Icons.mood, color: Colors.white, size: 44),
                ),
              ),
            ),
            SizedBox(height: c.maxHeight * .035),
            Row(
              children: List.generate(
                3,
                (i) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: i == 2 ? 0 : 6),
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF6C5CE7,
                      ).withValues(alpha: .18 + i * .08),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: c.maxHeight * .04),
          ],
        ),
      ),
    ),
  );
}

class SkillPill extends StatefulWidget {
  const SkillPill(this.label, {super.key});
  final String label;
  @override
  State<SkillPill> createState() => _SkillPillState();
}

class SkillGroupCard extends StatelessWidget {
  const SkillGroupCard({super.key, required this.group});
  final SkillCategory group;

  @override
  Widget build(BuildContext context) => HoverCard(
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(group.icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 14),
          Text(group.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 14),
          TechWrap(group.skills),
        ],
      ),
    ),
  );
}

class EngineeringFlowVisual extends StatelessWidget {
  const EngineeringFlowVisual({super.key});

  @override
  Widget build(BuildContext context) {
    const nodes = [
      ('Flutter UI', Icons.phone_android),
      ('GetX State', Icons.account_tree_outlined),
      ('Repository', Icons.inventory_2_outlined),
      ('API / Firebase / SQLite', Icons.cloud_outlined),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOW I STRUCTURE A FEATURE',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (_, constraints) {
              final vertical = constraints.maxWidth < 720;
              final children = <Widget>[];
              for (var i = 0; i < nodes.length; i++) {
                final node = nodes[i];
                final nodeCard = Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: .07),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        node.$2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          node.$1,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                );
                children.add(vertical ? nodeCard : Expanded(child: nodeCard));
                if (i < nodes.length - 1) {
                  children.add(
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        vertical ? Icons.arrow_downward : Icons.arrow_forward,
                        size: 18,
                      ),
                    ),
                  );
                }
              }
              return vertical
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children,
                    )
                  : Row(children: children);
            },
          ),
        ],
      ),
    );
  }
}

class _SkillPillState extends State<SkillPill> {
  bool hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hover = true),
    onExit: (_) => setState(() => hover = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.translationValues(0, hover ? -3 : 0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: BoxDecoration(
        color: hover
            ? Theme.of(context).colorScheme.primary.withValues(alpha: .12)
            : Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        widget.label,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class HoverLink extends StatefulWidget {
  const HoverLink({super.key, required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => hover = true),
    onExit: (_) => setState(() => hover = false),
    child: InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: hover ? 12 : 8,
            ),
            Icon(
              Icons.arrow_forward,
              size: 19,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    ),
  );
}

class ProjectWorkflowVisual extends StatelessWidget {
  const ProjectWorkflowVisual({super.key, this.healthcare = false});
  final bool healthcare;
  @override
  Widget build(BuildContext context) {
    final labels = healthcare
        ? const [
            ('Doctor', Icons.medical_services_outlined),
            ('Session', Icons.calendar_month),
            ('Razorpay', Icons.payments_outlined),
            ('Video consultation', Icons.video_call_outlined),
          ]
        : const [
            ('Assigned', Icons.assignment_outlined),
            ('Inspection', Icons.fact_check_outlined),
            ('Evidence', Icons.photo_camera_outlined),
            ('Report', Icons.description_outlined),
          ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: .86),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: List.generate(labels.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 2,
              height: 22,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: .35),
            );
          }
          final item = labels[i ~/ 2];
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(item.$2, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 13),
                Expanded(
                  child: Text(
                    item.$1,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                const Icon(Icons.check_circle_outline, size: 18),
              ],
            ),
          );
        }),
      ),
    );
  }
}
