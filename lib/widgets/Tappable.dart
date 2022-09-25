import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tappable extends StatefulWidget {
  const Tappable({
    this.isSelected = false,
    this.isEnabled = true,
    required this.child,
    this.onTap,
    super.key,
  });

  final Widget child;
  final bool isSelected;
  final bool isEnabled;
  final void Function()? onTap;

  @override
  State<Tappable> createState() => _TappableState();
}

class _TappableState extends State<Tappable> {
  var isTapped = false;
  var isHovered = false;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 200);
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      cursor: widget.isEnabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.noDrop,
      child: GestureDetector(
        onTapDown: ((details) {
          setState(() {
            isTapped = true;
          });
        }),
        onTapUp: ((details) {
          setState(() {
            isTapped = false;
          });
        }),
        onTapCancel: (() {
          setState(() {
            isTapped = false;
          });
        }),
        onTap: (() {
          if (widget.isEnabled && widget.onTap != null) {
            widget.onTap!();
          }
        }),
        child: AnimatedScale(
          scale: !widget.isEnabled
              ? 1.0
              : widget.isSelected
                  ? 0.9
                  : isTapped
                      ? 0.9
                      : 1.0,
          curve: Curves.easeInOut,
          duration: duration,
          child: AnimatedOpacity(
            opacity: !widget.isEnabled
                ? 0.3
                : widget.isSelected
                    ? 0.5
                    : isTapped
                        ? 0.5
                        : isHovered
                            ? 0.7
                            : 1.0,
            duration: duration,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
