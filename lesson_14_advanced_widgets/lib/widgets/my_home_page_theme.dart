import 'package:flutter/material.dart';

import 'my_shadow_text.dart';
import 'my_weather_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> tabBarNav = [
    {
      'icon': const Icon(Icons.settings),
      'label': 'Профиль',
    },
    {
      'icon': const Icon(Icons.smart_display),
      'label': 'Погода',
    },
    {
      'icon': const Icon(Icons.directions_boat),
      'label': 'Тень',
    },
  ];

  final List<Map<String, dynamic>> themeRadios = [
    {
      'label': 'Красный',
      'value': 'red',
      'my_theme': ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    },
    {
      'label': 'Зелёный',
      'value': 'green',
      'my_theme': ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    },
    {
      'label': 'Синий',
      'value': 'blue',
      'my_theme': ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    },
  ];

  static const double weatherSizeSmall = 100.0;
  static const double weatherSizeBig = 200.0;

  late TabController _tabController;
  late AnimationController _animController;
  late Animation<double> _animation;
  int _currentTabIndex = 0;
  String _currentThemeRadio = 'red';
  late ThemeData _currentTheme = themeRadios[0]['my_theme'];
  int _weatherBadness = 0;
  bool _weatherIsSmall = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: tabBarNav.length,
      vsync: this,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });

    _animController = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(begin: weatherSizeSmall, end: weatherSizeBig)
        .animate(_animController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void changeWeatherBadness() {
    setState(() {
      _weatherBadness = _weatherBadness < 10 ? _weatherBadness + 1 : 0;
    });
  }

  void changeWeatherSize() {
    setState(() {
      _weatherIsSmall ? _animController.forward() : _animController.reverse();
      _weatherIsSmall = !_weatherIsSmall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _currentTheme,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView(
                children: themeRadios
                    .map((e) => RadioListTile(
                          groupValue: true,
                          value:
                              _currentThemeRadio == e['value'] ? true : false,
                          title: Text(e['label']),
                          onChanged: (bool? value) {
                            setState(() {
                              _currentThemeRadio = e['value'];
                              _currentTheme = e['my_theme'];
                            });
                          },
                        ))
                    .toList(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: changeWeatherBadness,
                        child: Text('Плохость погоды $_weatherBadness'),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: changeWeatherSize,
                    child: SizedBox(
                      width: _animation.value,
                      height: _animation.value,
                      child: CustomPaint(
                        painter: MyWeatherIndicator(
                          _weatherBadness / 10,
                          cloudColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyShadowText(
                      color: Theme.of(context).colorScheme.primary,
                      child: const Text(
                        'Тень',
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                    MyShadowText(
                      color: Theme.of(context).colorScheme.primary,
                      child: const Icon(
                        Icons.directions_boat,
                        size: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                _currentTabIndex = index;
                _tabController.index = index;
              });
            },
            currentIndex: _currentTabIndex,
            items: tabBarNav
                .map((item) => BottomNavigationBarItem(
                    icon: item['icon'], label: item['label']))
                .toList(),
          ),
        );
      }),
    );
  }
}
