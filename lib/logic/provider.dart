import 'package:flutter/material.dart';

class Calc_provider extends ChangeNotifier{

  String _input = "";
  String _result = "";

  String get input => _input;
  String get result => _result;

  void appendVal(String value){
    // value_color = const Color(0xff2e933c);
    _input += value;
    // if(_input.contains("+")){
    //   _input = value_color as String;
    // }
    notifyListeners();
  }

  void clear(){
    _input = " ";
    _result = "";
    notifyListeners();
  }

  void calculate(){
    try{
      if(_input.contains("+")){
        var part = _input.split("+");
        _result = (double.parse(part[0]) + double.parse(part[1])).toInt().toString();
      }else if(_input.contains("-")){
        var part = _input.split("-");
        _result = (double.parse(part[0]) - double.parse(part[1])).toInt().toString();
      }else if (_input.contains("x")){
        var part = _input.split("x");
        _result = (double.parse(part[0]) * double.parse(part[1])).toInt().toString();
      }else if (_input.contains("÷")){
        var part = _input.split("÷");
        _result = (double.parse(part[0]) / double.parse(part[1])).toInt().toString();
      }
    } catch (e){
      _result = "Error";
    }
    notifyListeners();
  }

  void onDelete(){
    if(_input.length > 1){
      _input = _input.substring(0, _input.length - 1);
    }
    notifyListeners();
  }
}