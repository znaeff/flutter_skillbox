// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StateObservable on _StateObservable, Store {
  Computed<bool>? _$isLoadedComputed;

  @override
  bool get isLoaded =>
      (_$isLoadedComputed ??= Computed<bool>(() => super.isLoaded,
              name: '_StateObservable.isLoaded'))
          .value;
  Computed<List<Student>>? _$allStudentsComputed;

  @override
  List<Student> get allStudents => (_$allStudentsComputed ??=
          Computed<List<Student>>(() => super.allStudents,
              name: '_StateObservable.allStudents'))
      .value;
  Computed<List<Student>>? _$activeStudentsComputed;

  @override
  List<Student> get activeStudents => (_$activeStudentsComputed ??=
          Computed<List<Student>>(() => super.activeStudents,
              name: '_StateObservable.activeStudents'))
      .value;

  final _$studentsAtom = Atom(name: '_StateObservable.students');

  @override
  List<Student> get students {
    _$studentsAtom.reportRead();
    return super.students;
  }

  @override
  set students(List<Student> value) {
    _$studentsAtom.reportWrite(value, super.students, () {
      super.students = value;
    });
  }

  final _$activeTabIndexAtom = Atom(name: '_StateObservable.activeTabIndex');

  @override
  int get activeTabIndex {
    _$activeTabIndexAtom.reportRead();
    return super.activeTabIndex;
  }

  @override
  set activeTabIndex(int value) {
    _$activeTabIndexAtom.reportWrite(value, super.activeTabIndex, () {
      super.activeTabIndex = value;
    });
  }

  final _$_initStudentsAsyncAction =
      AsyncAction('_StateObservable._initStudents');

  @override
  Future<void> _initStudents() {
    return _$_initStudentsAsyncAction.run(() => super._initStudents());
  }

  final _$reloadStudentsAsyncAction =
      AsyncAction('_StateObservable.reloadStudents');

  @override
  Future<void> reloadStudents() {
    return _$reloadStudentsAsyncAction.run(() => super.reloadStudents());
  }

  final _$_StateObservableActionController =
      ActionController(name: '_StateObservable');

  @override
  void updateStudent(Student student) {
    final _$actionInfo = _$_StateObservableActionController.startAction(
        name: '_StateObservable.updateStudent');
    try {
      return super.updateStudent(student);
    } finally {
      _$_StateObservableActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTab(int index) {
    final _$actionInfo = _$_StateObservableActionController.startAction(
        name: '_StateObservable.updateTab');
    try {
      return super.updateTab(index);
    } finally {
      _$_StateObservableActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
students: ${students},
activeTabIndex: ${activeTabIndex},
isLoaded: ${isLoaded},
allStudents: ${allStudents},
activeStudents: ${activeStudents}
    ''';
  }
}
