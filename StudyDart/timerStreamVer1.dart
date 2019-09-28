// https://dartpad.dartlang.org/
import 'dart:async';
import 'dart:math' show Random;

void main() {
  final calc = MentalCalc(10);
    
  final timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
    calc._calcController.sink.add(t.tick);
  });
  
  calc._stopController.stream.listen((_) {
    timer.cancel();
  });
  
  calc._outputController.stream.listen((value) {
    print(value);
  });
}

class MentalCalc {
  int _sum = 0;
  final _calcController = StreamController<int>();
  final _outputController = StreamController<String>();
  final _stopController = StreamController<void>();

  MentalCalc(int repeat) {
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
}
