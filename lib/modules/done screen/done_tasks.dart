import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/components/components.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var done = AppCubit.get(context).doneTasks;
          return done.isEmpty ?   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const[
                Icon(
                  Icons.do_not_disturb_outlined,
                  size: 50.0,
                  color: Colors.grey,
                ),
                const SizedBox(height: 5.0,),
                Text("No Done Tasks",
                    style:TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey
                    )),
              ],
            ),
          ) : ListView.separated(
            itemBuilder: (context, index) => buildTaskForm(done[index],context),
            separatorBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1.0,
                  ),
                ),
            itemCount: done.length,
          );
        }
    );
  }
}