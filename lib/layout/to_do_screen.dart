import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/shared/cubit/to_do_cubit.dart';
import 'package:to_do_app/shared/cubit/to_do_state.dart';

class ToDOScreen extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var title =TextEditingController();
  var time =TextEditingController();
  var date =TextEditingController();
  var formKey = GlobalKey<FormState>();

  ToDOScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit , ToDoStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = ToDoCubit.get(context);
        return  Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(cubit.showBottom){
                if(formKey.currentState!.validate()){
                  cubit.insertDatabase(title: title.text, time: time.text, date: date.text);
                  Navigator.pop(context);
                  cubit.changeShowBottomSheet(
                      showBottomSheet: false,
                      iconData: Icons.edit,
                  );
                }
              }
              else{
                //print('open');
                scaffoldKey.currentState?.
                showBottomSheet((context)=>
                    Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: title,
                              keyboardType: TextInputType.name,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please enter title';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Title Task',
                                prefixIcon: Icon(Icons.title),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: time,
                              keyboardType: TextInputType.datetime,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please enter time';
                                }
                                return null;
                              },
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) => {
                                  time.text = value!.format(context).toString(),
                                });

                              },
                              decoration: const InputDecoration(
                                labelText: 'Time Task',
                                prefixIcon: Icon(Icons.watch_later_sharp),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),TextFormField(
                              controller: date ,
                              keyboardType: TextInputType.datetime,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please enter date';
                                }
                                return null;
                              },
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now() ,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2024-12-12'),
                                ).then((value) => {
                                  date.text =
                                      DateFormat.yMMMd().format(value!),
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Date Task',
                                prefixIcon: Icon(Icons.calendar_month_sharp),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  elevation: 20.0,
                ).closed.then((value){
                 cubit.changeShowBottomSheet(
                     showBottomSheet: false,
                     iconData: Icons.edit
                 );
                });
                   cubit.changeShowBottomSheet(
                       showBottomSheet: true,
                       iconData: Icons.add);
              }
            },
            child: Icon(cubit.icon),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.task), label: 'NEW TASK'),
              BottomNavigationBarItem(icon: Icon(Icons.done), label: 'DONE TASK'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'ARCHIVED TASK'),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavigation(index);
            },
          ),
        );
      },
    );
  }
}



