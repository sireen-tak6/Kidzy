import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart ' as http;
import 'package:version_1/screens/auth/authScreenAnimated.dart';

import '../main.dart';

class auth with ChangeNotifier {
  static SharedPreferences? sp;
  String? _token;
  DateTime? _expiryDate;
  String? _firstname;
  String? _lastname;
  String? _email;
  Timer? _authTimer;
  String? _childname;
  int? _childgender;
  int? _childid;

  bool get isAuth {
    return token != null;
  }

  void set childname(name) {
    _childname = name;
  }

  void set childid(id) {
    _childid = id;
  }

  void set childgender(gender) {
    _childgender = gender;
  }

  get childname {
    return _childname;
  }

  get childid {
    return _childid;
  }

  get childgender {
    return _childgender;
  }

  String? get name {
    return "${_firstname} ${_lastname}";
  }

  String? get email {
    return _email;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<String> changeName(firstname, lastname) async {
    var sp = await SharedPreferences.getInstance();

    final test = sp.getString('userData');
    final extractedData = await json.decode(sp.getString('userData')!);

    extractedData['firstname'] = firstname;
    extractedData['lastname'] = lastname;
    var userData = json.encode(extractedData);

    sp = await SharedPreferences.getInstance();
    await sp.setString('userData', userData);
    _firstname = firstname;
    _lastname = lastname;
    notifyListeners();
    return "true";
  }

  Future<String> authenticate(_data, url1) async {
    final response = await http.post(Uri.parse("http://${url}/${url1}"),
        body: json.encode(_data));

    var l = json.decode(response.body);
    String userData;
    try {
      if (l["message"] != true) {
        return l["message"];
      }

      _token = l['access_token'];
      _firstname = l["firstname"];
      _lastname = l["lastname"];
      _email = l["email"];

      _expiryDate = DateTime.now().add(Duration(days: 30));
      userData = json.encode({
        'token': _token,
        'expiryDate': _expiryDate.toString(),
        'lastname': _lastname,
        'firstname': _firstname,
        'email': _email,
        'facebook': 0
      });

      sp = await SharedPreferences.getInstance();
      await sp!.setString('userData', userData);
      var t = await sp!.getString('userData');
      notifyListeners();
      return "true";
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    print("auto login start");
    sp = await SharedPreferences.getInstance();
    if (sp!.getString('userData') != null) {
      final test = sp!.getString('userData');
      final extractedData = await json.decode(sp!.getString('userData')!);
      final expiryDate = DateTime.parse(extractedData['expiryDate'].toString());
      if (expiryDate.isBefore(DateTime.now())) return false;

      _token = extractedData['token'].toString();
      _expiryDate = expiryDate;
      _email = extractedData['email'];
      _firstname = extractedData['firstname'];
      _lastname = extractedData['lastname'];
      notifyListeners();
      _autoLogout();
      return true;
    }
    return false;
  }

  Future<String> logout() async {
    _token = null;
    _expiryDate = null;
    _firstname = null;
    _lastname = null;
    _email = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    await sp!.clear();
    return "true";
  }

  void _autoLogout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timetoExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = await Timer(Duration(seconds: timetoExpiry), logout);
  }
}
