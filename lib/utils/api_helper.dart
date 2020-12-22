import 'package:dio/dio.dart';
import '../utils/auth.dart';

class CHttp {
  const CHttp({this.baseURL, this.auth});
  
  final String baseURL;
  final Auth auth;

  Future<Dio> getClient() async {
    Dio _dio = Dio();
    _dio.options.baseUrl = baseURL;

    if (auth == null) {
      return _dio;
    } 

    final bool  isLogin = await auth.isLoggedIn();
    await auth.isLoggedIn();

    if (!isLogin) {
      return _dio;
    }  
    
    User _user = await auth.refreshToken();

    if (_user == null) {
      return _dio;
    }

    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        options.headers["Authorization"] = "Bearer ${_user.token}";
        return options;
      },
      onResponse: (Response _res) {
        return _res;
      },
      onError: (DioError err) async {
        if (err.response?.statusCode == 401) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = err.response.request;
          _user =  await auth.refreshToken();          
          options.headers["Authorization"] = "Bearer ${_user.token}";
          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return err;
        }
      }
    ));
    return _dio;    
  }
}