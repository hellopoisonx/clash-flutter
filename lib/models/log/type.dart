import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: "field")
enum Type {
  info("info"),
  warn("warning"),
  err("err");

  final String field;

  const Type(this.field);
}
