import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends ChangeNotifier {
  SignInBloc() {
    checkSignIn();
    checkGuestUser();
    initPackageInfo();
  }

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

    String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;
  void initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    _packageName = packageInfo.packageName;
    notifyListeners();
  }
  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    if (_isSignedIn == true) {
      // getProfile();
    }
    notifyListeners();
  }

  Future setGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', true);
    _guestUser = true;
    notifyListeners();
  }

  void checkGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _guestUser = sp.getBool('guest_user') ?? false;
    notifyListeners();
  }

  Future getDataFromSp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    // _name = sp.getString('name');
    // _state = sp.getString('state');
    // _district = sp.getString('district');
    // _email = sp.getString('email');
    // _imageUrl = sp.getString('image_url');
    // _uid = sp.getString('uid');
    // _idToken = sp.getString('auth_token');
    // _signInProvider = sp.getString('sign_in_provider');
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

}
