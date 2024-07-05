import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/data_controller.dart';
import '../../const/color.dart';
import '../../const/custom_snackbar.dart';
import '../../const/validator.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    required this.id,
    required this.taskName,
    required this.taskDetail,
  });

  final int id;
  final String taskName;
  final String taskDetail;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDetailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DataController controller = Get.put(DataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskNameController.text = widget.taskName;
    taskDetailController.text = widget.taskDetail;
  }

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
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColor.mainColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Get.find<DataController>().editData(
                          taskNameController.text,
                          taskDetailController.text,
                          widget.id.toString(),
                        );
                        CustomSnackBar.showSuccessSnackBar(
                            title: 'Success', message: 'Te Edit Has Completed.');
                      } else {
                        CustomSnackBar.showErrorSnackBar(
                            title: 'Error', message: 'Please Try Input Again.');
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 149, vertical: 4),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
