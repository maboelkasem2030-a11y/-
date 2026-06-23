import 'package:flutter/material.dart';

class StandardsComplianceScreen extends StatefulWidget {
  @override
  _StandardsComplianceScreenState createState() => _StandardsComplianceScreenState();
}

class _StandardsComplianceScreenState extends State<StandardsComplianceScreen> {
  final List<Map<String, dynamic>> _standardsChecklist = [
    {"standard": "OSHA 1926.501", "organization": "OSHA", "check_point": "توفير الحماية من السقوط عند العمل على ارتفاع 1.8م أو أكثر.", "is_compliant": false},
    {"standard": "ISO 45001:2018", "organization": "ISO", "check_point": "تطبيق تسلسل هرمي للتحكم في المخاطر بالموقع.", "is_compliant": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مطابقة المعايير الدولية"), backgroundColor: Colors.indigo[900]),
      body: ListView.builder(
        itemCount: _standardsChecklist.length,
        itemBuilder: (context, index) {
          var item = _standardsChecklist[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: SwitchListTile(
              title: Text(item['standard'] + " - " + item['organization'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['check_point']),
              value: item['is_compliant'],
              activeColor: Colors.green,
              onChanged: (bool value) {
                setState(() {
                  item['is_compliant'] = value;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
