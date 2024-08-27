import 'package:traffic/traffic.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test("test", () {
      expect(Traffic.fromByte(byte: 347586166784).toString(), "323.7 GB");
    });
  });
}
