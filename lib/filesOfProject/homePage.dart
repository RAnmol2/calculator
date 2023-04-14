//import 'dart:js_util';

import 'package:calculater/filesOfProject/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        //above Buttons
        children: [
          Expanded(
            child: Container(
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    //query written
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        question,
                        style: TextStyle(color:Colors.blue[800], fontSize: 30),
                      ),
                    ),
                    // answer display
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          answer,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                    // SizedBox(height:5,),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),

          //buttons colum
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black87,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // equal Button
                    if (index == buttons.length - 1) {
                      return Button(
                        buttonTap: () {
                          setState(() {
                            isEqual();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[800],
                        textColor: Colors.white,
                      );

                      // all Clear Button
                    } else if (index == 0) {
                      return Button(
                        buttonTap: () {
                          setState(() {
                            question = '';
                            answer = '';
                          });
                        },
                        buttonText: buttons[index],
                        //color: Colors.redAccent,
                        textColor: Colors.blue[800],
                      );
                    }

                    //last clear button
                    else if (index == 1) {
                      return Button(
                        buttonTap: () {
                          setState(() {
                            question =
                                question.substring(0, question.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        textColor: Colors.blue[800],
                      );
                    }

                    //left button
                    else {
                      return Button(
                        buttonTap: () {
                          setState(() {
                            question += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
    
                        //  color:  Color.fromARGB(221, 23, 23, 23),
                        textColor: isOpreter(buttons[index],)
                            ? Colors.blue[800]
                            : Colors.white,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    ));

    // bool isOpreator
  }

  final List<String> buttons = [
    'AC',
    '←',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '00',
    '.',
    '=',
  ];

  bool isOpreter(String x) {
    if (x == 'AC' ||
        x == '←' ||
        x == '%' ||
        x == '÷' ||
        x == 'x' ||
        x == '-' ||
        x == '+') {
      return true;
    } else {
      return false;
    }
  }

  var question = '';
  var answer = '';

  void isEqual() {
    var finalAnswer = question;
    finalAnswer = finalAnswer.replaceAll('x', '*');
   // finalAnswer = finalAnswer.replaceAll('x', '*');
    finalAnswer = finalAnswer.replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(finalAnswer);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}
