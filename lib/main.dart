import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:flutter/services.dart';
import 'package:photoform/generated/locale_keys.g.dart';
import 'package:photoform/linear_icons.dart';
import 'package:photoform/slides/calendar_slide.dart';
import 'package:photoform/slides/pinterest_slide.dart';
import 'package:photoform/slides/question_slide.dart';
import 'package:photoform/widgets/Tappable.dart';
import 'dart:convert';
import 'generated/codegen_loader.g.dart';

import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  SchemaValidator.enabled = false;
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
    path: 'assets/langs',
    fallbackLocale: Locale('en', 'US'),
    child: MyApp(theme: theme),
    assetLoader: CodegenLoader(),
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
      home: const HomePage(),
      theme: theme,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Stage {
  Count,
  City,
  Type,
  Location,
  References,
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
        return LocaleKeys.count_title;
      case Stage.City:
        return LocaleKeys.city_title;
      case Stage.Type:
        return LocaleKeys.type_title;
      case Stage.Location:
        return LocaleKeys.location_title;
      case Stage.References:
        return LocaleKeys.references_title;
      case Stage.Calendar:
        return LocaleKeys.calendar_title;
    }
  }

  Widget slide() {
    switch (_stage) {
      case Stage.Count:
        return QuestionSlide(
          const [
            Answer(LocaleKeys.count_answer_nobody, "images/nobody.jpg"),
            Answer(LocaleKeys.count_answer_individual, "images/individual.jpg"),
            Answer(LocaleKeys.count_answer_pair, "images/pair.jpg"),
            Answer(LocaleKeys.count_answer_group, "images/group.jpg"),
          ],
          QuestionType.Single,
          ((value) {
            _answers[Stage.Count] = value.first;
            setState(() {
              _stage = Stage.City;
            });
          }),
        );

      case Stage.City:
        return QuestionSlide(
          const [
            Answer(LocaleKeys.city_answer_belgrade, "images/nobody.jpg"),
            Answer(LocaleKeys.city_answer_novi_sad, "images/nobody.jpg"),
            Answer(LocaleKeys.city_answer_tolyatti, "images/individual.jpg"),
            Answer(LocaleKeys.city_answer_samara, "images/individual.jpg"),
            Answer(LocaleKeys.city_answer_nizhny_novgorod, "images/pair.jpg"),
          ],
          QuestionType.Single,
          ((value) {
            setState(() {
              _stage = Stage.Type;
            });
          }),
        );

      case Stage.Type:
        final type = _answers[Stage.Type] as Answer;
        return QuestionSlide(
          [
            if (type.text == LocaleKeys.count_answer_individual) ...[
              const Answer(
                  LocaleKeys.type_answer_individual, "images/individual.jpg"),
            ],
            if (type.text == LocaleKeys.count_answer_group) ...[
              const Answer(LocaleKeys.type_answer_family, "images/nobody.jpg"),
              const Answer(LocaleKeys.type_answer_group, "images/nobody.jpg"),
              const Answer(LocaleKeys.type_answer_report, "images/nobody.jpg"),
            ],
            if (type.text == LocaleKeys.count_answer_pair) ...[
              const Answer(
                  LocaleKeys.type_answer_mom_dauther, "images/nobody.jpg"),
              const Answer(LocaleKeys.type_answer_mom_son, "images/nobody.jpg"),
              const Answer(
                  LocaleKeys.type_answer_two_girls, "images/nobody.jpg"),
              const Answer(
                  LocaleKeys.type_answer_love_story, "images/nobody.jpg"),
            ],
            const Answer(LocaleKeys.type_answer_content, "images/nobody.jpg"),
          ],
          QuestionType.Single,
          ((value) {
            setState(() {
              _stage = Stage.Location;
            });
          }),
        );

      case Stage.Location:
        return QuestionSlide(
          const [
            Answer(LocaleKeys.location_answer_nature, "images/nobody.jpg"),
            Answer(LocaleKeys.location_answer_street, "images/individual.jpg"),
            Answer(LocaleKeys.location_answer_studio, "images/pair.jpg"),
          ],
          QuestionType.Single,
          ((value) {
            setState(() {
              _stage = Stage.References;
            });
          }),
        );

      case Stage.References:
        return PinterestSlide(
          ((value) {
            setState(() {
              _stage = Stage.Calendar;
            });
          }),
        );

      case Stage.Calendar:
        return CalendarSlide(
          ((value) {
            // final
          }),
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
                      onTap: _goBack,
                      isEnabled: _stage.index > 0,
                      child: const Icon(LinearIcons.chevron_left),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(title()).tr(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: slide(),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.black,
            minHeight: 15,
            value: (_stage.index + 1) / (Stage.values.length + 1),
          ),
        ],
      ),
    );
  }
}
