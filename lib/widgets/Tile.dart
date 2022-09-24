import 'package:flutter/widgets.dart';
import 'package:photoform/services/pinterest_service.dart';
import 'package:transparent_image/transparent_image.dart';

class Tile extends StatelessWidget {
  final PinImage? data;
  final String? assetImage;
  final String? title;
  final bool isSelected;
  final Function() onTap;

  Tile({
    super.key,
    this.title,
    this.data,
    this.assetImage,
    required this.isSelected,
    required this.onTap,
  });

  Widget content() {
    const duration = Duration(milliseconds: 200);

    return AnimatedScale(
      scale: isSelected ? 0.9 : 1.0,
      curve: Curves.easeInOut,
      duration: duration,
      child: AnimatedOpacity(
        opacity: isSelected ? 0.5 : 1.0,
        duration: duration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data == null
                ? Image.asset(assetImage!)
                : FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: data!.url.toString(),
                  ),
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(title!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: data != null
            ? AspectRatio(
                aspectRatio: data!.width / data!.height,
                child: content(),
              )
            : content(),
      ),
    );
  }
}
