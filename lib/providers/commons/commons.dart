import 'package:clash_flutter/providers/apis/apis.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension GetApisInstance on AutoDisposeRef {
  Future<Apis> getApis([bool needInterceptor = true]) async {
    return await watch(apisProvider(needInterceptor).future);
  }
}
