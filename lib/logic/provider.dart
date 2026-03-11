import 'dart:math';
import 'package:flutter/material.dart';

class Calc_provider extends ChangeNotifier {
  String _input = "";
  String _result = "";

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

  void calculate() {
    try {
      
      final expression = _input
          .replaceAll('x', '*')
          .replaceAll('÷', '/');

      final answer = evaluate(expression);

      _result = answer == answer.truncateToDouble()
          ? answer.toInt().toString()
          : answer.toString();
    } catch (e) {
      _result = "Error";
    }
    notifyListeners();
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