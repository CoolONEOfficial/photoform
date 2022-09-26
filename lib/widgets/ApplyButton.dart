import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:photoform/generated/locale_keys.g.dart';
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
      child: Text(
        LocaleKeys.apply.tr(),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Tappable(
        isEnabled: isEnabled,
        onTap: onTap,
        child: content(),
      ),
    );
  }
}
