import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:calculator_app/button_values.dart';

void main(List<String> args) {}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ''; // . 0-9
  String operand = ''; // + - * %
  String number2 = ''; // . 0-9

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rodrik Calculator'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '$number1$operand$number2'.isEmpty
                        ? '0'
                        : '$number1$operand$number2',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            // button
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                        width: value == Btn.n0
                            ? screenSize.width / 2
                            : (screenSize.width / 4),
                        height: screenSize.width / 5,
                        child: buildButton(value)),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(100)),
        child: InkWell(
            onTap: () => onBtnTap(value),
            child: Center(
                child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ))),
      ),
    );
  }

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  //
  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    double num1 = double.parse(number1);
    double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
    }
    setState(() {
      number1 = '$result';

      if (number1.endsWith('.0')) {
        number1 = number1.substring(0, number1.length - 2);
      }

      operand = '';
      number2 = '';
    });
  }

  void convertToPercentage() {
    // ex: 434+324
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      //calculate before conversion
      // TODO
    }
    if (operand.isNotEmpty) {
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = '${(number / 100)}';
      operand = '';
      number2 = '';
    });
  }

  // clears all output
  void clearAll() {
    setState(() {
      number1 = '';
      operand = '';
      number2 = '';
    });
  }

  void delete() {
    if (number2.isNotEmpty) {
      // 12323 => 1232
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = '';
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }

  void appendValue(String value) {
    // number1 operand number2
    // 234        +    456
    // if is operand and not
    if (value != Btn.dot && int.tryParse(value) == null) {
      // operand pressed
      if (operand.isNotEmpty && number2.isNotEmpty) {
        // TODO calculate the equation before assigning new operate
        calculate();
      }
      operand = value;
      // asign value to number1 variable
    } else if (number1.isEmpty || operand.isEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        value = '0.';
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        value = '0.';
      }
      number2 += value;
    }
    setState(() {});
  }

  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? const Color.fromARGB(255, 31, 137, 142)
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate
          ].contains(value)
            ? const Color(0xFF0F5A5E)
            : Color.fromARGB(255, 155, 155, 152);
  }
}
