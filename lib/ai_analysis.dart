import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIRiskAnalysisScreen extends StatefulWidget {
  @override
  _AIRiskAnalysisScreenState createState() => _AIRiskAnalysisScreenState();
}

class _AIRiskAnalysisScreenState extends State<AIRiskAnalysisScreen> {
  File? _image;
  bool _isLoading = false;
  String _aiResult = "قم بالتقاط صورة من الموقع لتحليل المخاطر بالذكاء الاصطناعي";
  final picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _aiResult = "جاري رفع الصورة وتحليلها...";
      });
      _analyzeImageWithAI(_image!);
    }
  }

  Future<void> _analyzeImageWithAI(File imageFile) async {
    setState(() => _isLoading = true);
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://api.your-osh-system.com/v1/ai/analyze-hazard'));
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _aiResult = "⚠️ النتيجة: ${data['hazard_detected']}\n📊 مستوى الخطورة: ${data['risk_level']}";
        });
      } else {
        setState(() => _aiResult = "فشل الاتصال بسيرفر الذكاء الاصطناعي.");
      }
    } catch (e) {
      setState(() => _aiResult = "حدث خطأ غير متوقع: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تحليل المخاطر بالذكاء الاصطناعي"), backgroundColor: Colors.indigo),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null 
              ? Icon(Icons.center_focus_weak, size: 120, color: Colors.grey)
              : Image.file(_image!, height: 250, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 20),
            if (_isLoading) CircularProgressIndicator(),
            Text(_aiResult, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _getImageFromCamera,
              icon: Icon(Icons.camera_alt),
              label: Text("التقاط صورة للمخالفة"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
