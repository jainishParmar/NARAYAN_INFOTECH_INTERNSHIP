import 'package:get/get.dart';
import 'package:intern_final/data/api/api_client.dart';
import 'package:intern_final/models/sign_up_body.dart';
import 'package:intern_final/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> registration(SignUpBody signUpBody) async {
     Response response =  await apiClient.postData(
        Appconstants.REGISTRATION_URI, signUpBody.toJson());
     return response;
  }

  bool userHasLoggedIn() {
    return sharedPreferences.containsKey(Appconstants.TOKEN);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(Appconstants.TOKEN) ?? "None";
  }

  Future<Response> login(String email, String password) async {
    Response response =  await apiClient.postData(
        Appconstants.LOGIN_URI, {"email": email, "password": password});
    return response;
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);

    return await sharedPreferences.setString(Appconstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(Appconstants.EMAIL, number);
      await sharedPreferences.setString(Appconstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  Future<Response> clearSharedData() async{
    Response response = await apiClient.postData(Appconstants.LOGOUT,null);
    sharedPreferences.remove(Appconstants.TOKEN);

    sharedPreferences.remove(Appconstants.PASSWORD);
    sharedPreferences.remove(Appconstants.EMAIL);
    apiClient.token='';
    apiClient.updateHeader('');

    return response;
  }

  Future<Response> forget(String email) async {
    Response response = await apiClient.getData(Appconstants.FORGETPASSWORD+"/${email}");
    return response;

  }

  Future<Response> resetPassword(String email,String password) async {
    Response response = await apiClient.postData(Appconstants.RESETPASSWORD,{'email':email,'password':password});
    return response;

  }

  Future<Response> compare(String otp,String email) async{
    Response response = await apiClient.getData(Appconstants.COMPAREOTP+"/${email}/${otp}");
    return response;

  }
}
