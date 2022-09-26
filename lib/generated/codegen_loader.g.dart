// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru_RU = {
  "apply": "Next",
  "count": {
    "title": "How much people?",
    "answer": {
      "nobody": "Nobody",
      "individual": "One",
      "pair": "Two",
      "group": "Three or more"
    }
  },
  "type": {
    "title": "What type of photoshoot?",
    "answer": {
      "love_story": "Love story",
      "individual": "Individual",
      "group": "Group",
      "two_girls": "Two girls",
      "mom_son": "Mom and son",
      "mom_dauther": "Mom and daughter",
      "family": "Family with child",
      "report": "Report",
      "content": "Content"
    }
  },
  "city": {
    "title": "Where are you located?",
    "answer": {
      "belgrade": "Belgrade, Serbia",
      "novi_sad": "Novi sad, Serbia",
      "tolyatti": "Tolyatti, Russia",
      "samara": "Samara, Russia",
      "nizhny_novgorod": "Nizhny Novgorod, Russia"
    }
  },
  "location": {
    "title": "Where do you want to shoot?",
    "answer": {
      "street": "Street",
      "nature": "Nature",
      "studio": "Studio"
    }
  },
  "references": {
    "title": "What kind of photos do you want?"
  },
  "calendar": {
    "title": "When you want to shoot?"
  }
};
static const Map<String,dynamic> en_US = {
  "apply": "Next",
  "count": {
    "title": "How much people?",
    "answer": {
      "nobody": "Nobody",
      "individual": "One",
      "pair": "Two",
      "group": "Three or more"
    }
  },
  "type": {
    "title": "What type of photoshoot?",
    "answer": {
      "love_story": "Love story",
      "individual": "Individual",
      "group": "Group",
      "two_girls": "Two girls",
      "mom_son": "Mom and son",
      "mom_dauther": "Mom and daughter",
      "family": "Family with child",
      "report": "Report",
      "content": "Content"
    }
  },
  "city": {
    "title": "Where are you located?",
    "answer": {
      "belgrade": "Belgrade, Serbia",
      "novi_sad": "Novi sad, Serbia",
      "tolyatti": "Tolyatti, Russia",
      "samara": "Samara, Russia",
      "nizhny_novgorod": "Nizhny Novgorod, Russia"
    }
  },
  "location": {
    "title": "Where do you want to shoot?",
    "answer": {
      "street": "Street",
      "nature": "Nature",
      "studio": "Studio"
    }
  },
  "references": {
    "title": "What kind of photos do you want?"
  },
  "calendar": {
    "title": "When you want to shoot?"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru_RU": ru_RU, "en_US": en_US};
}
