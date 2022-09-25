import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:flutter/services.dart';
import 'package:photoform/linear_icons.dart';
import 'package:photoform/slides/question_slide.dart';
import 'package:photoform/widgets/Tappable.dart';
import 'dart:convert';

import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  SchemaValidator.enabled = false;
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      home: const HomePage(title: "test"),
      theme: theme,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Stage {
  Count,
  Type,
  City,
  Location,
  Pinterest,
  Calendar,
}

class _HomePageState extends State<HomePage> {
  Stage _stage = Stage.Count;
  Map<Stage, dynamic> _answers = {};

  void _goBack() {
    setState(() {
      _stage = Stage.values[_stage.index - 1];
    });
  }

  String title() {
    switch (_stage) {
      case Stage.Count:
        return "How much?";
      case Stage.Type:
        return "How 22?";
      case Stage.City:
        return "How much?";
      case Stage.Location:
        return "How much?";
      case Stage.Pinterest:
        return "How much?";
      case Stage.Calendar:
        return "How much?";
    }
  }

  Widget slide() {
    switch (_stage) {
      case Stage.Count:
        return QuestionSlide(
          const [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
          ((value) {
            setState(() {
              _stage = Stage.Type;
            });
          }),
        );

      case Stage.Type:
        return QuestionSlide(
          const [
            Answer("111", "images/individual.jpg"),
            Answer("0", "images/nobody.jpg"),
          ],
          QuestionType.Single,
          ((value) {}),
        );

      case Stage.City:
        return QuestionSlide(
          const [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
          ((value) {}),
        );

      case Stage.Location:
        return QuestionSlide(
          const [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
          ((value) {}),
        );

      case Stage.Pinterest:
        return QuestionSlide(
          const [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
          ((value) {}),
        );

      case Stage.Calendar:
        return QuestionSlide(
          const [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
          ((value) {}),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Tappable(
                      child: Icon(LinearIcons.chevron_left),
                      onTap: _goBack,
                      isEnabled: _stage.index > 0,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(title()),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       const Text(
          //         'You have pushed the button this many times:',
          //       ),
          //       const Icon(LinearIcons.alarm),
          //       Text(
          //         '$_counter',
          //         style: Theme.of(context).textTheme.headline4,
          //       ),
          //     ],
          //   ),
          // ),

          Expanded(
            child: slide(),
          ),

          // CalendarSlide(
          //   onFinished: (value) {},
          // ),
          LinearProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.black,
            minHeight: 15,
            value: (_stage.index + 1) / Stage.values.length,
          ),
        ],
      ),
    );
  }
}
