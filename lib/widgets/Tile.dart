import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:photoform/services/pinterest_service.dart';
import 'package:photoform/widgets/Tappable.dart';
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
    return Column(
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
            child: Text(title!).tr(),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onTap,
      isSelected: isSelected,
      child: data != null
          ? AspectRatio(
              aspectRatio: data!.width / data!.height,
              child: content(),
            )
          : content(),
    );
  }
}
