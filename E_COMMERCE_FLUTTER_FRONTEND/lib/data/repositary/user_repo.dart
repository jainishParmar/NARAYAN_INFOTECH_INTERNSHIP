import 'package:get/get.dart';
import 'package:intern_final/data/api/api_client.dart';
import 'package:intern_final/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    Response response =  await apiClient.getData(Appconstants.USER_INFO_URI,);

    return response;
  }
}
