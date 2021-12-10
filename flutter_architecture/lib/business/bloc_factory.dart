import 'package:get_it/get_it.dart';
import 'package:flutter_architecture/data/phrase_service.dart';
import 'package:flutter_architecture/data/service_provider.dart';
import 'package:flutter_architecture/data/style_service.dart';

import 'main_bloc.dart';

class BlocFactory {
  static final _getIt = GetIt.I;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = BlocFactory();

  void initialize() {
    ServiceProvider.instance.initialize();
    _getIt.registerFactory<MainBloc>(
      () => MainBloc(
        phraseService: ServiceProvider.instance.get<PhraseService>(),
        styleService: ServiceProvider.instance.get<StyleService>(),
      ),
    );
  }
}
