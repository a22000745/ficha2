import 'package:flutter/material.dart';
import 'blocs/calculator.dart';

void main() => runApp(FCalculador());

class FCalculador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(title: 'FCalculador'),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  final String title;

  CalculatorScreen({required this.title});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final calculator = Calculator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            initialData: "0",
            stream: calculator.output,
            builder: (BuildContext context, snapshot) =>
                Display(
                  content: snapshot.data,
                ),
          ),
          Keyboard(
            calculator: calculator,
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    calculator.dispose();

    super.dispose();
  }/*
  floatingActionButton: FloatingActionButton(
      child: Icon(Icons.dehaze),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>HistoricScreenn()),
        );
      }
  )*/
}

class Display extends StatelessWidget {
  final content;

  Display({this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.all(4.0),
              height: MediaQuery.of(context).size.height / 5,
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final double width, height;
  final Function onPressed;
  final String text;
  final Color color;

  Button({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    this.color = Colors.black54,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: this.color),
        onPressed: () => onPressed(text),
        child: Text(
          this.text,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  final keys = ["1", "2", "3", "+", "0", ".", "="];
  final Calculator calculator;
  Keyboard ({required this.calculator});
  
  @override
  Widgetbuild(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Button(
                text: "1",
                width: calculateButtonWidth(context),
                height: calculateButtonHeight(context),
                onPressed: (symbol) => calculator.onReceiveSymbol(symbol),
              ),
              Button(
                text: "2",
                width: calculateButtonWidth(context),
                height: calculateButtonHeight(context),
                onPressed: (symbol) => print(symbol),
              ),
              Button(
                text: "3",
                width: calculateButtonWidth(context),
                height: calculateButtonHeight(context),
                onPressed: (symbol) => print(symbol),
              ),
              Button(
                text: "+",
                width: calculateButtonWidth(context),
                height: calculateButtonHeight(context),
                onPressed: (symbol) => calculator.onReceiveSymbol(symbol),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                text: "0",
                width: calculateButtonWidth(context, isDouble: true),
                height: calculateButtonHeight(context),
                onPressed: (symbol) => print(symbol),
              ),
              Button(
                text: ".",
                width: calculateButtonWidth(context, isDouble: true),
                height: calculateButtonHeight(context),
                onPressed: (symbol) => print(symbol),
              ),
              Button(
                text: "=",
                width: calculateButtonWidth(context, isDouble: true),
                height: calculateButtonHeight(context),
                color: Colors.orange,
                onPressed: (symbol) => calculator.onReceiveSymbol(symbol),
              ),
            ],
          ),
        ],
      ),
    );
  }
  double calculateButtonWidth(context, {isDouble = false}){
    double width = MediaQuery.of(context).size.width / 4;
    return isDouble ? (width * 2) : width;
  }
  double calculateButtonHeight(context) {
    return MediaQuery.of(context).size.height / 8;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
class HistoricScreenn extends StatelessWidget{
  final samples = [
    "1+1=2",
    "2+2=4"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Histórico"),
        ),
        body: ListView.builder(
          itemCount: samples.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset('lib/assets/logo.jpg'),
              title: Text(samples[index]),
            );
          },
        ),
      )
    );
  }
}
