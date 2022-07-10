import 'package:lesson_20_dev_tools/models/tabs.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:lesson_20_dev_tools/models/app_tab.dart';
//import 'package:lesson_20_dev_tools/models/filter.dart';
import 'package:lesson_20_dev_tools/observables/state_observable.dart';
//import 'package:lesson_20_dev_tools/widgets/filter_button.dart';
import 'package:lesson_20_dev_tools/widgets/loading_indicator.dart';
import 'package:lesson_20_dev_tools/widgets/students_list.dart';
//import 'package:lesson_20_dev_tools/widgets/talks_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateObservable>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students Mobx'),
        // actions: [
        //   Observer(
        //       builder: (context) => FilterButton(
        //             visible: state.activeTabIndex == AppTab.students.index,
        //             activeFilter: state.activeFilter ?? Filter.all,
        //             onSelected: state.updateFilter,
        //           )),
        // ],
      ),
      body: Observer(
        builder: (context) => !state.isLoaded
            ? const LoadingIndicator()
            : state.activeTabIndex == Tabs.all.index
                ? StudentList(
                    students: state.allStudents,
                    activistChanged: (student) => state.updateStudent(
                      student.copyWith(activist: !student.activist),
                    ),
                  )
                : StudentList(
                    students: state.activeStudents,
                    activistChanged: (student) => state.updateStudent(
                      student.copyWith(activist: !student.activist),
                    ),
                  ),
      ),
      bottomNavigationBar: Observer(
          builder: (context) => BottomNavigationBar(
                currentIndex: state.activeTabIndex,
                onTap: state.updateTab,
                items: Tabs.values.map((tab) {
                  return BottomNavigationBarItem(
                    icon: Icon(
                      tab == Tabs.all ? Icons.group : Icons.list,
                    ),
                    label: tab == Tabs.all ? 'All' : 'Activists',
                  );
                }).toList(),
              )),
    );
  }
}
