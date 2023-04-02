import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/components/components.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks ({key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var archived = AppCubit.get(context).archivedTasks;
          return archived.isEmpty ?   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const[
                Icon(
                  Icons.arrow_circle_down,
                  size: 50.0,
                  color: Colors.grey,
                ),
                const SizedBox(height: 5.0,),
                Text("No Archived Tasks",
                    style:TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey
                    )),
              ],
            ),
          ) : ListView.separated(
            itemBuilder: (context, index) => buildTaskForm(archived[index],context),
            separatorBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1.0,
                  ),
                ),
            itemCount: archived.length,
          );
        }
    );
  }
}