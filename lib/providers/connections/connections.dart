import 'package:clash_flutter/apis/apis.dart';
import 'package:clash_flutter/models/connections/connections.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connections.g.dart';

@riverpod
Stream<Connections> connections(ConnectionsRef ref) async* {
  final stream = apis.getConnections();
  await for (final connections in stream) {
    yield connections;
  }
}

@riverpod
Future<Connections> filteredConnections(
    FilteredConnectionsRef ref, String query) async {
  final connections = await ref.watch(connectionsProvider.future);
  final filteredConnections = Fuzzy(
    connections.connections,
    options: FuzzyOptions(shouldSort: true, keys: [
      WeightedKey(name: "rule", getter: (Connection c) => c.rule, weight: 1),
      WeightedKey(
          name: "rulePayload",
          getter: (Connection c) => c.rulePayload,
          weight: 1),
      WeightedKey(
          name: "chains",
          getter: (Connection c) => c.chains.join(" "),
          weight: 1),
      WeightedKey(
          name: "network",
          getter: (Connection c) => c.metadata.network,
          weight: 1),
      WeightedKey(
          name: "type", getter: (Connection c) => c.metadata.type, weight: 1),
      WeightedKey(
          name: "sourceIP",
          getter: (Connection c) => c.metadata.sourceIP,
          weight: 1),
      WeightedKey(
          name: "destinationIP",
          getter: (Connection c) => c.metadata.destinationIP,
          weight: 1),
      WeightedKey(
          name: "sourcePort",
          getter: (Connection c) => c.metadata.sourcePort,
          weight: 1),
      WeightedKey(
          name: "destinationPort",
          getter: (Connection c) => c.metadata.destinationPort,
          weight: 1),
      WeightedKey(
          name: "inboundIP",
          getter: (Connection c) => c.metadata.inboundIP,
          weight: 1),
      WeightedKey(
          name: "inboundName",
          getter: (Connection c) => c.metadata.inboundName,
          weight: 1),
      WeightedKey(
          name: "inboundPort",
          getter: (Connection c) => c.metadata.inboundPort,
          weight: 1),
      WeightedKey(
          name: "inboundUser",
          getter: (Connection c) => c.metadata.inboundUser,
          weight: 1),
      WeightedKey(
          name: "host", getter: (Connection c) => c.metadata.host, weight: 1),
      WeightedKey(
          name: "dnsMode",
          getter: (Connection c) => c.metadata.dnsMode,
          weight: 1),
      WeightedKey(
          name: "uid",
          getter: (Connection c) => c.metadata.uid.toString(),
          weight: 1),
      WeightedKey(
          name: "process",
          getter: (Connection c) => c.metadata.process,
          weight: 1),
      WeightedKey(
          name: "processPath",
          getter: (Connection c) => c.metadata.processPath,
          weight: 1),
      WeightedKey(
          name: "specialProxy",
          getter: (Connection c) => c.metadata.specialProxy,
          weight: 1),
      WeightedKey(
          name: "specialRules",
          getter: (Connection c) => c.metadata.specialRules,
          weight: 1),
      WeightedKey(
          name: "remoteDestination",
          getter: (Connection c) => c.metadata.remoteDestination,
          weight: 1),
      WeightedKey(
          name: "sniffHost",
          getter: (Connection c) => c.metadata.sniffHost,
          weight: 1),
    ]),
  ).search(query).map((result) => result.item).toList();
  return connections.copyWith(connections: filteredConnections);
}
