import '../models/reddit_record.dart';
import 'network_data_json.dart';
import 'reddit_repository.dart';

class NetworkRedditRepository extends RedditRepository {
  NetworkRedditRepository();

  static const String jsonNetworkUrl =
      'https://www.reddit.com/r/flutterdev/new.json';

  @override
  Future<List<RedditRecord>> loadReddit() async {
    List<RedditRecord> allReddit = [];
    await NetworkDataJson.get(jsonNetworkUrl);

    if (NetworkDataJson.error == '') {
      try {
        allReddit = NetworkDataJson.data['data']['children']
            .map<RedditRecord>((e) => RedditRecord.fromJson(e['data']))
            .toList();
      } catch (e) {
        allReddit = [];
      }
    }
    return allReddit;
  }
}
