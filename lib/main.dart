import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:flutter/services.dart';
import 'package:photoform/linear_icons.dart';
import 'package:photoform/slides/calendar_slide.dart';
import 'package:photoform/slides/pinterest_slide.dart';
import 'package:photoform/slides/question_slide.dart';
import 'dart:convert';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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

  void _goBack() {
    setState(() {
      _stage = Stage.values[_stage.index];
    });
  }

  String title() {
    switch (_stage) {
      case Stage.Count:
        return "How much?";
      case Stage.Type:
        return "How much?";
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
        return const QuestionSlide(
          [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
        );

      case Stage.Type:
        return const QuestionSlide(
          [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
        );

      case Stage.City:
        return const QuestionSlide(
          [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
        );

      case Stage.Location:
        return const QuestionSlide(
          [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
        );

      case Stage.Pinterest:
        return const QuestionSlide(
          [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
        );

      case Stage.Calendar:
        return const QuestionSlide(
          [
            Answer("0", "images/nobody.jpg"),
            Answer("1", "images/individual.jpg"),
            Answer("2", "images/pair.jpg"),
            Answer("3+", "images/group.jpg"),
          ],
          QuestionType.Single,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: _stage.index < 0,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: (() => {_goBack()}),
                          icon: const Icon(LinearIcons.chevron_left),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(title()),
              ],
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
            const StepProgressIndicator(
              totalSteps: 100,
              currentStep: 32,
              size: 8,
              padding: 0,
              selectedColor: Colors.black,
              unselectedColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
