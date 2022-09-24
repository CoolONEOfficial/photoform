import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photoform/services/pinterest_service.dart';
import 'package:photoform/widgets/Tile.dart';

enum QuestionType { Single, Multiple }

class Answer {
  const Answer(this.text, this.image);

  final String text;
  final String image;
}

class QuestionSlide extends StatefulWidget {
  const QuestionSlide(this.answers, this.type, {super.key});

  final List<Answer> answers;
  final QuestionType type;

  @override
  State<QuestionSlide> createState() => _QuestionSlideState();
}

class _QuestionSlideState extends State<QuestionSlide> {
  List<int> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: widget.answers.length,
      itemBuilder: (context, index) {
        final answer = widget.answers[index];
        return Expanded(
          child: Tile(
            title: answer.text,
            assetImage: answer.image,
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
    );
  }
}
