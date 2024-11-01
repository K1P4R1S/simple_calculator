import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(MaterialApp(home: Calculator()));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController controller = TextEditingController();
  String _result = '';

  void updateController(String printSymbol) {
    if (controller.text.isNotEmpty) {
      final sym = controller.text[controller.text.length - 1];
      var i = int.tryParse(sym);
      if (i == null && sym != "%") return;
    } else {
      return;
    }
    controller.text += printSymbol;
  }

  List<RegExpMatch> findNumbers(String eq) {
    var s = RegExp(r'(\d+\.?\d*)%?').allMatches(eq).toList();
    return s;
  }

  String findLastNumber(String eq) {
    try {
      var s = findNumbers(eq);
      var t = eq.substring(s.last.start, s.last.end);
      return t;
    } catch (e) {
      return eq;
    }
  }

  void answer() {
    if (controller.text.isEmpty) {
      return;
    } else {
      var temp = controller.text;
      if (controller.text.contains("%")) {
        final numbers = findNumbers(temp);
        for (var num in numbers) {
          if (temp.substring(num.start, num.end).contains('%')) {
            var res = temp.substring(0, num.start - 1).interpret();
            var numProc = double.parse(temp.substring(num.start, num.end - 1));
            temp = res.toString() +
                temp.substring(num.start - 1, num.start) +
                (res.toDouble() / 100 * numProc).toString();
          }
        }
      }
      final answers = [temp];
      for (final answer in answers) {
        _result = ("${answer.interpret()}");
        var dRes = double.tryParse(_result);
        if (dRes != null && dRes == dRes.toInt()) {
          _result = dRes.toInt().toString();
        } else {
          _result = dRes.toString();
        }
        ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var buttonStyle = ButtonStyle(
      minimumSize:
          WidgetStatePropertyAll(Size((width / 4) - 3, (width / 4) - 3)),
      backgroundColor: WidgetStatePropertyAll<Color>(Colors.green.shade50),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.purple.shade800),
      shadowColor: WidgetStatePropertyAll<Color>(Colors.yellow),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Калькулятор",
          ),
          backgroundColor: Colors.amber.shade50,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextField(
              style: TextStyle(
                fontSize: 35,
                color: Colors.purple.shade300,
              ),
              textAlign: TextAlign.right,
              keyboardType: TextInputType.none,
              controller: controller),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: TextStyle(fontSize: 50, color: Colors.purple.shade800),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateController("^");
                        });
                      },
                      child: Text("^", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateController("-");
                        });
                      },
                      child: Text("-", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateController("+");
                        });
                      },
                      child: Text("+", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text = "";
                          _result = "";
                        });
                      },
                      child: Text("C", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "7";
                        });
                      },
                      child: Text("7", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "8";
                        });
                      },
                      child: Text("8", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "9";
                        });
                      },
                      child: Text("9", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (controller.text.isEmpty) {
                            controller.text = "";
                          } else {
                            controller.text = controller.text
                                .substring(0, controller.text.length - 1);
                          }
                        });
                      },
                      child: Icon(
                        Icons.keyboard_backspace,
                        size: 30,
                      ),
                      style: buttonStyle),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "4";
                        });
                      },
                      child: Text("4", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "5";
                        });
                      },
                      child: Text("5", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "6";
                        });
                      },
                      child: Text("6", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateController("/");
                        });
                      },
                      child: Text("/", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "1";
                        });
                      },
                      child: Text("1", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "2";
                        });
                      },
                      child: Text("2", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "3";
                        });
                      },
                      child: Text("3", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateController("*");
                        });
                      },
                      child: Text("*", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateController("%");
                        });
                      },
                      child: Text("%", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text += "0";
                        });
                      },
                      child: Text("0", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          var t = findLastNumber(controller.text);
                          bool point = t.contains(".");
                          if (point == false) {
                            updateController(".");
                          }
                        });
                      },
                      child: Text(".", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          answer();
                        });
                      },
                      child: Text("=", style: TextStyle(fontSize: 25)),
                      style: buttonStyle),
                ],
              ))
        ]));
  }
}
