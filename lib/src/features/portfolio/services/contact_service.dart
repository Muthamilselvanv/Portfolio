import 'package:url_launcher/url_launcher.dart';

class ContactMessage {
  const ContactMessage({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  final String name;
  final String email;
  final String subject;
  final String message;
}

enum ContactSubmissionResult { success, failure }

abstract interface class ContactService {
  Future<ContactSubmissionResult> send(ContactMessage message);
}

/// Safe development implementation. Replace this binding with an EmailJS,
/// Firebase, or Formspree adapter when the portfolio is ready to publish.
class MailContactService implements ContactService {
  const MailContactService(this.recipient);
  final String recipient;

  @override
  Future<ContactSubmissionResult> send(ContactMessage message) async {
    final uri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {
        'subject': '${message.subject} — Portfolio enquiry',
        'body':
            'Hello Muthamilselvan,\n\n'
            '${message.message}\n\n'
            'Regards,\n'
            '${message.name}\n'
            'Reply email: ${message.email}',
      },
    );
    return await launchUrl(uri)
        ? ContactSubmissionResult.success
        : ContactSubmissionResult.failure;
  }
}
