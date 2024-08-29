import 'package:clash_flutter/providers/apis/apis.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension GetApisInstance on AutoDisposeRef {
  Future<Apis> getApis() async {
    return await watch(apisProvider.future);
  }
}
