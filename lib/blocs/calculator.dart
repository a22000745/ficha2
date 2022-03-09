import  "dart:async";
import  'package:expressions/expressions.dart';

class Calculator {
  String _content = "0";
  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;
  void onReceiveSymbol(symbol) {
    _content = _content == null ? symbol : _content += symbol;
    _input.add(_content);
  }
  void onEquals(){
    final expression = Expression.parse(_content);
    _content = ExpressionEvaluator().eval(expression, {}).toString();
    _input.add(_content);
  }
  void dispose() => _controller.close();
}