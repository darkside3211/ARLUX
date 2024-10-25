import 'package:flutter/material.dart';

class CreateTermsAndConditions extends StatelessWidget {
  const CreateTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding:  EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last Updated: October 19, 2024 | 8:20 PM',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            '1. Acceptance of Terms',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'By creating an account and using the JBB-Gold ("App"), you agree to be bound by these Terms and Conditions. If you do not agree to these Terms, you should not create an account or use the App.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '2. Account Creation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'To use certain features of the App, you must create an account by providing accurate and complete information. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '3. Use of the App',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'You agree to use the App only for lawful purposes and in compliance with all applicable local, state, national, and international laws and regulations. You are prohibited from using the App to:\n\n'
            '- Engage in any activity that may harm the App or its users.\n'
            '- Distribute viruses or any other harmful technology.\n'
            '- Post or share illegal or inappropriate content.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '4. User Content',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'By submitting any content to the App (including text, images, videos, etc.), you grant JBB-Gold a non-exclusive, worldwide, royalty-free license to use, reproduce, modify, adapt, and display such content for the purpose of providing and improving the App\'s services.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '5. Camera Access (CameraKit Usage)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'The App uses CameraKit for camera access to enable certain features such as capturing photos or videos. By using the camera features, you agree to the following CameraKit-specific terms:\n\n'
            '- CameraKit is used solely for capturing and processing images or videos within the App.\n'
            '- The App will not access the camera without your permission, and you can revoke this permission at any time through your device settings.\n'
            '- Camera data, including photos or videos, will only be used for the functionality intended within the App and will not be shared with third parties unless explicitly agreed upon by you.\n\n'
            'CameraKit is provided "as-is" without any warranties. CameraKit\'s creators disclaim all liability related to the camera functionality provided by CameraKit. By using the camera features, you agree that JBB-Gold and CameraKit\'s creators are not responsible for any damage or loss related to the use of the camera features.\n\n'
            'For more information on CameraKit\'s terms and privacy policies, please refer to CameraKit\'s website.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '6. Privacy Policy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Your use of the App is also governed by our Privacy Policy, which explains how we collect, use, and disclose information about you. By using the App, you consent to the collection and use of your information as outlined in the Privacy Policy.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '7. Intellectual Property',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'All content and materials available on the App, including but not limited to text, graphics, logos, and images, are the property of [Your App Name] or its licensors and are protected by intellectual property laws. You may not reproduce, distribute, or create derivative works from any content on the App without express written permission.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '8. Termination',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'We reserve the right to terminate or suspend your account at any time, with or without notice, if we believe you have violated these Terms or engaged in any unlawful activity.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '9. Disclaimer of Warranties',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'The App is provided on an "as-is" and "as-available" basis without any warranties of any kind. We do not guarantee that the App will be available at all times or that it will be free of errors or viruses.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '10. Limitation of Liability',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'In no event will [Your App Name] be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with your use of the App or these Terms.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '11. Changes to the Terms',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'We may update these Terms from time to time. If we make significant changes, we will notify you through the App or by other means. Your continued use of the App after such changes indicates your acceptance of the new Terms.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '12. Governing Law',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'These Terms shall be governed and construed in accordance with the laws of the Philippines, without regard to its conflict of law provisions.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '13. Contact Us',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'If you have any questions about these Terms, please contact us at .',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
