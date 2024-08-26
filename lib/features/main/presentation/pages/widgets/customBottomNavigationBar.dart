import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigationBar oldWidget) {
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(24, 24, 32, 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  double size = widget.selectedIndex == 0
                      ? 30 + 5 * _animationController.value
                      : 30 - 5 * _animationController.value;
                  return Icon(Icons.schedule, size: size);
                },
              ),
              label: 'Routine',
            ),
            BottomNavigationBarItem(
              icon: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  double size = widget.selectedIndex == 1
                      ? 30 + 5 * _animationController.value
                      : 30 - 5 * _animationController.value;
                  return Icon(Icons.pages, size: size);
                },
              ),
              label: 'Demo',
            ),
          ],
          currentIndex: widget.selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.white60,
          onTap: (index) {
            widget.onTap(index);
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
