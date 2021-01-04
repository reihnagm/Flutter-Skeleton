import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../constants/constant.dart';

abstract class BaseAuth {
  Future<User> loginWithSocialMedia(String code, String provider);
  Future<bool> signInWithPhone(String phoneNumber);
  Future<User> register(String _username, String _noKTP, String _fullName, String _password, String _avatarUrl, String suspect);
  Future<User> login(String username, String password);
  Future<User> loadUser();
  Future<bool> isLoggedIn();
  Future<User> verifyOtp(String phoneNumber, String _pinOTP);
  void refreshToken();
  void logout();
  User currentUser;
}

class Auth implements BaseAuth {
  User currentUser;
  final Dio _dio = Dio();
  bool _isVisited;

  Future<bool> isOnboardVisited() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isVisited = prefs.getBool("visited");
    if (_isVisited == null) {
      _isVisited = false;
    }
    prefs.setBool("visited", true);
    return _isVisited;
  }

  @override
  Future<bool> isLoggedIn() async {
    bool isLoaded = false;
    User _user = await loadUser();
    isLoaded = _user == null ? false : true;
    return isLoaded;
  }

  @override
  Future<User> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("uid") == null) {
      currentUser = null;
    } else {
      User _user = User(
        refreshToken: prefs.getString("refreshToken"),
        token: prefs.getString("token"),
        user: UserClass(
          uid: prefs.getString("uid"),
          authKey: prefs.getString("authKey"),
          nra: prefs.getString("nra"),
          ynci: prefs.getString("ynci"),
          alamat: prefs.getString("alamat"),
          noKtp: prefs.getString("no_ktp"),
          noSim: prefs.getString("no_sim"),
          closestName: prefs.getString("closest_name"),
          closestNo: prefs.getString("closest_no"),
          golDarah: prefs.getString("gol_darah"),
          avatarUrl: prefs.getString("avatarUrl"),
          email: prefs.getString("email"),
          fullName: prefs.getString("fullName"),
          shortBio: prefs.getString("shortBio"),
          username: prefs.getString("username"),
          createdAt: DateTime.parse(prefs.getString("createdAt")),
          updatedAt: DateTime.parse(prefs.getString("updatedAt")),
        ),
        status: prefs.getString("status")
      );
      currentUser = _user;
    }
    return currentUser;
  }

  Future<User> updateUser(String fullName, String noTlp, String email, String noKtp, String noSim, String alamat, [String avatarUrl = "", String shortBio = ""]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _uid = prefs.getString("uid");
    if (_uid == null) {
      currentUser = null;
      return currentUser;
    } else {
      final String _updateUrl = "$baseUrl/user-service/updateprofile";
      Dio _dio = Dio();
      Map<String, dynamic> _data = {
        "full_name": fullName,
        "username": noTlp,
        "email": email,
        "no_ktp": noKtp,
        "no_sim": noSim,
        "alamat": alamat,
      };
      if (avatarUrl.trim().length > 0) {
        _data.addAll({"avatar_url": avatarUrl});
      }
      if (shortBio.trim().length > 0) {
        _data.addAll({"short_bio": shortBio});
      }
      try {
        final Response _res = await _dio.post(_updateUrl,
          options: RequestOptions(
            headers: {"Authorization": "Bearer ${currentUser.token}"}
          ),
          data: _data
        );
        if (_res.statusCode != 200) {
          throw ("update error");
        }
        UserClass _user = UserClass.fromJson(_res.data["data"]);
        currentUser = User(
          refreshToken: currentUser.refreshToken,
          status: currentUser.status,
          token: currentUser.token,
          user: _user
        );
        _writeData();
        return currentUser;
      } catch (err) {
        print(err);
        return null;
      }
    }
  }

  Future<User> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _uid = prefs.getString("uid");
    if (_uid == null) {
      currentUser = null;
      return currentUser;
    } else {
      final String _updateUrl = "$baseUrl/user-service/changepwd";
      Dio _dio = Dio();
      Map<String, dynamic> _data = {
        "old_password": oldPassword,
        "password1": newPassword,
        "password2": confirmPassword
      };
      try {
        final Response _res = await _dio.post(_updateUrl,
          options: RequestOptions(
            headers: {
              "Authorization": "Bearer ${currentUser.token}"
            }
          ),
          data: _data
        );
        if (_res.statusCode != 200) {
          throw ("update error");
        }
        UserClass _user = UserClass.fromJson(_res.data["data"]);
        currentUser = User(
          refreshToken: currentUser.refreshToken,
          status: currentUser.status,
          token: currentUser.token,
          user: _user
        );
        _writeData();
        return currentUser;
      } catch (err) {
        print(err);
        return null;
      }
    }
  }

  void _writeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("visited", true);
    prefs.setString("refreshToken", currentUser.refreshToken);
    prefs.setString("token", currentUser.token);
    prefs.setString("uid", currentUser.user.uid);
    prefs.setString("authKey", currentUser.user.authKey);
    prefs.setString("nra", currentUser.user.nra);
    prefs.setString("ynci", currentUser.user.ynci);
    prefs.setString("alamat", currentUser.user.alamat);
    prefs.setString("no_ktp", currentUser.user.noKtp);
    prefs.setString("no_sim", currentUser.user.noSim);
    prefs.setString("closest_name", currentUser.user.closestName);
    prefs.setString("closest_no", currentUser.user.closestNo);
    prefs.setString("gol_darah", currentUser.user.golDarah);
    prefs.setString("avatarUrl", currentUser.user.avatarUrl);
    prefs.setString("email", currentUser.user.email);
    prefs.setString("fullName", currentUser.user.fullName);
    prefs.setString("shortBio", currentUser.user.shortBio);
    prefs.setString("username", currentUser.user.username);
    prefs.setString("createdAt", currentUser.user.createdAt.toString());
    prefs.setString("updatedAt", currentUser.user.updatedAt.toString());
    prefs.setString("status", currentUser.status);
  }

  void _deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("visited", false);
    prefs.remove("refreshToken");
    prefs.remove("token");
    prefs.remove("uid");
    prefs.remove("authKey");
    prefs.remove("avatarUrl");
    prefs.remove("email");
    prefs.remove("fullName");
    prefs.remove("shortBio");
    prefs.remove("username");
    prefs.remove("createdAt");
    prefs.remove("updatedAt");
    prefs.remove("status");
    prefs.remove("status");
    currentUser = null;
  }

  @override
  Future<User> loginWithSocialMedia(String code, String provider) async {
    final String loginUrl = "$baseUrl/user-service/socmed/$provider";
    try {
      final Response _response = await _dio.post(loginUrl,
        options: Options(
          contentType: "application/json"
        ),
        data: {
          "accessToken": code
        }
      );
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        User _user = User.fromJson(_response.data);
        _writeData();
        currentUser = _user;
        return _user;
      } else {
        throw new Exception(_response.statusMessage);
      }
    } on DioError catch (err) {
      print(err);
      currentUser = null;
      return null;
    }
  }

  @override
  void logout() {
    _deleteData();
  }

  @override
  Future<User> login(String _username, String _password) async {
    final String loginUrl = "$baseUrl/user-service/login";
    try {
      Response _res = await _dio.post(loginUrl,
        options: Options(
          contentType: "application/json"
        ),
        data: {
          "username": _username, 
          "password": _password
        }
      );
      if (_res.statusCode != 200 && _res.statusCode != 201) {
        throw ("Error: ${_res.statusCode}, message ${_res.statusMessage}");
      }
      User _user = User.fromJson(_res.data);
      currentUser = _user;
      _writeData();
    } catch (err) {
      print(err);
      currentUser = null;
      this._deleteData();
    }
    return currentUser;
  }

  @override
  Future<User> register(String _username, String _noKTP, String _fullName, String _password, String _avatarUrl, String suspect) async {
    final String registerUrl = "$baseUrl/user-service/register";
    try {
      Response _res = await _dio.post(registerUrl,
        options: Options(
          contentType: "application/json"
        ),
        data: {
          "username": _username,
          "no_ktp": _noKTP,
          "full_name": _fullName,
          "suspect_status": suspect,
          "password": _password,
          "avatar_url": _avatarUrl
        }
      );
      if (_res.statusCode != 200 && _res.statusCode != 201) {
        throw ("Error: ${_res.statusCode}, message ${_res.statusMessage}");
      }
      User _user = User.fromJson(_res.data);
      currentUser = _user;
      _writeData();
    } catch (err) {
      currentUser = null;
      this._deleteData();
    }
    return currentUser;
  }

  @override
  Future<User> refreshToken() async {
    if (currentUser != null) {
      final String refreshUrl = "$baseUrl/user-service/refresh";
      try {
        Response _res = await _dio.post(refreshUrl,
          options: Options(
            headers: {
              "Authorization": "Bearer ${currentUser.refreshToken}",
              "Content-Type": "application/json"
            }
          )
        );
        if (_res.statusCode != 200 && _res.statusCode != 201) {
          throw ("Error: ${_res.statusCode}, message ${_res.statusMessage}");
        }
        User _user = User.fromJson(_res.data);
        currentUser = _user;
        _writeData();
      } catch (err) {
        currentUser = null;
        this._deleteData();
      }
    }
    return currentUser;
  }

  @override
  Future<bool> signInWithPhone(String phoneNumber) async {
    final String loginUrl = "$baseUrl/user-service/requestotp";
    try {
      final Response _response = await _dio.post(loginUrl,
        options: Options(
          contentType: "application/json"
        ),
        data: {
          "phone": phoneNumber
        }
      );
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        return true;
      } else {
        throw new Exception(_response.statusMessage);
      }
    } on DioError catch (err) {
      print(err);
      currentUser = null;
      return null;
    }
  }

  Future<User> verifyOtp(String phoneNumber, String _pinOTP) async {
    final String loginUrl = "$baseUrl/user-service/verifyotp";
    try {
      final Response _response = await _dio.post(loginUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json"
          }
        ),
        data: {
          "phone": phoneNumber, 
          "otp": _pinOTP
          }
        );
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        User _user = User.fromJson(_response.data);
        _writeData();
        currentUser = _user;
        return _user;
      } else {
        throw new Exception(_response.statusMessage);
      }
    } on DioError catch (err) {
      print(err);
      currentUser = null;
      return null;
    }
  }

}

class User {
  String status;
  String token;
  String refreshToken;
  UserClass user;

  User({
    this.status,
    this.token,
    this.refreshToken,
    this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    status: json["status"] == null ? null : json["status"],
    token: json["token"] == null ? null : json["token"],
    refreshToken: json["refresh_token"] == null ? null : json["refresh_token"],
    user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
  );
}
