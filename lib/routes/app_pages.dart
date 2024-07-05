import 'package:get/get.dart';
import 'package:go_lang/Views/Screens/all_task_screen.dart';
import 'package:go_lang/Views/Screens/home_Screen.dart';
import 'package:go_lang/Views/Screens/task_screen.dart';
import 'package:go_lang/routes/app_route.dart';

class AppPages {
  static final List<GetPage> pages = [

    // Home
    GetPage(
      name: AppRoute.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),

    // Add
    GetPage(
      name: AppRoute.addTask,
      page: () => const TaskScreen(),
      transition: Transition.fadeIn,
    ),

    // All
    GetPage(
      name: AppRoute.viewAll,
      page: () => const AllTaskScreen(),
      transition: Transition.fadeIn,
    ),

    // View
    GetPage(
      name: AppRoute.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),

    // Edit
    GetPage(
      name: AppRoute.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
