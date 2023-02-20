import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/shared/cubit/to_do_state.dart';
import '../../modules/archived_task.dart';
import '../../modules/done_task.dart';
import '../../modules/new_task.dart';

class ToDoCubit extends Cubit<ToDoStates>{
  ToDoCubit():super(InitialState());

  static ToDoCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTask(),
    const DoneTask(),
    const ArchivedTask(),
  ];
  List<String> titles = [
    'New Task',
    'Done Task',
    'Archived Task',
  ];
  bool showBottom = false;
  IconData icon = Icons.edit;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void changeBottomNavigation(int index){
    currentIndex = index;
    emit(ChangeBottomNavigationBar());
  }

  void changeShowBottomSheet({
  required bool showBottomSheet,
  required IconData iconData,
}){
 showBottom = showBottomSheet;
 icon = iconData;
 emit(ChangeShowBottomSheet());
  }

  Future<void> createDatabase() async {
    database = await openDatabase('todo.dp', version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT , status TEXT)');
        emit(AppCreateDatabaseState());
          },
        onOpen: (database){
          getDatabase(database);
          print('database opened');
        }
    );
  }

   insertDatabase({
    required String title,
    required String time ,
    required String date,
  }) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Task(title, time, date, status) VALUES("$title", "$time", "$date","new")').then((value) {
        print('${value}inserted SUCCESSFULLY');
        emit(AppInsertDatabaseState());
        getDatabase(database);
      });
      });
  }

  void getDatabase(database){
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
     database.rawQuery('SELECT * FROM Task').then((value) {
       value.forEach((element) {
         if(element['status'] == 'new'){
           newTasks.add(element);
         }
         else if(element['status'] == 'done'){
           doneTasks.add(element);
         }
         if(element['status'] == 'archive'){
           archiveTasks.add(element);
         }
        // print(element);
       });
       emit(AppGetDatabaseState());
     });;
  }

  void updateDatabase({
  required int id ,
  required String status,
})async{
     database.rawUpdate(
        'UPDATE Task SET status = ? WHERE id = ?',
        [status, id]).then((value) {
          emit(AppUpdateDatabaseState());
    });
     getDatabase(database);
  }

  void deleteDatabase({
  required int id,
}) async {
      database
        .rawDelete('DELETE FROM Task WHERE id = ?', [id]).then((value) {
          getDatabase(database);
          emit(AppDeleteDatabaseState());
      });
  }
}