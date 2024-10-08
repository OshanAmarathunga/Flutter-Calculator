import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayValue = "";
  String calculationValue = "";
  bool isReplace = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 9, 16, 72),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 150,
            ),
            Text(
              calculationValue,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(displayValue,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    calculatorButton(buttonName: "MC"),
                    calculatorButton(buttonName: "C"),
                    calculatorButton(buttonName: "7"),
                    calculatorButton(buttonName: "4"),
                    calculatorButton(buttonName: "1"),
                    calculatorButton(buttonName: "%")
                  ],
                ),
                Column(
                  children: [
                    calculatorButton(buttonName: "M+"),
                    calculatorButton(buttonName: "X"),
                    calculatorButton(buttonName: "8"),
                    calculatorButton(buttonName: "5"),
                    calculatorButton(buttonName: "2"),
                    calculatorButton(buttonName: "0")
                  ],
                ),
                Column(
                  children: [
                    calculatorButton(buttonName: "M-"),
                    calculatorButton(buttonName: "/", isOperatorButton: true),
                    calculatorButton(buttonName: "9"),
                    calculatorButton(buttonName: "6"),
                    calculatorButton(buttonName: "3"),
                    calculatorButton(buttonName: ".")
                  ],
                ),
                Column(
                  children: [
                    calculatorButton(buttonName: "MR"),
                    calculatorButton(buttonName: "*", isOperatorButton: true),
                    calculatorButton(buttonName: "-", isOperatorButton: true),
                    calculatorButton(buttonName: "+", isOperatorButton: true),
                    calculatorButton(
                        buttonName: "=",
                        isEqualButon: true,
                        isOperatorButton: true)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void checkLogic({required String buttonName}) {
    setState(() {
      if (buttonName == "C") {
        setState(() {
          displayValue = "";
          calculationValue = "";
          isReplace = false;
        });
      } else if (buttonName == "X") {
        displayValue = displayValue.substring(0, displayValue.length - 1);
      } else if (buttonName == "=") {
        if (calculationValue.endsWith("+") ||
            calculationValue.endsWith("-") ||
            calculationValue.endsWith("*") ||
            calculationValue.endsWith("/")) {
          double firstValue = double.parse(
              calculationValue.substring(0, calculationValue.length - 1));
          double secondValue = double.parse(displayValue);

          String operatorValue = calculationValue[calculationValue.length - 1];
          num? result;
          if (operatorValue == "+") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue + secondValue;
            displayValue = result.toString();
          } else if (operatorValue == "-") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue - secondValue;
            displayValue = result.toString();
          } else if (operatorValue == "*") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue * secondValue;
            displayValue = result.toString();
          } else if (operatorValue == "/") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue / secondValue;
            displayValue = result.toString();
          }
          isReplace = false;
        }
      } else if (buttonName == "*" ||
          buttonName == "/" ||
          buttonName == "-" ||
          buttonName == "+") {
        setState(() {
          if (displayValue.isNotEmpty && calculationValue.isEmpty) {
            calculationValue = displayValue + buttonName;
          }
        });
      } else if (int.tryParse(buttonName) != null) {
        String? lastCharactorOfCalculation;
        if (calculationValue.isNotEmpty) {
          lastCharactorOfCalculation =
              calculationValue[calculationValue.length - 1];
          if (lastCharactorOfCalculation == "+" ||
              lastCharactorOfCalculation == "-" ||
              lastCharactorOfCalculation == "/" ||
              lastCharactorOfCalculation == "*") {
            if (isReplace) {
              displayValue = displayValue + buttonName;
            } else {
              displayValue = buttonName;
              isReplace = true;
            }
          } else if (calculationValue.endsWith("=")) {
            calculationValue = "";
            displayValue = buttonName;
            isReplace = false;
          }
        } else {
          displayValue = displayValue + buttonName;
        }
      }
    });
  }

  Padding calculatorButton(
      {required String buttonName,
      bool isEqualButon = false,
      bool isOperatorButton = false}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          checkLogic(buttonName: buttonName);
        },
        child: Container(
          width: 80,
          height: isEqualButon == true ? 128 : 60,
          decoration: BoxDecoration(
              color: isOperatorButton
                  ? const Color.fromRGBO(255, 59, 59, 1)
                  : const Color.fromARGB(255, 255, 225, 32),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Text(
            buttonName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
