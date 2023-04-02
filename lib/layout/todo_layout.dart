import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

class TodoLayout extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
        ..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              centerTitle: true,
              backgroundColor: Colors.teal,
            ),
            body: state is! AppGetDatabaseLoadingState
                ? cubit.screens[cubit.currentIndex]
                : Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black, size: 100.0)),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                child: Icon(
                  cubit.fabIcon,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (cubit.isBottomSheet) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text);
                    }
                  } else {
                    scaffoldKey.currentState
                        ?.showBottomSheet(
                          (context) =>
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            color: Colors.grey[300],
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                TextFormField(
                                controller: titleController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "title must not be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                onChanged: (String value) {
                                  print(value);
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      gapPadding: 15.0,
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      gapPadding: 15.0,
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                prefixIcon: Icon(
                                  Icons.title,
                                  color: Colors.blueGrey,
                                ),
                                hintText: "Title",
                                hintStyle: TextStyle(
                                  fontSize: 17, color: Colors.black45,),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            TextFormField(

                              controller: timeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "time must not be empty";
                                } else {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (String value) {
                                print(value);
                              },
                              onChanged: (String value) {
                                print(value);
                              },
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                    .then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                  print(timeController);
                                });
                              },
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 15.0,
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 15.0,
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                ),
                                prefixIcon: Icon(
                                  Icons.access_time_filled_outlined,
                                  color: Colors.blueGrey,
                                ),
                                hintText: "Time",
                                hintStyle: TextStyle(
                                  fontSize: 17, color: Colors.black45,),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            TextFormField(
                              controller: dateController,
                              onFieldSubmitted: (String value) {
                                print(value);
                              },
                              onChanged: (String value) {
                                print(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Date must not be empty";
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 15.0,
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 15.0,
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                ),
                                prefixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.blueGrey,
                                ),
                                hintText: "Date",
                                hintStyle: TextStyle(
                                  fontSize: 17, color: Colors.black45,),
                              ),
                            ),
                            ],
                          ),
                    ),
                  ),
                  )
                      .closed
                      .then((value) {
                  cubit.changeBottomSheetState(
                  isShow: false, icon: Icons.edit);
                  });
                  }
                  cubit.changeBottomSheetState(isShow: true,
                  icon
                  :
                  Icons
                  .
                  add
                  );
                }),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.white,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                print(context);
                cubit.changeIndex(index);
              },
              backgroundColor: Colors.teal,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: "Done",
                    tooltip: "Hi"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archives"),
              ],
            ),
          );
        },
      ),
    );
  }
}
