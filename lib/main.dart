import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'observables/state_observable.dart';
import 'views/home_view.dart';
import 'views/record_view.dart';
import 'repository/network_reddit_repository.dart';

void main() => runApp(const RedditMobXApp());

const String title = 'Reddit News';

class RedditMobXApp extends StatelessWidget {
  const RedditMobXApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => StateObservable(NetworkRedditRepository()),
        )
      ],
      child: MaterialApp(
        title: title,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case RecordView.routeName:
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(builder: (BuildContext context) {
                return RecordView(
                  title: title,
                  recordId: args['rec_id'],
                );
              });
            default:
              return MaterialPageRoute(builder: (BuildContext context) {
                return const HomeView(title: title);
              });
          }
        },
      ),
    );
  }
}
