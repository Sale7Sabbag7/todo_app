import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/components/components.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';
class NewTasks extends StatelessWidget {
  const NewTasks({key});
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newTasks;
          return tasks.isEmpty ?   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const[
                Icon(
                  Icons.menu,
                  size: 50.0,
                  color: Colors.grey,
                ),
                Text("No Tasks, Yet Please Add Some Tasks",
                    style:TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey
                    )),
              ],
            ),
          ) : ListView.separated(
            itemBuilder: (context, index) => buildTaskForm(tasks[index],context),
            separatorBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1.0,
                  ),
                ),
            itemCount: tasks.length,
          );
        }
    );
  }
}