import 'package:characters/characters.dart';

class Test {
  int a, b, c;
  Test({this.a, this.b, this.c});
  int operator +(Test test1) => a + b + c;
  Test.greet() {
    print('Hello');
  }
}

const timeout = Duration(seconds: 1);

main(List<String> args) {
  var test = Test(a: 1, b: 2, c: 3);
  Test.greet();
  print('${test.a}, ${test.b}, ${test.c}');
}
