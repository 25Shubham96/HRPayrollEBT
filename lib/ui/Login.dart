import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/loginRequest.dart';
import 'package:hrpayroll/response_model/loginResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './Dashboard.dart';
import './MyAppBar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _userController = new TextEditingController(text: "emp-0001");
  var _passwordController = new TextEditingController(text: "billgurung");

  String title = "";

  var _emailController = new TextEditingController();
  var _authCodeController = new TextEditingController();
  var _newPasswordController = new TextEditingController();
  var _confirmPasswordController = new TextEditingController();

  LoginResponse _myData;

  ApiInterface _apiInterface = ApiInterface();

  void UpdateSharedPrefs(String sessionId, String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString(Util.sessionId, sessionId);
      sharedPreferences.setString(Util.userName, userName);
    });

    debugPrint("SFsessionId: ${sessionId}");
    debugPrint("SFuseName: ${userName}");

    Navigator.pop(context);
    Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new Dashboard();
            }));
  }

  void getLoginResponse(BuildContext context, LoginRequest req) async {
    _myData = await _apiInterface.checkLogin(req);

    if (_myData.status) {
      debugPrint("sessionId: ${_myData.data[0].sessionId.toString()}");
      debugPrint("useName: ${_myData.data[0].userId.toString()}");

      UpdateSharedPrefs(_myData.data[0].sessionId.toString(),
              _myData.data[0].userId.toString());

    } else {
      var alert = new AlertDialog(
        title: new Text("Caution!"),
        content: new Text(_myData.message),
        actions: <Widget>[
          new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text("OK")),
        ],
      );
      showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return alert;
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBar.getAppBar("Login"),
      backgroundColor: Colors.grey.shade300,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(10)),
            new Image.asset(
              "images/face.png",
              color: Colors.black,
              height: 150,
              width: 150,
            ),
            new Padding(padding: new EdgeInsets.all(10)),
            new Container(
              padding: new EdgeInsets.fromLTRB(5, 0, 5, 0),
              margin: new EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 200,
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _userController,
                    decoration: new InputDecoration(
                      labelText: "Username",
                      icon: new Icon(Icons.person),
                    ),
                  ),
                  new TextField(
                    controller: _passwordController,
                    decoration: new InputDecoration(
                      labelText: "Password",
                      icon: new Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  new Padding(padding: new EdgeInsets.all(10)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new FlatButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          _userController.clear();
                          _passwordController.clear();
                        },
                        child: new Text(
                          "Clear",
                          style: new TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                      ),
                      new Padding(padding: new EdgeInsets.only(left: 70)),
                      new FlatButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          if (_userController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                            var alert = new AlertDialog(
                              title: new Text("Caution!"),
                              content: new Text("one or more blank entry"),
                              actions: <Widget>[
                                new FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: new Text("OK")),
                              ],
                            );
                            showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return alert;
                                    });
                          } else {
                            LoginRequest req = LoginRequest(
                              username: _userController.text,
                              password: _passwordController.text,
                            );

                            getLoginResponse(context, req);

                            showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Row(
                                          children: <Widget>[
                                            CircularProgressIndicator(),
                                            Padding(padding: EdgeInsets.only(left: 10)),
                                            Text("Logging in please wait...")
                                          ],
                                        ),
                                      );
                                    }
                            );
                          }
                        },
                        child: new Text(
                          "Login",
                          style: new TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.all(10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    alignment: Alignment.topLeft,
                    child: new Row(
                      children: <Widget>[
                        new Checkbox(value: false, onChanged: null),
                        new Text(
                          "Remember Me",
                          style: new TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.all(10),
                    alignment: Alignment.topRight,
                    child: new FlatButton(
                      onPressed: () {
                        AlertDialog dialog = AlertDialog(
                          title: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("My Custom Title"),
                                ),
                                FlatButton(
                                  child: Icon(Icons.close, color: Colors.red,),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                          content: Container(
                            child: Column(
                              children: <Widget>[
                                Visibility(
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: "Enter Your Email Id",
                                      icon: Icon(Icons.mail),
                                    ),
                                  ),
                                  visible: true,
                                ),
                                Visibility(
                                  child: TextField(
                                    controller: _authCodeController,
                                    decoration: InputDecoration(
                                      labelText: "Enter Auth Code",
                                      hintText: "6 digit code sent to your email",
                                      icon: Icon(Icons.mail),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  visible: true,
                                ),
                                Visibility(
                                  child: TextField(
                                    controller: _newPasswordController,
                                    decoration: InputDecoration(
                                      labelText: "Enter New Password",
                                      icon: Icon(Icons.mail),
                                    ),
                                  ),
                                  visible: true,
                                ),
                                Visibility(
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                      icon: Icon(Icons.mail),
                                    ),
                                    obscureText: true,
                                  ),
                                  visible: true,
                                ),
                              ],
                            ),
                          ),

                        );

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext) {
                            return dialog;
                          },
                        );
                      },
                      child: new Text(
                        "Forgot Password",
                        style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<LoginResponse> checkLogin(LoginRequest data) async {
  String apiURL = "http://103.1.92.74:8098/api/loginapi/login";

  var response = await http.post(
    apiURL,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: loginReqToJson(data),
  );

  return loginResFromJson(response.body);
}
