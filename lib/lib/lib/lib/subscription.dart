import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isAnnual = false;

  void _processStripePayment(String planName, double price) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('🎉 تم تفعيل باقة ($planName) بقيمة \$$price بنجاح عبر Stripe!'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("باقات الاشتراك والترقية"), backgroundColor: Colors.indigo[900]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("شهري"),
                Switch(value: _isAnnual, onChanged: (v) => setState(() => _isAnnual = v)),
                Text("سنوي (توفير 20%)", style: TextStyle(color: Colors.green)),
              ],
            ),
            SizedBox(height: 30),
            _isAnnual 
              ? _buildPlanCard("الباقة السنوية", 499.00, "سنة")
              : _buildPlanCard("الباقة الشهرية", 49.00, "شهر"),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String title, double price, String period) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.indigo)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("\$$price / $period", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _processStripePayment(title, price),
              child: Text("اشترك الآن عبر Stripe"),
            )
          ],
        ),
      ),
    );
  }
}
