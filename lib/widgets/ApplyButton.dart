import 'package:flutter/material.dart';
import 'package:photoform/widgets/Tappable.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton(this.onTap, {super.key, this.isEnabled = true});

  final bool isEnabled;
  final void Function() onTap;

  Widget content() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: const Text(
        "Apply",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Tappable(
        child: content(),
        isEnabled: isEnabled,
        onTap: onTap,
      ),
    );
  }
}
