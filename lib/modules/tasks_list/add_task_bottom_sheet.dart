import 'package:flutter/material.dart';
import 'package:todo_c7_fri/models/task.dart';
import 'package:todo_c7_fri/shared/network/local/firebase_utils.dart';
import 'package:todo_c7_fri/shared/styles/colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: colorBlack),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (text) {
                      if (text != null && text.isEmpty) {
                        return 'Please enter task title';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('Title'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    validator: (text) {
                      if (text != null && text.isEmpty) {
                        return 'Please enter task description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('Description'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Select Date',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: colorBlack),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                SelectDate();
              },
              child: Text(
                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: colorBlack, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Task task = Task(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate.microsecondsSinceEpoch);
                    addTaskToFireStore(task);
                  }
                },
                child: Text('Add Task'))
          ],
        ),
      ),
    );
  }

  void SelectDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    print(chosenDate);
    if (chosenDate == null) return;
    selectedDate = chosenDate;
    setState(() {});
  }
}
