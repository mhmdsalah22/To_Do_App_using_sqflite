import 'package:flutter/material.dart';
import 'package:to_do_app/shared/cubit/to_do_cubit.dart';

Widget buildItem(Map task, context) {
  return Dismissible(
    key: Key(task['id'].toString()),
    onDismissed: (direction) {
      ToDoCubit.get(context).deleteDatabase(id: task['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${task['time']}',
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${task['title']}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${task['date']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ToDoCubit.get(context)
                  .updateDatabase(id: task['id'], status: 'done');
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              ToDoCubit.get(context)
                  .updateDatabase(id: task['id'], status: 'archive');
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget taskBuilder({
  required List<Map> tasks
}) => tasks.isEmpty
    ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      )
    : ListView.separated(
        itemBuilder: (context, index) => buildItem(tasks[index], context),
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[200],
        ),
        itemCount: tasks.length,
      );
