import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/ui/home/widgets/home_floating_button.dart';
import 'package:todo_plugin/ui/priority_tasks/priority_tasks_page.dart';
import 'package:todo_plugin/ui/task_list/task_list_page.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<TaskListPageState> pageTaskListKey = GlobalKey<TaskListPageState>();
  final GlobalKey<PriorityTasksPageState> pagePriorityTasksKey = GlobalKey<PriorityTasksPageState>();

  int _currentIndex = 0;

  void _onTabChanged(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      PriorityTasksPage(key: pagePriorityTasksKey),
      TaskListPage(key: pageTaskListKey),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: WidgetUtils.svgPicture(
              AppAssets.iconTabHome,
              color: _currentIndex == 0 ? AppColors.brandColor : const Color(0xFFABCEF5),
            ),
          ),
          BottomNavigationBarItem(
            label: 'TaskList',
            icon: WidgetUtils.svgPicture(
              AppAssets.iconTabCalendar,
              color: _currentIndex == 1 ? AppColors.brandColor : const Color(0xFFABCEF5),
            ),
          ),
        ],
        onTap: _onTabChanged,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 1,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.transparent,
        unselectedItemColor: Colors.transparent,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: HomeFloatingButton(
          onPressed: () async {
            final result = await context.push('/addTask');
            if (result is bool && result) {
              pageTaskListKey.currentState?.refresh();
              pagePriorityTasksKey.currentState?.refresh();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
