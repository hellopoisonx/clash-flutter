import 'package:clash_flutter/models/proxies/history.dart';
import 'package:clash_flutter/models/proxies/type.dart';

mixin Selectable {
  String get name;
  List<History> get history;
  Type get type;
}
