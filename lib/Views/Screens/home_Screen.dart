import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_lang/Views/Screens/all_task_screen.dart';
import 'package:go_lang/Views/Screens/task_screen.dart';
import 'package:go_lang/const/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/welcome.jpg',
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                    ),
                    Text(
                      'Start Your Beautiful Day',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.to(() => const TaskScreen(),
                            transition: Transition.fade);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 105, vertical: 4),
                        child: Text(
                          'Add Task',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColor.mainColor,
                      ),
                      onPressed: () {
                        Get.to(() => const AllTaskScreen(),
                            transition: Transition.fade);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 110, vertical: 4),
                        child: Text(
                          'View All',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
