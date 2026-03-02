import 'package:flutter/material.dart';
import 'abstract/number_pad.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen(this.flipTheme, {super.key,});

  final VoidCallback? flipTheme;

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {

  
  double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 150, 197, 220),
        title: const Text('BAMADUS',),
        leading: IconButton(onPressed: widget.flipTheme, 
        color: Colors.black54,
        // selectedIcon: Image.asset("assets/white_brush.png",),
        icon: Image.asset("assets/black_brush.png",)
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
            height: screenHeight(context)*0.25,
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(),
          OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
            crossAxisSpacing: 10,
            // crossAxisCount: 4,
            shrinkWrap: true,
            crossAxisCount:
                  orientation == Orientation.portrait ? 4 : 5,
                  mainAxisSpacing: orientation == Orientation.landscape ? 5 : 4,
            children: [
              Number_pad(number: 'C', color: const Color(0xffd00000)),
              Number_pad(number: '( )', color: const Color(0xff006400)),
              Number_pad(number: '%', color: const Color(0xff006400)),
              Number_pad(number: '÷', color: const Color(0xff006400)),
              Number_pad(number: '7', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529)),
              Number_pad(number: '8', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),),
              Number_pad(number: '9', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529)),
              Number_pad(number: 'x', color: const Color(0xff006400)),
              Number_pad(number: '4', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),),
              Number_pad(number: '5', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),),
              Number_pad(number: '6', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),),
              Number_pad(number: '-', size: 30, color: const Color(0xff006400)),
              Number_pad(number: '1', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),),
              Number_pad(number: '2', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),),
              Number_pad(number: '3', color: Theme.of(context).brightness == Brightness.dark ? const Color(0xfff8f9fa) : const Color(0xff212529),),
              Number_pad(number: '+', color: const Color(0xff006400)),

              // Container(
              //   color: const Color(0xffdee2e6),
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: Icon(Icons.settings, color: Colors.black12, size: 30),
              //   ),
              // ),

              Number_pad(number: '0', color: const Color(0xff212529),),
              Number_pad(number: '.', color: const Color(0xff212529),),
              Number_pad(number: '=', color: Theme.of (context).brightness == Brightness.dark ? Color(0xff343a40) : const Color(0xfff8f9fa),),
            ],
          );
            }
            )
        
        ]
      )
    );
  }
}