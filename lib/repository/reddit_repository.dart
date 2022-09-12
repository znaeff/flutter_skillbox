import '../models/reddit_record.dart';

abstract class RedditRepository {
  const RedditRepository();

  Future<List<RedditRecord>> loadReddit();
}
