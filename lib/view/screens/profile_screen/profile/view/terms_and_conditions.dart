import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'TERMS AND CONDITIONS',
                    style: TextStyle(
                        color: kBlackcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                kHeight20,
                Text('Last updated: 2023-14-02'),
                kHeight10,
                Text('Introduction'),
                kHeight10,
                Text(
                  """
1. THE APPLICATION
Scotch ("Licensed Application") is a piece of software created to facilitate online shopping via mobile phone — and customized for Android mobile devices ("Devices"). It is used to buy electronic products online.The Licensed Application is not tailored to comply with industry-specific regulations (Health Insurance Portability and Accountability Act (HIPAA), Federal Information Security Management Act (FISMA), etc.), so if your interactions would be subjected to such laws, you may not use this Licensed Application. You may not use the Licensed Application in a way that would violate the Gramm-Leach-Bliley Act (GLBA).
          """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
                kHeight10,
                Text(
                  """
2. SCOPE OF LICENSE \n2.1 You are given a non-transferable, non-exclusive, non-sublicensable license to install and use the Licensed Application on any Devices that You (End-User) own or control and as permitted by the Usage Rules, with the exception that such Licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing.2.2 This license will also govern any updates of the Licensed Application provided by Licensor that replace, repair, and/or supplement the first Licensed Application, unless a separate license is provided for such update, in which case the terms of that new license will govern.2.3 You may not share or make the Licensed Application available to third parties (unless to the degree allowed by the Usage Rules, and with Brototype's prior written consent), sell, rent, lend, lease or otherwise redistribute the Licensed Application.2.4 You may not reverse engineer, translate, disassemble, integrate, decompile, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Licensed Application, or any part thereof (except with Brototype's prior written consent).2.5 You may not copy (excluding when expressly authorized by this license and the Usage Rules) or alter the Licensed Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this license, the Usage Rules, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no unauthorized third parties may gain access to these copies at any time. If you sell your Devices to a third party, you must remove the Licensed Application from the Devices before doing so.2.6 Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages.2.7 Licensor reserves the right to modify the terms and conditions of licensing.2.8 Nothing in this license should be interpreted to restrict third-party terms. When using the Licensed Application, You must ensure that You comply with applicable third-party terms and conditions.          """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
                kHeight20,
                Text(
                  """
3. TECHNICAL REQUIREMENTS \n3.1 Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.3.2 You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above.3.3 Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.          """,
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
                kHeight20,
                Text(
                  """
3. TECHNICAL REQUIREMENTS \n3.1 Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.3.2 You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above.3.3 Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.          """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
                kHeight20,
                Text(
                  """
3. TECHNICAL REQUIREMENTS \n3.1 Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.3.2 You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above.3.3 Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.          """,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: kBlackcolor, fontSize: 15),
                ),
                kHeight20,
                Text(
                  """
3. TECHNICAL REQUIREMENTS \n3.1 Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.3.2 You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above.3.3 Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.          """,
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
