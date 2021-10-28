import 'package:flutter_architecture/data/phrase_service.dart';
import 'package:flutter_architecture/data/style_service.dart';
import 'package:flutter_architecture/model/style_data.dart';

class MainBloc {
  final PhraseService phraseService;
  final StyleService styleService;

  MainBloc({
    required this.phraseService,
    required this.styleService,
  });

  String getPhrase({int position = 0}) {
    return phraseService.getRandomPhrase(position: position);
  }

  StyleData getStyle({int position = 0}) {
    return styleService.getRandomStyle(position: position);
  }
}
