import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photoform/services/pinterest_service.dart';
import 'package:photoform/slides/calendar_slide.dart';
import 'package:photoform/widgets/Tile.dart';
import 'package:shimmer/shimmer.dart';

class PinterestSlide extends StatefulWidget with Slide<List<PinImage>> {
  PinterestSlide(this.onFinished, {super.key});

  final PinterestService _pinterest = PinterestService();

  @override
  final ValueSetter<List<PinImage>> onFinished;

  @override
  State<PinterestSlide> createState() => _PinterestSlideState();
}

class _PinterestSlideState extends State<PinterestSlide> {
  late Future<List<PinImage>> futureResponses;

  List<int> selectedList = [];

  @override
  void initState() {
    super.initState();
    futureResponses = widget._pinterest.scrab();
  }

  Widget mockGrid(BuildContext context) {
    return IgnorePointer(
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).highlightColor,
        highlightColor: Colors.white,
        child: MasonryGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          itemBuilder: (context, index) {
            return Container(color: Colors.black, height: (index % 5 + 2) * 50);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PinImage>>(
      future: futureResponses,
      builder: (context, snapshot) {
        return AnimatedCrossFade(
          duration: const Duration(seconds: 3),
          firstChild: snapshot.hasData
              ? MasonryGridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Expanded(
                      child: Tile(
                        data: snapshot.data![index],
                        isSelected: selectedList.contains(index),
                        onTap: () {
                          setState(() {
                            if (selectedList.contains(index)) {
                              selectedList.remove(index);
                            } else {
                              selectedList.add(index);
                            }
                          });
                        },
                      ),
                    );
                  },
                )
              : Text('${snapshot.error}'),
          secondChild: mockGrid(context),
          crossFadeState: snapshot.hasData || snapshot.hasError
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        );
      },
    );
  }
}
