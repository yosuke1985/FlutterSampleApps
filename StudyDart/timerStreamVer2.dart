// https://dartpad.dartlang.org/
import 'dart:async';
import 'dart:math' show Random;

void main() {
  int repeat = 10;
  int _sum = 0;
  final _calcController = StreamController<int>();
  final _outputController = StreamController<String>();
  final _stopController = StreamController<void>();
  final timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
    _calcController.sink.add(t.tick);
  });
  
  _stopController.stream.listen((_) {
    timer.cancel();
  });
  
  _outputController.stream.listen((value) {
    print(value);
  });
  
  _calcController.stream.listen((count) {
    if (count < repeat + 1) {
      var num = Random().nextInt(99) + 1;
      _outputController.sink.add('$num');
      _sum += num;
    } else {
      _outputController.sink.add('答えは$_sum');
      _stopController.sink.add(null);
    }
  });
}