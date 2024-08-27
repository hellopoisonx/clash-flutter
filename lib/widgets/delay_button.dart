import 'package:flutter/material.dart';

class DelayButton extends StatefulWidget {
  const DelayButton({super.key, this.initialDelay, required this.delayTest});

  final int? initialDelay;
  final Future<int?> Function() delayTest;

  @override
  State<DelayButton> createState() => _DelayButtonState();
}

class _DelayButtonState extends State<DelayButton> {
  late Future<int?> _delayFuture;

  @override
  void didUpdateWidget(covariant DelayButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialDelay != widget.initialDelay) {
      setState(() {
        _delayFuture = Future.value(widget.initialDelay);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _delayFuture = Future.value(widget.initialDelay);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: _delayFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return TextButton(
            onPressed: _fetchDelay,
            child: Text(
              "Err",
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.red),
            ),
          );
        } else if (!snapshot.hasData) {
          return TextButton(
            onPressed: _fetchDelay,
            child: Text(
              "Err",
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.red),
            ),
          );
        } else {
          final delay = snapshot.data!;
          final color = delay >= 500
              ? Colors.red
              : delay >= 200
                  ? Colors.orange
                  : Colors.green;
          return TextButton(
            onPressed: _fetchDelay,
            child: Text(
              snapshot.data.toString(),
              style: DefaultTextStyle.of(context).style.copyWith(color: color),
            ),
          );
        }
      },
    );
  }

  Future<void> _fetchDelay() async {
    setState(() {
      _delayFuture = widget.delayTest();
    });
  }
}
