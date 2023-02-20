import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/to_do_cubit.dart';
import '../shared/cubit/to_do_state.dart';
import '../shared/shared_components/component.dart';

class ArchivedTask extends StatelessWidget {
  const ArchivedTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit , ToDoStates>(
      listener: (context , state){},
      builder: (context , state){
        var tasks = ToDoCubit.get(context).archiveTasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
