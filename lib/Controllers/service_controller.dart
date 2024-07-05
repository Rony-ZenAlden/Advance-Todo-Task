import 'package:get/get.dart';
import 'package:go_lang/const/app_url.dart';
import 'package:go_lang/const/custom_snackbar.dart';
import 'package:http/http.dart' as http;

class ServiceController extends GetConnect implements GetxService {
  Future<Response> getData() async {
    const url = '${AppUrl.BaseUrl}gettasks';
    Response response = await get(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }

  Future<Response> postData(dynamic body) async {
    const url = '${AppUrl.BaseUrl}create';
    Response response = await post(url, body,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }

  Future<Response> editData(dynamic body, String id) async {
    final url = '${AppUrl.BaseUrl}update/$id';
    Response response = await put(url, body,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }

  Future<Response> deleteTask(String id) async {
    final url = '${AppUrl.BaseUrl}delete/$id';
    Response response = await delete(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }

  Future<Response> getTask(String id) async {
    final url = '${AppUrl.BaseUrl}gettask/$id';
    Response response = await get(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }

  // Future getTask() async {
  //   const url = 'http://10.0.2.2:8082/gettasks';
  //   final response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   });
  //
  //   return response;
  // }

// Future sdsads() async {
//   final url = Uri.parse('http://10.0.2.2:8082/gettasks');
//   final response = await http
//       .get(url, headers: {'Content-Type': 'application/json; charset=UTF-8'});
//   if(response.statusCode == 200) {
//     CustomSnackBar.showSuccessSnackBar(title: 'Success', message: 'We Have Data');
//     return response;
//   } else {
//     CustomSnackBar.showErrorSnackBar(title: 'Error', message: 'No Data');
//   }
// }
}
