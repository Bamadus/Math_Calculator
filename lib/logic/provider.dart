import 'package:flutter/material.dart';

class Calc_provider extends ChangeNotifier{

  String _input = "";
  String _result = "";

  String get input => _input;
  String get result => _result;

  void appendVal(String value){
    _input += value;
    notifyListeners();
  }

  void clear(){
    _input = "";
    _result = "";
    notifyListeners();
  }

  void calculate(){
    try{
      if(_input.contains("+")){
        var part = _input.split("+");
        _result = (double.parse(part[0]) + double.parse(part[1])).toString();
      }else if(_input.contains("-")){
        var part = _input.split("-");
        _result = (double.parse(part[0]) - double.parse(part[1])).toString();
      }else if (_input.contains("x")){
        var part = _input.split("x");
        _result = (double.parse(part[0]) * double.parse(part[1])).toString();
      }else if (_input.contains("÷")){
        var part = _input.split("÷");
        _result = (double.parse(part[0]) / double.parse(part[1])).toString();
      }
    } catch (e){
      _result = "Error";
    }
    notifyListeners();
  }
}