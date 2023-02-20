import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/cubit/to_do_cubit.dart';
import 'package:to_do_app/shared/cubit/to_do_state.dart';
import 'package:to_do_app/shared/shared_components/component.dart';

class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = ToDoCubit
            .get(context)
            .newTasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
