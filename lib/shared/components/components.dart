import 'package:flutter/material.dart';
import '/shared/cubit/cubit.dart';

Widget buildTaskForm(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(
        id: model['id'],
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${model['title']}",
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7.0),
                Row(
                  children: [
                    Text(
                      "${model['date']}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text("${model['time']}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20.0),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateData(status: 'done', id: model['id']!);
            },
            icon: const Icon(Icons.check_box, color: Colors.green),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateData(status: 'archived', id: model['id']!);
            },
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}



