import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sizer/sizer.dart';

//Runn this commnads on Termnial
//flutter pub add sizer  //to make app responsive
//flutter pub add math_expressions //for mathematical Operation

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new MyApp1(),
      title: new Text(
        'F-Calci',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
      ),
      image: Image.asset(
        "assets/calci.png",
        height: 400,
        fit: BoxFit.fill,
      ),
      photoSize: 150,
      backgroundColor: Colors.blue[300],
      loaderColor: Colors.white,
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  String eq = "0";
  String res = "0";
  String expression = "";

  bpressed(String btext) {
    setState(() {
      if (btext == "Reset") {
        eq = "0";
        res = "0";
      } else if (btext == "<-") {
        eq = eq.substring(0, eq.length - 1);
      } else if (btext == "=") {
        expression = eq;
        try {
          expression = eq;
          expression = expression.replaceAll("x", "*");

          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          res = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          res = "Error";
        }
      } else {
        if (eq == "0") {
          eq = btext;
        } else {
          eq = eq + btext;
        }
      }
    });
  }

  Widget makeButton(String btext, Color col) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: col,
          height: 50,
          width: 50,
          child: ElevatedButton(
              onPressed: () {
                bpressed(btext);
              },
              style: ElevatedButton.styleFrom(primary: col),
              child: Text(
                btext,
                style: TextStyle(fontSize: 22.sp),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceTyoe) {
      return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new Scaffold(
            appBar: AppBar(
              title: Text("Calculator"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Text(
                        eq,
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                        height: 70,
                        child: Text(
                          res,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        makeButton("1", Colors.blue),
                        makeButton("2", Colors.blue),
                        makeButton("+", Colors.grey),
                      ]),
                      TableRow(children: [
                        makeButton("3", Colors.blue),
                        makeButton("4", Colors.blue),
                        makeButton("-", Colors.grey),
                      ]),
                      TableRow(children: [
                        makeButton("5", Colors.blue),
                        makeButton("6", Colors.blue),
                        makeButton("x", Colors.grey),
                      ]),
                      TableRow(children: [
                        makeButton("7", Colors.blue),
                        makeButton("8", Colors.blue),
                        makeButton("/", Colors.grey),
                      ]),
                      TableRow(children: [
                        makeButton("9", Colors.blue),
                        makeButton("0", Colors.blue),
                        makeButton("<-", Colors.red),
                      ]),
                    ],
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 8.h,
                            width: 33.w,
                            child: makeButton("Reset", Colors.purple)),
                        Container(
                            height: 8.h,
                            width: 62.5.w,
                            child: makeButton("=", Colors.orange[900])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
