import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobr/configuration.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyBlock extends StatelessWidget {
  const PrivacyPolicyBlock({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 61,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingSizes.large,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            maxLines: 2,
            text: TextSpan(
              style: TextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontSize: 13,
              ),
              children: [
                const TextSpan(
                  text: 'Door door te gaan ga je akkoord met onze \n',
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchUrl(tosUrl),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                  text: 'algemene voorwaarden',
                ),
                const TextSpan(
                  text: ' en onze ',
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchUrl(privacyPolicyUrl),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                  text: 'privacy policy',
                ),
                const TextSpan(
                  text: '.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
