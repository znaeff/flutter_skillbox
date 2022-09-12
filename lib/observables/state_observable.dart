import 'package:mobx/mobx.dart';
import '../models/reddit_record.dart';
import '../repository/reddit_repository.dart';

part 'state_observable.g.dart';

class StateObservable = AStateObservable with _$StateObservable;

abstract class AStateObservable with Store {
  final RedditRepository _redditRepository;

  @observable
  List<RedditRecord> redditRecords = [];

  @computed
  List<RedditRecord> get allReddit => redditRecords.toList();

  @computed
  bool get isLoaded => redditRecords.isNotEmpty;

  @computed
  RedditRecord? oneRedditById(String id) {
    try {
      return redditRecords.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  AStateObservable(this._redditRepository) {
    _initReddit();
  }

  @action
  Future<void> _initReddit() async {
    redditRecords = await _redditRepository.loadReddit();
    // для проверки обновления с дополнением
    //List<RedditRecord> redditRecordsNew = await _redditRepository.loadReddit();
    //redditRecords = redditRecordsNew.sublist(10);
  }

  @action
  Future<void> reloadRedditFull() async {
    redditRecords = await _redditRepository.loadReddit();
  }

  @action
  Future<void> reloadRedditAdd() async {
    if (redditRecords.isEmpty) {
      redditRecords = await _redditRepository.loadReddit();
    } else {
      List<RedditRecord> redditRecordsOld = [...redditRecords];
      redditRecords = await _redditRepository.loadReddit();
      // для проверки обновления с дополнением
      // List<RedditRecord> redditRecordsNew =
      //     await _redditRepository.loadReddit();
      // redditRecords = redditRecordsNew.sublist(0, 15);
      if (redditRecords.isEmpty) {
        redditRecords = redditRecordsOld;
      } else {
        // берём последний id из новых
        String lastIdNew = redditRecords[redditRecords.length - 1].id;
        // ищем его в старых
        // добавим старые, которые ПОСЛЕ него, в новый
        bool add2New = false;
        for (int i = 0; i < redditRecordsOld.length; i++) {
          if (add2New) {
            redditRecords.add(redditRecordsOld[i]);
          }
          if (!add2New && redditRecordsOld[i].id == lastIdNew) {
            add2New = true;
          }
        }
      }
    }
  }
}
