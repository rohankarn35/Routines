import 'package:flutter/material.dart';

class ShakingAlarmIcon extends StatefulWidget {
  final double size;

  const ShakingAlarmIcon({Key? key, this.size = 90}) : super(key: key);

  @override
  _ShakingAlarmIconState createState() => _ShakingAlarmIconState();
}

class _ShakingAlarmIconState extends State<ShakingAlarmIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInBack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: Icon(
            Icons.alarm_on_rounded,
            size: widget.size,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
