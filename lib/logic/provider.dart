import 'package:flutter/material.dart';

class Calc_provider extends ChangeNotifier{

  String _input = "";
  late double _result;

  String get input => _input;
  double get result => _result;

  void appendVal(String value){
    // value_color = const Color(0xff2e933c);
    _input += value;
    // if(_input.contains("+")){
    //   _input = value_color as String;
    // }
    notifyListeners();
  }
  // void appendopt(){
  //   if(_result.isNotEmpty){
  //     _result = 0;
  //   }
  // }

  void clear(){
    _input = " ";
    _result = double.parse("");
    notifyListeners();
  }

  Function? calculate(){
    try{

      double _solve(String equ){

        List<String> token = [];
        String number = "";

        for (int i = 0; i < equ.length; i++) {
          if ("0123456789".contains(equ[i])) {
            number += equ[i];
          } else {
            token.add(number);
            token.add(equ[i]);
            number = "";
          }
        }
        token.add(number);

        for (int i = 0; i < token.length; i++) {
          if (token[i] == "*" || token[i] == "÷") {
            double left = double.parse(token[i - 1]);
            double right = double.parse(token[i + 1]);

            String result =
            (token[i] == "*" ? left * right : left / right).toString();

           token.replaceRange(i - 1, i + 2, [result.toString()]);
           i--;
          }
        }

        double result = double.parse(token[0]);

        for (int i = 1; i < token.length; i += 2) {
          double num = double.parse(token[i + 1]);

          if (token[i] == "+") {
            result += num;
          } else if (token[i] == "-") {
            result -= num;
          }
        }

        _result = result;
        
        notifyListeners();

        return _result;
        
      }
  
      double braces(){
        String input = _input;
        input = _input.replaceAll(" ", "");

        while (input.contains("(")) {
          int start = input.lastIndexOf("(");
          int end = input.indexOf(")", start);

          String innerExp = input.substring(start + 1, end);
          double innerResult = _solve(innerExp);

          input = input.replaceRange(start, end + 1, innerResult.toString());
        }  
        return _solve(input);
      }
  
    }catch(e){
      _result = (double.parse("Error, still working on it...")).toString() as double;
    }
    notifyListeners();
    return null;
  }


    // try{
    //   if(_input.contains("+")){
    //     var part = _input.split("+");
    //     _result = (double.parse(part[0]) + double.parse(part[1])).toInt().toString();
    //   }else if(_input.contains("-")){
    //     var part = _input.split("-");
    //     _result = (double.parse(part[0]) - double.parse(part[1])).toInt().toString();
    //   }else if (_input.contains("x")){
    //     var part = _input.split("x");
    //     _result = (double.parse(part[0]) * double.parse(part[1])).toInt().toString();
    //   }else if (_input.contains("÷")){
    //     var part = _input.split("÷");
    //     _result = (double.parse(part[0]) / double.parse(part[1])).toInt().toString();
    //   }else if(_input.contains("-") && _input.contains("+")){

    //   }
    // } catch (e){
    //   _result = "Error";
    // }
    // notifyListeners();

  void onDelete(){
    if(_input.isNotEmpty){
      _input = _input.substring(0, _input.length - 1);
    }
    notifyListeners();
  }

  void onDeleteResultClear(){
    _result= double.parse("");
    notifyListeners();
  }
}