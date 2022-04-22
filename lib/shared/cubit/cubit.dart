import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/todo_app/archive_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late Database database;
  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  List<Widget> screen = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];
  List title = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase('Todo.db', version: 1, onCreate: (database, version) {
      print('create database');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print("table created");
      }).catchError((error) {
        print('cant create tables ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('open database');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
   }) async{
      database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getDataFromDatabase(database);
          emit(AppUpdateDatabaseState());
      });

  }
  void deleteData({
    required int id,
  }) async{
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
            print('$value INSERTED successfully');
            emit(AppInsertDatabaseState());
            getDataFromDatabase(database);
          })
          .catchError((error) {
        print('cant insert new record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(AppGetDatabaseLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value) {
       value.forEach((element) {
         if(element['status']=='new')
           newTasks.add(element);
         else if(element['status']=='done')
           doneTasks.add(element);
         else
           archiveTasks.add(element);
       });
       emit(AppGetDatabaseState());
     });
  }
  void changeBottomSheetState({
      required bool isShow,
      required IconData icon,

    }){
        isBottomSheetShown=isShow;
        fabIcon=icon;
        emit(AppChangeBottomSheetState());
      }
  bool isDark=false;
  void changeAppMode({bool? fromShared}){
    if(fromShared!=null){
      emit(AppChangeModeState());
      isDark=fromShared;
    }
    else{isDark=!isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });}

  }
}
