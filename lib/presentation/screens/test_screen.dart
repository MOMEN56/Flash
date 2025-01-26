import 'package:dio/dio.dart';
import 'package:flash/data/web_services/currency_flag_services.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? flagUrl;

  @override
  void initState() {
    super.initState();
    _fetchFlag();
  }

  Future<void> _fetchFlag() async {
    final dio = Dio();
    final currencyFlag = CurrencyFlag(dio: dio);

    // البحث عن علم بناءً على العملة
    final url = await currencyFlag.fetchFlagByCurrency('TRY');
    setState(() {
      flagUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Flag Test'),
      ),
      body: Center(
        child: flagUrl == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(flagUrl!),
                  SizedBox(height: 20),
                  //Text('Flag URL: $flagUrl'),
                ],
              ),
      ),
    );
  }
}
