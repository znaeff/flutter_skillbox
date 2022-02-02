import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:popover/popover.dart';
import '../models/assets_data_json.dart';
import '../models/person.dart';
import 'person_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  bool isError = false;
  String? errorText;

  static const List<String> popItems = ['Change email', 'Change photo'];
  static const int widthWide = 720;
  static const int widthWideExtra = 900;

  List<Person>? _personsList;

  getData() async {
    isError = false;
    isLoading = true;
    setState(() {});

    await AssetsDataJson.get('persons.json');

    if (AssetsDataJson.error != '') {
      isError = true;
      errorText = AssetsDataJson.error;
    } else {
      try {
        _personsList =
            AssetsDataJson.data.map<Person>((e) => Person.fromJson(e)).toList();
        if (_personsList!.isEmpty) {
          throw ('Empty data');
        }
      } catch (e) {
        isError = true;
        errorText = e.toString();
      }
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: constraints.constrainWidth() >= widthWide
              ? null
              : AppBar(
                  title: Text(widget.title),
                ),
          body: SafeArea(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : isError
                      ? Center(child: Text('$errorText'))
                      : constraints.constrainWidth() >= widthWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minHeight: 1024),
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, top: 16.0),
                                      child: Text(
                                        widget.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          constraints.constrainWidth() >=
                                                  widthWideExtra
                                              ? 3
                                              : 2,
                                      childAspectRatio: 1.1,
                                    ),
                                    itemCount: _personsList!.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                SimpleDialog(
                                                    title: Text(
                                                        _personsList![index]
                                                                .firstname +
                                                            ' ' +
                                                            _personsList![index]
                                                                .lastname),
                                                    children: popItems
                                                        .map((e) =>
                                                            SimpleDialogOption(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(e),
                                                            ))
                                                        .toList()));

                                        // При вызове из SliverGridDelegateWithFixedCrossAxisCount
                                        // бросает исключение
                                        // type 'RenderSliverGrid' is not a subtype of type 'RenderBox' in type cast
                                        //
                                        // showPopover(
                                        //   context: context,
                                        //   transitionDuration:
                                        //       const Duration(milliseconds: 150),
                                        //   bodyBuilder: (context) =>
                                        //       const PopoverMenu(
                                        //     popItems: popItems,
                                        //   ),
                                        //   direction: PopoverDirection.top,
                                        //   width: 200,
                                        //   height: 400,
                                        //   arrowHeight: 15,
                                        //   arrowWidth: 30,
                                        // );
                                      },
                                      child: PersonCard.vertical(
                                        context: context,
                                        firstname:
                                            _personsList![index].firstname,
                                        lastname: _personsList![index].lastname,
                                        email: _personsList![index].email,
                                        photo: _personsList![index].photo,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: _personsList!.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CupertinoActionSheet(
                                            title: Text(
                                              _personsList![index].firstname +
                                                  ' ' +
                                                  _personsList![index].lastname,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            actions: popItems
                                                .map((e) =>
                                                    CupertinoActionSheetAction(
                                                      child: Text(e),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ))
                                                .toList()),
                                  );
                                },
                                child: PersonCard.hosizontal(
                                  context: context,
                                  firstname: _personsList![index].firstname,
                                  lastname: _personsList![index].lastname,
                                  email: _personsList![index].email,
                                  photo: _personsList![index].photo,
                                ),
                              ),
                            )),
        );
      },
    );
  }
}

class PopoverMenu extends StatelessWidget {
  final List<String> popItems;

  const PopoverMenu({Key? key, required this.popItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: popItems
              .map((e) => InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 50,
                      color: Colors.grey,
                      child: Center(child: Text(e)),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
