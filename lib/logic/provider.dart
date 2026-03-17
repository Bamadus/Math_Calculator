import 'dart:math';
import 'package:calc/presentation/abstract/theme_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calc_provider extends ChangeNotifier {
  String _input = "";
  String _result = "";

  bool _isDark = false;
  bool get isDark => _isDark;

  Calc_provider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(Theme_key.themekey) ?? false; // Default to light if null
    notifyListeners();
  }

  Future<void> flipTheme() async {
    _isDark = !_isDark;
    notifyListeners();

    // Save the new value to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Theme_key.themekey, _isDark);
  }
  

  String get input => _input;
  String get result => _result;

  void appendVal(String value) {
    _input += value;
    notifyListeners();
  }

  void clear() {
    _input = "";
    _result = "";
    notifyListeners();
  }

  void onDelete() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
    }
    _result = "";
    notifyListeners();
  }

  void applyPercent() {
    if (_input.isEmpty) return;

    try {
      final expr = _input.replaceAll(' ', '');

      // Find the last +/- that is a binary operator (not a unary sign at pos 0)
      int opIndex = -1;
      for (int i = expr.length - 1; i > 0; i--) {
        if (expr[i] == '+' || expr[i] == '-') {
          opIndex = i;
          break;
        }
      }

      if (opIndex != -1) {
        // e.g. "200+10"  →  base=200, op="+", percentNum=10
        final base = double.parse(expr.substring(0, opIndex));
        final op = expr[opIndex];
        final percentNum = double.parse(expr.substring(opIndex + 1));

        // percentNum% of base
        final percentValue = base * percentNum / 100;

        // Rebuild expression with the resolved percent value
        final formatted = _formatAnswer(percentValue);
        _input = '${_formatAnswer(base)}$op$formatted';
      } else {
        // No preceding operator — just divide by 100
        final num = double.parse(expr);
        _input = _formatAnswer(num / 100);
      }
    } catch (_) {
      _result = "Error";
    }

    notifyListeners();
  }


  void calculate() {
    try {
      
      final expression = _input
          .replaceAll('x', '*')
          .replaceAll('÷', '/');
      
      final answer = evaluate(expression);
      _result = _formatAnswer(answer);
      
      // if(expression.contains(".")){
      //   final answer = evaluate(expression);

      // _result = answer == answer.truncateToDouble()
      //     ? answer.toInt().toStringAsFixed(2)
      //     : answer.toStringAsFixed(2);
      // }else{
      //   final answer = evaluate(expression);

      // _result = answer == answer.truncateToDouble()
      //     ? answer.toInt().toString()
      //     : answer.toString();
      // }
    } catch (e) {
      _result = "Error";
    }
    notifyListeners();
  }

  String _formatAnswer(double value) {
    return value == value.truncateToDouble()
        ? value.toInt().toString()
        : value.toString();
  }  
}

int _pos = 0;
String _expr = '';

double evaluate(String expression) {
  _expr = expression.replaceAll(' ', '');
  _pos = 0;
  final result = _parseAddSubtract();
  // if (_pos < _expr.length) {
  //   throw FormatException('Unexpected character: ${_expr[_pos]}');
  // }
  return result;
}

// Addition & Subtraction
double _parseAddSubtract() {
  double left = _parseMultiplyDivide();
  while (_pos < _expr.length) {
    final op = _expr[_pos];
    if (op != '+' && op != '-') break;
    _pos++;
    final right = _parseMultiplyDivide();
    left = op == '+' ? left + right : left - right;
  }
  return left;
}

// Division & Multiplication
double _parseMultiplyDivide() {
  double left = _parseOrders();
  while (_pos < _expr.length) {
    final op = _expr[_pos];
    if (op != '*' && op != '/' && op != '%') break;
    _pos++;
    final right = _parseOrders();
    if (op == '*') {
      left *= right;
    } else if (op == '/') {
      if (right == 0) return double.parse("Error");
      // throw ArgumentError('Division by zero');
      left /= right;
    } else {
      left %= right;
    }
  }
  return left;
}

// O — right-associative exponents
double _parseOrders() {
  double base = _parseUnary();
  if (_pos < _expr.length && _expr[_pos] == '^') {
    _pos++;
    final exponent = _parseOrders();
    base = pow(base, exponent).toDouble();
  }
  return base;
}

// Unary minus / plus
double _parseUnary() {
  if (_pos < _expr.length && _expr[_pos] == '-') {
    _pos++;
    return -_parseUnary();
  }
  if (_pos < _expr.length && _expr[_pos] == '+') {
    _pos++;
    return _parseUnary();
  }
  return _parsePrimary();
}

// B — brackets and numbers
double _parsePrimary() {
  if (_pos < _expr.length && _expr[_pos] == '(') {
    _pos++;
    final result = _parseAddSubtract();
    if (_pos >= _expr.length || _expr[_pos] != ')') {
      return double.parse("Missing Braces");
    }
    _pos++;
    return result;
  }
  return _parseNumber();
}

double _parseNumber() {
  final start = _pos;
  while (_pos < _expr.length && RegExp(r'[0-9.]').hasMatch(_expr[_pos])) {
    _pos++;
  }
  if (_pos == start) {
    return double.parse(
      'Expected number at position $_pos, got: '
      '${_pos < _expr.length ? _expr[_pos] : "end of input"}',
    );
  }
  return double.parse(_expr.substring(start, _pos));
}