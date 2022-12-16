import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c7_fri/modules/tasks_list/task_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_c7_fri/providers/my_provider.dart';
import '../modules/settings/settings.dart';
import '../modules/tasks_list/add_task_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'Home';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitle),
        actions: [
          IconButton(onPressed: () {
            if (provider.languageCode == 'ar') {
              provider.changeLanguage('en');
            } else {
              provider.changeLanguage('ar');
            }
          }, icon: Icon(Icons.public, color: Colors.white,))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary, width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 30,
                ),
                label: ''),
          ],
        ),
      ),
      body: tabs[currentIndex],
    );
  }

  List<Widget> tabs = [TaskListTab(), SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddTaskBottomSheet();
      },
    );
  }
}
