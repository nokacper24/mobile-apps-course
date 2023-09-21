import 'package:flutter/material.dart';

class DemoButtons extends StatefulWidget {
  const DemoButtons({super.key});

  @override
  State<DemoButtons> createState() {
    return _DemoButtonsState();
  }
}

class _DemoButtonsState extends State<DemoButtons> {
  var _isUnderstood = false;

  setIsUnderstood(bool isUnderstood) {
    if (_isUnderstood != isUnderstood) {
      setState(() {
        _isUnderstood = isUnderstood;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Demobuttons BUILD called');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setIsUnderstood(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setIsUnderstood(true);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        if (_isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
