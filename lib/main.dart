import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    
    debugShowCheckedModeBanner: false,
    home: calculator(),
  ));
}

// ignore: camel_case_types
class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

// ignore: camel_case_types
class _calculatorState extends State<calculator> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var opration = '';

  var hideinput = false;
  var outputsize = 34.0;

  onButtonClicked(value) {
    if (value == "Ac") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression exp = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalValue = exp.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
        hideinput = true;
        outputsize = 52;
      }
    } else {
      input = input + value;
      hideinput = false;
      outputsize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideinput ? '' : input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputsize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
          )),
          Row(
            children: [
              button(
                  text: "Ac", buttonbgColor: opratorColor, tColor: orangecolor),
              button(
                  text: "<", buttonbgColor: opratorColor, tColor: orangecolor),
              button(
                  text: "",
                  buttonbgColor: Colors.transparent,
                  tColor: orangecolor),
              button(
                  text: "/", buttonbgColor: opratorColor, tColor: orangecolor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                text: "x",
                buttonbgColor: opratorColor,
                tColor: orangecolor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", tColor: orangecolor, buttonbgColor: opratorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", tColor: orangecolor, buttonbgColor: opratorColor),
            ],
          ),
          Row(
            children: [
              button(text: "%"),
              button(text: "0"),
              button(text: "."),
              button(
                  text: "=", tColor: orangecolor, buttonbgColor: opratorColor),
            ],
          )
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonbgColor = buttoncolor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // ignore: deprecated_member_use
            primary: buttonbgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(120)),
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () {
            onButtonClicked(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
