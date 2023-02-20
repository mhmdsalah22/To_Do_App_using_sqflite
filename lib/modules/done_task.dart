import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/to_do_cubit.dart';
import '../shared/cubit/to_do_state.dart';
import '../shared/shared_components/component.dart';

class DoneTask extends StatelessWidget {
  const DoneTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit , ToDoStates>(
      listener: (context , state){},
      builder: (context , state){
        var tasks = ToDoCubit.get(context).doneTasks;
        return  taskBuilder(tasks: tasks);
      },
    );
  }
}
