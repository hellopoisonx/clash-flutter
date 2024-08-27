import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator(
      {super.key,
      required this.status,
      required this.prefix,
      required this.size});

  final bool status;
  final String prefix;
  final double size;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(prefix),
          ),
          Container(
            height: size,
            width: size,
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: status ? Colors.green : Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
