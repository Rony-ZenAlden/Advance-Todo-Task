import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_lang/Controllers/data_controller.dart';
import 'package:go_lang/Views/Screens/edit_screen.dart';
import 'package:go_lang/Views/Screens/home_Screen.dart';
import 'package:go_lang/Views/Screens/task_screen.dart';
import 'package:go_lang/Views/Screens/view_screen.dart';
import 'package:go_lang/const/color.dart';
import 'package:go_lang/const/storage/database_services.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  final DataController _controller = Get.put(DataController());
  final DatabaseService databaseService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    await _controller.getData();
    setState(() {});
  }

  final leftEdit = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: const Color(0xFF2e3253).withOpacity(0.5),
    alignment: Alignment.centerLeft,
    child: const Icon(
      Icons.edit,
      color: Colors.white,
    ),
  );

  final rightEdit = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: Colors.red,
    alignment: Alignment.centerRight,
    child: const Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/addtask.jpg',
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
          RefreshIndicator(
            onRefresh: () {
              print(databaseService.getTasks());
              return _loadData();
            },
            child: Column(
              children: [
                SizedBox(
                  height: height / 3.7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(
                              () => const HomeScreen(),
                              transition: Transition.fade,
                            );
                          },
                          icon: const Icon(
                            Icons.home,
                            size: 32,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(
                              () => const TaskScreen(),
                              transition: Transition.zoom,
                            );
                          },
                          icon: const Icon(
                            Icons.add_circle_rounded,
                            color: AppColor.mainColor,
                            size: 33,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.file_copy,
                            size: 25,
                            color: AppColor.secondaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${_controller.myData.length}',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _controller.myData.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: leftEdit,
                        secondaryBackground: rightEdit,
                        onDismissed: (DismissDirection direction) {
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            Get.to(
                              () => EditScreen(
                                id: int.parse(
                                  _controller.myData[index]["id"].toString(),
                                ),
                                taskName: '${_controller.myData[index]["task_name"]}',
                                taskDetail: '${_controller.myData[index]["task_detail"]}',
                              ),
                              transition: Transition.circularReveal,
                              duration: const Duration(milliseconds: 600),
                            );
                            return false;
                          } else {
                            if(direction == DismissDirection.endToStart) {
                              _controller.deleteTask(_controller.myData[index]["id"].toString());
                              return true;
                            }
                          }
                        },
                        key: ObjectKey(index),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => ViewScreen(
                                id: int.parse(
                                  _controller.myData[index]["id"].toString(),
                                ),
                                taskName:
                                    '${_controller.myData[index]["task_name"]}',
                                taskDetail:
                                    '${_controller.myData[index]["task_detail"]}',
                              ),
                            );
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width / 1.25,
                                height: height / 13.9,
                                color: AppColor.textHolder,
                                child: Center(
                                  child: Text(
                                    _controller.myData[index]["task_name"],
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
