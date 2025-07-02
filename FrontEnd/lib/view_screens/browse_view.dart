import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';
import 'package:it_agent/widgets/section_header.dart';
import '../widgets/category_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/link_card.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(gradient: headerGradient),
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Section
                  _buildFeaturedSection(),
                  SizedBox(height: 40),

                  // Browse Section
                  _buildBrowseSection(),

                  SizedBox(height: 40),

                  // Links Section
                  _buildLinksSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Featured",
          resultCount: 4,
          onPrevious: () => print('Previous Featured'),
          onNext: () => print('Next Featured'),
        ),
        SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: CustomCard(
                title: "Computer Compliance\nCheck",
                icon: Icons.computer,
                iconColor: Colors.blue,
                buttonText: "Run",
                onPressed: () => print('Run Computer Compliance Check'),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomCard(
                title: 'Fix Wifi',
                icon: Icons.wifi,
                iconColor: Colors.blueAccent,
                buttonText: 'Run',
                onPressed: () => print('Run Fix wifi'),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomCard(
                title: 'Fix Printer',
                icon: Icons.print,
                iconColor: Colors.blueAccent,
                buttonText: 'Run',
                onPressed: () => print('Run Fix Printer'),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomCard(
                title: 'Register Computer with\nMicrosoft Intune',
                icon: Icons.security,
                iconColor: Colors.blue,
                buttonText: 'Register',
                onPressed: () => print('Register with Microsoft Intune'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBrowseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Browse',
          resultCount: 10,
          onPrevious: () => print('Previous Browse'),
          onNext: () => print('Next Browse'),
        ),

        SizedBox(height: 24),

        // First row of categories
        Row(
          children: [
            CategoryButton(
              text: 'All',
              onPressed: () => print('All category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'Maintenance',
              onPressed: () => print('Maintenance category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'Browsers',
              onPressed: () => print('Browsers category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'DLP',
              onPressed: () => print('DLP category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'Microsoft',
              onPressed: () => print('Microsoft category selected'),
            ),
          ],
        ),

        SizedBox(height: 16),

        // Second row of categories
        Row(
          children: [
            CategoryButton(
              text: 'Device Compliance',
              onPressed: () => print('Device Compliance category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'Applications',
              onPressed: () => print('Applications category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'Developer Tools',
              onPressed: () => print('Developer Tools category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'Freeware',
              onPressed: () => print('Freeware category selected'),
            ),
            SizedBox(width: 16),
            CategoryButton(
              text: 'Uninstaller',
              onPressed: () => print('Uninstaller category selected'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Links',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  '4 Results',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.chevron_left, color: Colors.grey[400]),
                SizedBox(width: 8),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),
          ],
        ),

        SizedBox(height: 24),

        Row(
          children: [
            LinkCard(
              title: 'Mac Support',
              icon: Icons.support_agent,
              color: Colors.blue,
            ),
            SizedBox(width: 20),
            LinkCard(
              title: 'Mac Support',
              icon: Icons.support_agent,
              color: Colors.blue,
            ),
            SizedBox(width: 20),
            LinkCard(
              title: 'Mac Support',
              icon: Icons.support_agent,
              color: Colors.blue,
            ),
            SizedBox(width: 20),
            LinkCard(
              title: 'Mac Support',
              icon: Icons.support_agent,
              color: Colors.blue,
            ),
            SizedBox(width: 20),

          ],
        ),
      ],
    );
  }
}
