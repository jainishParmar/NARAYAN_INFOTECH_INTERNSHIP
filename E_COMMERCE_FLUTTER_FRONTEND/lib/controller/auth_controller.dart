import 'package:get/get.dart';
import 'package:intern_final/data/repositary/auth_repo.dart';
import 'package:intern_final/models/response_model.dart';
import 'package:intern_final/models/sign_up_body.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registration(signUpBody);

    late ResponseModel responseModel;
    if (response.statusCode == 201) {
      responseModel = ResponseModel(true, response.statusText!);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();

    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["access_token"]);

      responseModel = ResponseModel(true, response.body["access_token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) async {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userHasLoggedIn() {

    return authRepo.userHasLoggedIn();
  }

  bool _logout = false;
  bool get logout => _logout;
  Future<bool> clearSharedData() async {
    update();
    Response response = await authRepo.clearSharedData();
    if (response.statusCode == 200) {
      _logout = true;
      update();
      return true;
    } else {
      _logout = false;
      update();
      return false;
    }
  }

  Future<ResponseModel> forget(String email) async {
    _isLoading = true;
    update();
    Response response = await authRepo.forget(email);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message']!);
    } else {
      responseModel = ResponseModel(false, response.body['message']!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> resetPassword(String email,String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.resetPassword(email,password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message']!);
    } else {
      responseModel = ResponseModel(false, response.body['message']!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> compare(String otp,String email) async {
    _isLoading = true;
    update();
    Response response = await authRepo.compare(otp,email);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message']!);
    } else {
      responseModel = ResponseModel(false, response.body['message']!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

}
