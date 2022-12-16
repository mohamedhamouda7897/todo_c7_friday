import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/task.dart';
import '../../shared/network/local/firebase_utils.dart';

class TaskItem extends StatelessWidget {
  Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(),
          extentRatio: 1 / 2,

          children: [
            SlidableAction(
              onPressed: (context) {
                deleteTaskFromFirestore(task.id);
              },
              icon: Icons.delete,
              padding: EdgeInsets.zero,
              spacing: 0.0,
              autoClose: true,

              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(topRight: Radius.circular(12)
                  , bottomRight: Radius.circular(12)),
            ),
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.edit,
              backgroundColor: Colors.blue,
            )
          ]),
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 80,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(task.description)
                  ],
                )),
            SizedBox(
              width: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
