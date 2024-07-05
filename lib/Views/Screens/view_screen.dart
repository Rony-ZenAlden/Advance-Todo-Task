import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/data_controller.dart';
import '../../const/color.dart';
import '../../const/custom_snackbar.dart';
import '../../const/validator.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({
    super.key,
    required this.id,
    required this.taskName,
    required this.taskDetail,
  });

  final int id;
  final String taskName;
  final String taskDetail;

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  _loadSingleTask(int id) async {
    await Get.find<DataController>().getTask(id.toString());
    print(_controller.singleData['task_name']);
    print(_controller.singleData['task_detail']);
  }

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDetailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final DataController _controller = Get.put(DataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSingleTask(widget.id);
    taskNameController.text = widget.taskName;
    taskDetailController.text = widget.taskDetail;
    // setState(() {});
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
                    readOnly: true,
                    controller: taskNameController,
                    validator: (value) =>
                        MyValidators.displayNameValidator(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.textHolder,
                      hintText: '${_controller.singleData['task_name']}',
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
                    readOnly: true,
                    maxLines: 5,
                    controller: taskDetailController,
                    validator: (value) =>
                        MyValidators.displayDescriptionValidator(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.textHolder,
                      hintText: '${_controller.singleData['task_detail']}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
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
