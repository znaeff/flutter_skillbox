import 'package:flutter/material.dart';

import 'my_shadow_text.dart';
import 'my_weather_indicator.dart';

class MyStyledWidget extends InheritedWidget {
  final MyAppTheme theme;

  const MyStyledWidget({required this.theme, required Widget child, Key? key})
      : super(child: child, key: key);

  @override
  bool updateShouldNotify(MyStyledWidget oldWidget) => oldWidget.theme != theme;

  static MyAppTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MyStyledWidget>();
    assert(result != null, 'No MyStyledWidget found in conext');
    return result!.theme;
  }
}

class MyAppTheme {
  final Color textColor;
  final Color appBarFgColor;
  final Color appBarBgColor;

  MyAppTheme(
      {required this.appBarFgColor,
      required this.appBarBgColor,
      required this.textColor});
}

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
      'icon': const Icon(Icons.pets),
      'label': 'Тень',
    },
  ];

  final List<Map<String, dynamic>> themeRadios = [
    {
      'label': 'Красный',
      'value': 'red',
      'my_theme': MyAppTheme(
          textColor: Colors.red,
          appBarBgColor: Colors.redAccent,
          appBarFgColor: Colors.white),
    },
    {
      'label': 'Зелёный',
      'value': 'green',
      'my_theme': MyAppTheme(
          textColor: Colors.green,
          appBarBgColor: Colors.green,
          appBarFgColor: Colors.white),
    },
    {
      'label': 'Синий',
      'value': 'blue',
      'my_theme': MyAppTheme(
          textColor: Colors.blue,
          appBarBgColor: Colors.blueAccent,
          appBarFgColor: Colors.white),
    },
  ];

  static const double weatherSizeSmall = 100.0;
  static const double weatherSizeBig = 200.0;

  late TabController _tabController;
  late AnimationController _animController;
  late Animation<double> _animation;
  int _currentTabIndex = 0;
  String _currentThemeRadio = 'red';
  late MyAppTheme _currentTheme = themeRadios[0]['my_theme'];
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
    return MyStyledWidget(
      theme: _currentTheme,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyStyledWidget.of(context).appBarBgColor,
            foregroundColor: MyStyledWidget.of(context).appBarFgColor,
            title: Text(widget.title),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView(
                children: themeRadios
                    .map((e) => RadioListTile(
                          activeColor: MyStyledWidget.of(context).textColor,
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
                        style: ElevatedButton.styleFrom(
                          primary: MyStyledWidget.of(context)
                              .appBarBgColor, // background
                          onPrimary: MyStyledWidget.of(context)
                              .appBarFgColor, // foreground
                        ),
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
                          cloudColor: MyStyledWidget.of(context).appBarBgColor,
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
                      color: MyStyledWidget.of(context).appBarBgColor,
                      child: const Text(
                        'Тень',
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                    MyShadowText(
                      color: MyStyledWidget.of(context).appBarBgColor,
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
            selectedItemColor: MyStyledWidget.of(context).textColor,
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
