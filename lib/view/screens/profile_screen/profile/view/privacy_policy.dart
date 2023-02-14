import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Center(
                  child: Text(
                    'PRIVACY POLICY',
                    style: TextStyle(
                        color: kBlackcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                kHeight20,
                Text(
                  """
1. WHAT INFORMATION DO WE COLLECT? \nPersonal information you disclose to usIn Short: We collect personal information that you provide to us.We collect personal information that you voluntarily provide to us when you register on the Services, express an interest in obtaining information about us or our products and Services, when you participate in activities on the Services, or otherwise when you contact us.Sensitive Information. We do not process sensitive information.All personal information that you provide to us must be true, complete, and accurate, and you must notify us of any changes to such personal information.Information automatically collectedIn Short: Some information — such as your Internet Protocol (IP) address and/or browser and device characteristics — is collected automatically when you visit our Services.We automatically collect certain information when you visit, use, or navigate the Services. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as your IP address, browser and device characteristics, operating system, language preferences, referring URLs, device name, country, location, information about how and when you use our Services, and other technical information. This information is primarily needed to maintain the security and operation of our Services, and for our internal analytics and reporting purposes.Like many businesses, we also collect information through cookies and similar technologies.          """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
                kHeight20,
                Text(
                  """
2. HOW DO WE PROCESS YOUR INFORMATION? \nIn Short: We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent.We process your personal information for a variety of reasons, depending on how you interact with our Services, including:         """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
                kHeight20,
                Text(
                  """
3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION? \nIn Short: We may share information in specific situations described in this section and/or with the following third parties.We may need to share your personal information in the following situations:Business Transfers. We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.Affiliates. We may share your information with our affiliates, in which case we will require those affiliates to honor this privacy notice. Affiliates include our parent company and any subsidiaries, joint venture partners, or other companies that we control or that are under common control with us.Business Partners. We may share your information with our business partners to offer you certain products, services, or promotions.          """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
                kHeight20,
                Text(
                  """
4. MAINTENANCE AND SUPPORT \n4.1 The Licensor is solely responsible for providing any maintenance and support services for this Licensed Application. You can reach the Licensor at the email address listed in the Play Store Overview for this Licensed Application.4.2 Brototype and the End-User acknowledge that the Services have no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application.  """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
