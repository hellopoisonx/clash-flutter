import 'dart:convert';

import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/providers/apis/apis.dart';
import 'package:clash_flutter/models/connections/connections.dart';
import 'package:clash_flutter/providers/connections/connections.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traffic/traffic.dart';

class ConnectionsPage extends ConsumerStatefulWidget {
  const ConnectionsPage({super.key});

  @override
  ConsumerState<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends ConsumerState<ConnectionsPage> {
  late final horScrollController = ScrollController();
  List<Connection> _cache = [];
  String query = "";
  int? hightlightIdx;
  @override
  Widget build(BuildContext context) {
    final filteredConnections = ref.watch(filteredConnectionsProvider(query));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(61),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (val) {
                    setState(() => query = val.trim());
                  },
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () async =>
                    (await ref.read(apisProvider.future)).closeALlConnections(),
                icon: const Icon(Icons.cancel_rounded),
              ),
            ],
          ),
        ),
      ),
      body: filteredConnections.when(
        loading: () {
          return _buildConnectionsBoard(horScrollController, _cache, ref);
        },
        error: (error, stack) {
          MyException.show(
              error: error, recover: () => ref.invalidate(coreStatusProvider));
          return null;
        },
        data: (connections) {
          _cache = connections.connections;
          return _buildConnectionsBoard(horScrollController, _cache, ref);
        },
      ),
    );
  }

  LayoutBuilder _buildConnectionsBoard(ScrollController horScrollController,
      List<Connection> connections, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          controller: horScrollController,
          child: SingleChildScrollView(
            controller: horScrollController,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Table(
                  border: const TableBorder(
                    verticalInside: BorderSide(width: 0.05),
                    horizontalInside: BorderSide(width: 0.05),
                  ),
                  columnWidths: const {
                    0: FixedColumnWidth(40),
                    1: FixedColumnWidth(40),
                    2: FixedColumnWidth(90),
                    3: FixedColumnWidth(90),
                    4: FixedColumnWidth(200),
                    5: FixedColumnWidth(80),
                    6: FixedColumnWidth(150),
                    7: FixedColumnWidth(390),
                    8: FixedColumnWidth(110),
                    9: FixedColumnWidth(110),
                    10: FixedColumnWidth(95),
                    11: FixedColumnWidth(95),
                    12: FixedColumnWidth(80),
                    13: FixedColumnWidth(90),
                    14: FixedColumnWidth(90),
                    15: FixedColumnWidth(110),
                    16: FixedColumnWidth(120),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: () {
                    List<TableRow> children = [
                      TableRow(
                          children: [
                        "detail",
                        "close",
                        "type",
                        "process",
                        "host",
                        "sniffHost",
                        "rule",
                        "chains",
                        "downloadSpeed",
                        "uploadSpeed",
                        "download",
                        "upload",
                        "start",
                        "sourceHost",
                        "sourcePort",
                        "destHost",
                        "inboundUser"
                      ].map((e) => Center(child: Text(e))).toList())
                    ];
                    for (var i = 0; i < (connections.length); i++) {
                      final c = connections[i];
                      children.add(TableRow(
                          decoration: BoxDecoration(
                              color: i == hightlightIdx
                                  ? const Color.fromRGBO(232, 222, 248, 1)
                                  : Colors.transparent),
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        final navi = Navigator.of(context);
                                        return AlertDialog(
                                          title: Align(
                                            alignment: Alignment.centerLeft,
                                            child: IconButton(
                                                onPressed: () => navi.pop(),
                                                icon: const Icon(
                                                    Icons.arrow_back)),
                                          ),
                                          alignment: Alignment.center,
                                          content: SelectableText(
                                            const JsonEncoder.withIndent('  ')
                                                .convert(c),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.info)),
                            IconButton(
                                onPressed: () async =>
                                    (await ref.read(apisProvider.future))
                                        .closeSingleConnection(c.id),
                                icon: const Icon(Icons.cancel)),
                            Text("${c.metadata.type}(${c.metadata.network})"),
                            Text(c.metadata.process),
                            Text(c.metadata.host),
                            Text(c.metadata.sniffHost),
                            Text("${c.rule}::${c.rulePayload}"),
                            Text(c.chains.join("::")),
                            Text("${Traffic.fromByte(
                              byte: _getSpeed(
                                c.download,
                                c.start,
                              ).toInt(),
                            )}/s"),
                            Text(
                                "${Traffic.fromByte(byte: _getSpeed(c.upload, c.start).toInt())}/s"),
                            Text(Traffic.fromByte(byte: c.download.toInt())
                                .toString()),
                            Text(Traffic.fromByte(byte: c.upload.toInt())
                                .toString()),
                            Text(
                                "${DateTime.now().difference(c.start).inHours < 1 ? DateTime.now().difference(c.start).inMinutes < 1 ? "${DateTime.now().difference(c.start).inSeconds}s" : "${DateTime.now().difference(c.start).inMinutes}m" : "${DateTime.now().difference(c.start).inHours}h"} ago"),
                            Text(c.metadata.sourceIP),
                            Text(c.metadata.sourcePort),
                            Text(c.metadata.remoteDestination),
                            Text(c.metadata.inboundName),
                          ]
                              .map((e) => MouseRegion(
                                    onEnter: (_) =>
                                        setState(() => hightlightIdx = i),
                                    onExit: (_) =>
                                        setState(() => hightlightIdx = null),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Center(child: e)),
                                  ))
                              .toList()));
                    }
                    return children;
                  }(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getSpeed(int? byte, DateTime? start) {
    byte ??= 0;
    final now = DateTime.now();
    final period = now.difference(start ?? now).inSeconds;
    if (period == 0) return 0.0;
    return byte.toDouble() / period;
  }
}
