import 'package:calc/logic/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'abstract/number_pad.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen(this.flipTheme, {super.key,});

  final VoidCallback? flipTheme;

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  
  double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  final value = Number_pad().number;
  Calc_provider get provider => context.read<Calc_provider>();


  @override
  Widget build(BuildContext context) {
    final calculator = context.watch<Calc_provider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 150, 197, 220),
        title: const Text('BAMADUS',),
        leading: IconButton(onPressed: widget.flipTheme, 
        color: Colors.black54,
        // selectedIcon: Image.asset("assets/white_brush.png",),
        icon: Theme.of(context).brightness == Brightness.dark ? Image.asset("assets/black_brush.png",) : Image.asset("assets/white_brush.png",)
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: Colors.black45, size: 30),
          ),
        ],
      ),
      body: Column(
        children:[
          SizedBox(
            height: screenHeight(context)*0.17,
            child: Container(
              // color: Colors.amber,
              margin: EdgeInsets.all(10),
              // padding: EdgeInsets.all(5),
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      calculator.input,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      (calculator.result).toString(),
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            // color: Colors.deepOrange,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 45,
                  child: IconButton(
                    iconSize: 35,
                    onPressed: (){},
                    icon: Theme.of(context).brightness == Brightness.dark ? Image.asset(color: Color(0xffeff1ed),"assets/history_2.png"):Image.asset(color: Color(0xff8aa2a9),"assets/history_2.png")
                    ),
                    ),
                    SizedBox(
                  height: 60,
                  width: 45,
                  child: IconButton(
                    iconSize: 25,
                    onPressed: (){
                      provider.onDelete();
                      provider.onDeleteResultClear();
                    },
                    icon: Icon(Icons.cancel_presentation_outlined)
                    ),
                    ),
              ],
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 2,
          ),
          SizedBox(),
          OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
                physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            // crossAxisCount: 4,
            shrinkWrap: true,
            crossAxisCount:
                  orientation == Orientation.portrait ? 4 : 5,
                  mainAxisSpacing: orientation == Orientation.landscape ? 5 : 4,
            children: [
              InkWell(
                onTap: (){
                  provider.clear();
                },
                child: Number_pad(
                  number: 'C', 
                  fontweight: FontWeight.w600,
                  size: 30,
                  color: const Color(0xffd00000)
                  ),
              ),

              Number_pad(
                number: '( )', 
                size: 30, 
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c)),
              Number_pad(number: '%', size: 30, color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c)),
              
              InkWell(
                onTap: (){
                  provider.appendVal("÷");
                },
                child: Number_pad(number: '÷', size: 30, color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c))),
              InkWell(
                onTap: (){
                  provider.appendVal('7');
                },
                child: Number_pad(number: '7', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529))),
              InkWell(
                onTap: (){
                  provider.appendVal('8');
                },
                child: Number_pad(number: '8', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),)),
              InkWell(
                onTap: (){
                  provider.appendVal('9');
                },
                child: Number_pad(number: '9', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529))),
              InkWell(
                onTap: (){
                  provider.appendVal('x');
                },
                child: Number_pad(number: 'x', size: 30,color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c))),
              InkWell(
                onTap: (){
                  provider.appendVal('4');
                },
                child: Number_pad(number: '4', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),)),
              InkWell(
                onTap: (){
                  provider.appendVal('5');
                },
                child: Number_pad(number: '5', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),)),
              InkWell(
                onTap: (){
                  provider.appendVal('6');
                },
                child: Number_pad(number: '6', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),)),
              InkWell(
                onTap: (){
                  provider.appendVal('-');
                },
                child: Number_pad(number: '-', size: 30, color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c))),
              InkWell(
                onTap: (){
                  provider.appendVal('1');
                },
                child: Number_pad(number: '1', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),)),
              InkWell(
                onTap: (){
                  provider.appendVal('2');
                },
                child: Number_pad(number: '2', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),)),
              InkWell(
                onTap: (){
                  provider.appendVal('3');
                },
                child: Number_pad(number: '3', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),)),
              InkWell(
                onTap: (){
                  provider.appendVal('+');
                },
                child: Number_pad(number: '+', size: 30,color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c))),

              // Container(
              //   color: const Color(0xffdee2e6),
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: Icon(Icons.settings, color: Colors.black12, size: 30),
              //   ),
              // ),

              InkWell(
                onTap: (){
                  provider.appendVal('0');
                },
                child: Number_pad(number: '0', color: Theme.of(context).brightness == Brightness.dark ? const Color (0xfff8f9fa) : const Color(0xff212529),)),
              Number_pad(number: '.', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c),),
              InkWell(
                onTap: (){
                  provider.calculate();
                },
                child: Number_pad(
                  number: '=', 
                  back_color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff27fb6b) : const Color(0xff2e933c),
                  color: Theme.of (context).brightness == Brightness.dark ? Color(0xff212529) : const Color(0xfff8f9fa),
                  size: 35,
                  fontweight: FontWeight.w800,
                  ),
              ),
            ],
          );
            }
            )
        
        ]
      )
    );
  }
}