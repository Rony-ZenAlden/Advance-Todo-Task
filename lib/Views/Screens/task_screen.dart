import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_lang/Controllers/data_controller.dart';
import 'package:go_lang/const/color.dart';
import 'package:go_lang/const/storage/database_services.dart';
import 'package:go_lang/const/validator.dart';

import '../../const/custom_snackbar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDetailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DataController controller = Get.put(DataController());
  final TextEditingController text = TextEditingController();
  final DatabaseService databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Image.asset(
              'assets/addtask2.jpg',
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 68,
                  ),
                  TextFormField(
                    controller: taskNameController,
                    validator: (value) =>
                        MyValidators.displayNameValidator(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.textHolder,
                      hintText: 'Task Name...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: taskDetailController,
                    validator: (value) =>
                        MyValidators.displayDescriptionValidator(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.textHolder,
                      hintText: 'Task Detail...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Get.find<DataController>().postData(
                            taskNameController.text,
                            taskDetailController.text,
                          );
                          databaseService.addTask(
                            taskNameController.text,
                            taskDetailController.text,
                            DateTime.now().toString(),
                          );
                          taskNameController.clear();
                          taskDetailController.clear();
                          CustomSnackBar.showSuccessSnackBar(
                              title: 'Success',
                              message: 'The Task Has Created.');
                        } else {
                          CustomSnackBar.showErrorSnackBar(
                              title: 'Error',
                              message: 'Please Try Input Again.');
                        }
                      },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 149, vertical: 4),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
