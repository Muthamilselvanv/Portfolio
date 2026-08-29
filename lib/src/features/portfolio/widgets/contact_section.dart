import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/src/app/theme/portfolio_theme.dart';
import 'package:portfolio/src/data/portfolio_data.dart';
import 'package:portfolio/src/features/portfolio/controllers/portfolio_controller.dart';
import 'package:portfolio/src/features/portfolio/services/contact_service.dart';
import 'package:portfolio/src/features/portfolio/widgets/portfolio_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) => ContentContainer(
    child: SectionShell(
      number: '06',
      eyebrow: 'Contact',
      title: "Looking for a Flutter developer? Let's connect.",
      description:
          'I am open to Flutter Mobile App Developer opportunities and conversations about real-world mobile products.',
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          MediaQuery.sizeOf(context).width < AppBreakpoints.mobile ? 20 : 32,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const details = _ContactDetails();
            const form = _ContactForm();
            if (constraints.maxWidth < 820) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [details, SizedBox(height: 28), form],
              );
            }
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: details),
                SizedBox(width: 44),
                Expanded(flex: 6, child: form),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class _ContactDetails extends GetView<PortfolioController> {
  const _ContactDetails();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _ContactLine(Icons.person_outline, PortfolioData.fullName),
      const _ContactLine(Icons.location_on_outlined, PortfolioData.location),
      _ContactLine(
        Icons.mail_outline,
        PortfolioData.email,
        onTap: controller.openEmail,
      ),
      _ContactLine(
        Icons.work_outline,
        'LinkedIn Profile',
        onTap: () => controller.openLink(PortfolioData.linkedIn),
      ),
      _ContactLine(
        Icons.code,
        'GitHub Profile',
        onTap: () => controller.openLink(PortfolioData.github),
      ),
    ],
  );
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _subject = TextEditingController();
  final _message = TextEditingController();

  PortfolioController get controller => Get.find<PortfolioController>();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await controller.submitContact(
      ContactMessage(
        name: _name.text.trim(),
        email: _email.text.trim(),
        subject: _subject.text.trim(),
        message: _message.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final fields = [
              _ContactField(
                controller: _name,
                label: 'Name',
                validator: _required,
              ),
              _ContactField(
                controller: _email,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: _validEmail,
              ),
            ];
            if (constraints.maxWidth < 460) {
              return Column(
                children: [
                  fields.first,
                  const SizedBox(height: 12),
                  fields.last,
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: fields.first),
                const SizedBox(width: 12),
                Expanded(child: fields.last),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        _ContactField(
          controller: _subject,
          label: 'Subject',
          validator: _required,
        ),
        const SizedBox(height: 12),
        _ContactField(
          controller: _message,
          label: 'Message',
          lines: 5,
          validator: _required,
        ),
        const SizedBox(height: 16),
        Obx(() {
          final sending =
              controller.contactStatus.value == ContactStatus.sending;
          return SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: sending ? null : _submit,
              icon: sending
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.mail_outline),
              label: Text(sending ? 'Opening Email…' : 'Send Email'),
            ),
          );
        }),
        const SizedBox(height: 10),
        Text(
          'Opens your email app with this message ready to review and send.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  );

  static String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;

  static String? _validEmail(String? value) =>
      value == null || !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)
      ? 'Enter a valid email'
      : null;
}

class _ContactField extends StatelessWidget {
  const _ContactField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.lines = 1,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final int lines;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: lines,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      alignLabelWithHint: lines > 1,
    ),
  );
}

class _ContactLine extends StatelessWidget {
  const _ContactLine(this.icon, this.value, {this.onTap});

  final IconData icon;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      mouseCursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(value)),
        ],
      ),
    ),
  );
}
