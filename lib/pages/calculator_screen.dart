import 'package:flutter/material.dart';

void main(List<String> args) {}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Text(
              '0',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
