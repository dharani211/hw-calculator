import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _displayText = '0';
  String _currentOperand = '';
  String _operator = '';

  bool _hasDecimalPoint = false;

  void _appendToDisplay(String value) {
    setState(() {
      if (value == '.' && !_hasDecimalPoint) {
        _displayText += value;
        _hasDecimalPoint = true;
      } else if (value != '.') {
        _displayText = _displayText == '0' ? value : _displayText + value;
        if (value != '.') {
          _hasDecimalPoint = false;
        }
      }
    });
  }

  void _setOperator(String operator) {
    setState(() {
      _operator = operator;
      _currentOperand = _displayText;
      _displayText = '0';
      _hasDecimalPoint = false;
    });
  }

  void _calculate() {
    try {
      double num1 = double.parse(_currentOperand);
      double num2 = double.parse(_displayText);
      double result;

      switch (_operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          if (num2 == 0) {
            throw Exception('Not divisable by zero');
          }
          result = num1 / num2;
          break;
        default:
          result = 0;
      }

      setState(() {
        _displayText = result.toString();
        _currentOperand = '';
        _operator = '';
        _hasDecimalPoint = false;
      });
    } catch (e) {
      setState(() {
        _displayText = 'Error';
      });
    }
  }

  void _clear() {
    setState(() {
      _displayText = '0';
      _currentOperand = '';
      _operator = '';
      _hasDecimalPoint = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _displayText,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CalculatorButton(
                text: '7',
                onPressed: () => _appendToDisplay('7'),
              ),
              CalculatorButton(
                text: '8',
                onPressed: () => _appendToDisplay('8'),
              ),
              CalculatorButton(
                text: '9',
                onPressed: () => _appendToDisplay('9'),
              ),
              CalculatorButton(
                text: '+',
                onPressed: () => _setOperator('+'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CalculatorButton(
                text: '4',
                onPressed: () => _appendToDisplay('4'),
              ),
              CalculatorButton(
                text: '5',
                onPressed: () => _appendToDisplay('5'),
              ),
              CalculatorButton(
                text: '6',
                onPressed: () => _appendToDisplay('6'),
              ),
              CalculatorButton(
                text: '-',
                onPressed: () => _setOperator('-'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CalculatorButton(
                text: '1',
                onPressed: () => _appendToDisplay('1'),
              ),
              CalculatorButton(
                text: '2',
                onPressed: () => _appendToDisplay('2'),
              ),
              CalculatorButton(
                text: '3',
                onPressed: () => _appendToDisplay('3'),
              ),
              CalculatorButton(
                text: '*',
                onPressed: () => _setOperator('*'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CalculatorButton(
                text: '0',
                onPressed: () => _appendToDisplay('0'),
              ),
              CalculatorButton(
                text: '.',
                onPressed: () => _appendToDisplay('.'),
              ),
              CalculatorButton(
                text: '=',
                onPressed: _calculate,
              ),
              CalculatorButton(
                text: '/',
                onPressed: () => _setOperator('/'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CalculatorButton(
                text: 'Clear',
                onPressed: _clear,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 205, 198, 198),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
