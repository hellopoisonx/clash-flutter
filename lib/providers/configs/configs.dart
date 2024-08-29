import 'package:clash_flutter/providers/commons/commons.dart';
import 'package:clash_flutter/models/configs/configs.dart' as c;
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'configs.g.dart';

@riverpod
class Configs extends _$Configs {
  @override
  Future<c.Configs> build() async {
    final apis = await ref.getApis();
    final conf = await apis.getConfigs();
    syncToHive(conf);
    return conf;
  }

  void patchConfigs(void Function(c.Configs conf) callback) async {
    final conf = await future;
    callback(conf);
    final apis = await ref.getApis();
    await apis.patchConfigs(conf);
    ref.invalidateSelf();
  }

  void syncToHive(c.Configs conf) {
    final box = Hive.box(name: "clash_flutter");
    box.put("configs", conf);
  }
}
