import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  late String token;
  late SharedPreferences sp;
  AuthInterceptor() {
    token = "";
    (() async {
      sp = await SharedPreferences.getInstance();
      token = sp.getString(Keys.token) ?? "";
    })();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
  }
}
