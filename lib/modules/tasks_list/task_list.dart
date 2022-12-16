import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_c7_fri/models/task.dart';
import 'package:todo_c7_fri/modules/tasks_list/task_item.dart';
import 'package:todo_c7_fri/shared/network/local/firebase_utils.dart';
import 'package:todo_c7_fri/shared/styles/colors.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(date);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: date,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (dateTime) {
              print('$date');
              date = dateTime;
              setState(() {

              });
            },
            leftMargin: 20,
            monthColor: colorBlack,
            dayColor: colorBlack,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Theme.of(context).primaryColor,
            dotsColor: Colors.white,
            selectableDayPredicate: (date) => true,
            locale: 'en',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
                stream: getTasksFromFirestore(date),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  var tasks = snapshot.data!.docs.map((e) => e.data()).toList();
                  print('hint ${tasks.length}');
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskItem(tasks[index]);
                    },
                    itemCount: tasks.length,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
