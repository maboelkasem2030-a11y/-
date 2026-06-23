import 'package:flutter/material.dart';

class OSHDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text('منصة إدارة السلامة والصحة المهنية الذكية (OSH-MS)'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              selectedIndex: 0,
              extended: true,
              backgroundColor: Colors.blueGrey[50],
              destinations: [
                NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('لوحة التحكم')),
                NavigationRailDestination(icon: Icon(Icons.assignment), label: Text('التفتيش والتدقيق')),
                NavigationRailDestination(icon: Icon(Icons.warning), label: Text('بلاغات الحوادث')),
              ],
              onDestinationSelected: (index) {},
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('نظرة عامة على سلامة المواقع (مباشر)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: isDesktop ? 4 : 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildDashboardCard('أيام بدون حوادث', '342 يوم', Colors.green, Icons.sentiment_satisfied_alt),
                      _buildDashboardCard('الحوادث المفتوحة', '5 حوادث', Colors.red, Icons.lock_open),
                      _buildDashboardCard('المخاطر النشطة', '12 خطر', Colors.orange, Icons.gavel),
                      _buildDashboardCard('المقاولون النشطون', '8 شركات', Colors.blue, Icons.engineering),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            Spacer(),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
