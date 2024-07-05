import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_lang/Controllers/service_controller.dart';

import '../const/custom_snackbar.dart';

class DataController extends GetxController {
  ServiceController serviceController = ServiceController();
  RxBool isLoading = false.obs;
  List<dynamic> _myData = [];
  String? res;

  List<dynamic> get myData => _myData;
  Map<String, dynamic> _singleData = {};

  Map<String, dynamic> get singleData => _singleData;

  // RxList<dynamic> _myData1 = RxList<dynamic>([]);
  // List<dynamic> get myData1 => _myData;

  Future<void> getData() async {
    isLoading.value = true;
    Response response = await serviceController.getData();
    if (response.statusCode == 200) {
      _myData = response.body;
      update();
    } else {
      CustomSnackBar.showErrorSnackBar(title: 'Error', message: 'No Data');
    }
    isLoading.value = false;
  }

  Future<void> deleteTask(String id) async {
    isLoading.value = true;
    Response response = await serviceController.deleteTask(id);
    if (response.statusCode == 200) {
      print("we got the single data : ${jsonEncode(response.body)}");
      res = jsonEncode(response.body); // encode the response body as a string
      update();
    } else {
      CustomSnackBar.showErrorSnackBar(title: 'Error', message: 'No Data');
    }
    isLoading.value = false;
  }

  Future<void> getTask(String id) async {
    isLoading.value = true;
    Response response = await serviceController.getTask(id);
    if (response.statusCode == 200) {
      print("we got the single data : ${jsonEncode(response.body)}");
      _singleData = jsonDecode(response.body);
      update();
    } else {
      CustomSnackBar.showErrorSnackBar(title: 'Error', message: 'No Data');
    }
    isLoading.value = false;
  }

  Future<void> postData(String task, String taskDetail) async {
    isLoading.value = true;
    Response response = await serviceController.postData({
      "task_name": task,
      "task_detail": taskDetail,
    });
    if (response.statusCode == 200) {
      update();
    } else {
      print('No Data');
    }
    isLoading.value = false;
  }

  Future<void> editData(String task, String taskDetail, String id) async {
    isLoading.value = true;
    Response response = await serviceController.editData({
      "task_name": task,
      "task_detail": taskDetail,
    }, id);
    if (response.statusCode == 200) {
      update();
    } else {
      print('No Data');
    }
    isLoading.value = false;
  }

// Future<void> getData1() async {
//   _isLoading.value = true;
//   final response = await serviceController.getTask();
//   if (response.statusCode == 200) {
//     final jsonData = jsonDecode(response.body);
//     if (jsonData is List) {
//       _myData1.value = jsonData;
//       print('we got the data : ${_myData1.value}');
//       update();
//     } else {
//       print('Invalid JSON response');
//     }
//   } else {
//     print('No Data');
//   }
//   _isLoading.value = false; // don't forget to set _isLoading to false
// }
}
