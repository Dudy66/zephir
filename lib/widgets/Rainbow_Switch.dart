import 'package:flutter/material.dart';

class RainbowSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RainbowSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Dégradé arc-en-ciel si actif
        if (value)
          Container(
            width: 60,
            height: 34,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.indigo,
                  Colors.purple,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.transparent,
          activeTrackColor: Colors.transparent,
          inactiveTrackColor: Colors.grey.shade300,
          inactiveThumbColor: Colors.grey,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
