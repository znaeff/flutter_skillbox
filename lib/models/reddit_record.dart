class RedditRecord {
  final String id;
  final String title;
  final String selftext;
  final int ups;
  final String? thumbnailUrl;

  const RedditRecord(
      {required this.id,
      required this.title,
      required this.selftext,
      required this.ups,
      required this.thumbnailUrl});

  RedditRecord.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'] ?? 'no title',
          selftext: json['selftext'] ?? 'no text',
          ups: json['ups'] ?? 0,
          thumbnailUrl: json['thumbnail'],
        );
}
