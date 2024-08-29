import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: "field")
enum Type {
  all("all"),
  info("info"),
  warn("warning"),
  err("error");

  final String field;

  const Type(this.field);
}
