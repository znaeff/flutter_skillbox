// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StateObservable on AStateObservable, Store {
  Computed<bool>? _$isLoadedComputed;

  @override
  bool get isLoaded =>
      (_$isLoadedComputed ??= Computed<bool>(() => super.isLoaded,
              name: 'AStateObservable.isLoaded'))
          .value;
  Computed<List<RedditRecord>>? _$allRedditComputed;

  @override
  List<RedditRecord> get allReddit => (_$allRedditComputed ??=
          Computed<List<RedditRecord>>(() => super.allReddit,
              name: 'AStateObservable.allReddit'))
      .value;

  late final _$redditRecordsAtom =
      Atom(name: 'AStateObservable.redditRecords', context: context);

  @override
  List<RedditRecord> get redditRecords {
    _$redditRecordsAtom.reportRead();
    return super.redditRecords;
  }

  @override
  set redditRecords(List<RedditRecord> value) {
    _$redditRecordsAtom.reportWrite(value, super.redditRecords, () {
      super.redditRecords = value;
    });
  }

  late final _$_initRedditAsyncAction =
      AsyncAction('AStateObservable._initReddit', context: context);

  @override
  Future<void> _initReddit() {
    return _$_initRedditAsyncAction.run(() => super._initReddit());
  }

  late final _$reloadRedditFullAsyncAction =
      AsyncAction('AStateObservable.reloadRedditFull', context: context);

  @override
  Future<void> reloadRedditFull() {
    return _$reloadRedditFullAsyncAction.run(() => super.reloadRedditFull());
  }

  late final _$reloadRedditAddAsyncAction =
      AsyncAction('AStateObservable.reloadRedditAdd', context: context);

  @override
  Future<void> reloadRedditAdd() {
    return _$reloadRedditAddAsyncAction.run(() => super.reloadRedditAdd());
  }

  @override
  String toString() {
    return '''
redditRecords: ${redditRecords},
isLoaded: ${isLoaded},
allReddit: ${allReddit}
    ''';
  }
}
