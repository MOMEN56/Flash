import 'package:flutter/material.dart';

void main() {
  runApp(const Flash());
}

class Flash extends StatelessWidget {
  const Flash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Expanded(
          child: Container(
            
          color: Color(0xff100B20),
          ),
        ),
      ),
    );
  }
}
