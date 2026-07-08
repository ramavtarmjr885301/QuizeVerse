import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final int duration;
  final VoidCallback onTimerFinished;
  final Function(int) onTick;

  const TimerWidget({
    super.key,
    required this.duration,
    required this.onTimerFinished,
    required this.onTick,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remaining--;
        widget.onTick(_remaining);

        if (_remaining <= 0) {
          _timer?.cancel();
          widget.onTimerFinished();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _remaining / widget.duration;
    final color = percentage > 0.5
        ? Colors.green
        : percentage > 0.25
        ? Colors.orange
        : Colors.red;

    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.timer, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            Text(
              '$_remaining s',
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Progress circle
            SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                value: percentage,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeWidth: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
