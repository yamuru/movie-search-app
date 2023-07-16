import 'package:flutter/material.dart';

class IcButton extends StatelessWidget {
  const IcButton({
    super.key,
    required this.isActive,
    required this.icon,
    required this.onPressed,
    this.iconWhenActive,
  });

  final bool isActive;
  final IconData icon;
  final IconData? iconWhenActive;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final IconData activeIcon = iconWhenActive ?? icon;

    return Ink(
      decoration: ShapeDecoration(
        color: isActive
            ? const Color.fromARGB(150, 255, 87, 34)
            : Theme.of(context).focusColor,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
      child: IconButton(
        icon: Icon(isActive ? activeIcon : icon, size: 25),
        onPressed: onPressed,
      ),
    );
  }
}
