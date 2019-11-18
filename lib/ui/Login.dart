import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/ForgotPasswordRequest.dart';
import 'package:hrpayroll/request_model/loginRequest.dart';
import 'package:hrpayroll/response_model/ForgotPasswordResponse.dart';
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

  LoginResponse _myData;

  ApiInterface _apiInterface = ApiInterface();

  void updateSharedPrefs(
      String sessionId, String userName, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString(Util.sessionId, sessionId);
      sharedPreferences.setString(Util.userName, userName);
      sharedPreferences.setString(Util.password, password);
    });

    debugPrint("SFsessionId: $sessionId");
    debugPrint("SFuseName: $userName");

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

      updateSharedPrefs(_myData.data[0].sessionId.toString(),
          _myData.data[0].userId.toString(), _passwordController.text);
    } else {
      Navigator.pop(context);
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
        },
      );
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
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("Logging in please wait...")
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: new Text(
                          "Login",
                          style: new TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return MyDialog();
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

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  var _emailController = new TextEditingController();
  var _authCodeController = new TextEditingController();
  var _newPasswordController = new TextEditingController();
  var _confirmPasswordController = new TextEditingController();

  bool emailIdVisibility = false,
      authCodeVisibility = false,
      newPasswordVisibility = false,
      confirmPasswordVisibility = false;
  bool getCodeVisibility = false,
      resetPasswordVisibility = false,
      submitVisibility = false;

  bool emailIdBlankCheck = false,
      authCodeBlankCheck = false,
      newPasswordBlankCheck = false,
      confirmPasswordBlankCheck = false;

  String forgotPasswordTitle = "GET CODE";

  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  ForgotPasswordResponse _forgotPasswordResponse;

  @override
  void initState() {
    setState(() {
      emailIdVisibility = true;
      getCodeVisibility = true;

      emailIdBlankCheck = true;

      forgotPasswordTitle = "GET CODE";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(forgotPasswordTitle),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      content: Container(
        height: getCodeVisibility ? 92 : 164,
        child: Column(
          children: <Widget>[
            Visibility(
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Enter Your Email Id",
                  icon: Icon(Icons.mail),
                ),
                onChanged: (text) {
                  if (text == "") {
                    setState(() {
                      emailIdBlankCheck = true;
                    });
                  } else {
                    setState(() {
                      emailIdBlankCheck = false;
                    });
                  }
                },
              ),
              visible: emailIdVisibility,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
              child: Visibility(
                child: MyBlinkingEmailText(),
                visible: emailIdBlankCheck,
              ),
            ),
            Visibility(
              child: TextField(
                controller: _authCodeController,
                decoration: InputDecoration(
                  labelText: "Enter Auth Code",
                  icon: Icon(Icons.vpn_key),
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text == "") {
                    setState(() {
                      authCodeBlankCheck = true;
                    });
                  } else {
                    setState(() {
                      authCodeBlankCheck = false;
                    });
                  }
                },
              ),
              visible: authCodeVisibility,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
              child: Visibility(
                child: MyBlinkingAuthCodeText(),
                visible: authCodeBlankCheck,
              ),
            ),
            Visibility(
              child: TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: "Enter New Password",
                  icon: Icon(Icons.lock_open),
                ),
                onChanged: (text) {
                  if (text == "") {
                    setState(() {
                      newPasswordBlankCheck = true;
                    });
                  } else {
                    setState(() {
                      newPasswordBlankCheck = false;
                    });
                  }
                },
              ),
              visible: newPasswordVisibility,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
              child: Visibility(
                child: MyBlinkingNewPassText(),
                visible: newPasswordBlankCheck,
              ),
            ),
            Visibility(
              child: TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  icon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                onChanged: (text) {
                  if (text == "") {
                    setState(() {
                      confirmPasswordBlankCheck = true;
                    });
                  } else {
                    setState(() {
                      confirmPasswordBlankCheck = false;
                    });
                  }
                },
              ),
              visible: confirmPasswordVisibility,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
              child: Visibility(
                child: MyBlinkingConfPassText(),
                visible: confirmPasswordBlankCheck,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Visibility(
          child: FlatButton(
            onPressed: () {
              getCode();
            },
            child: Text(
              "GET CODE",
              style: TextStyle(color: Colors.red),
            ),
          ),
          visible: getCodeVisibility,
        ),
        Visibility(
          child: FlatButton(
            onPressed: () {
              resetPassword();
            },
            child: Text(
              "RESET PASSWORD",
              style: TextStyle(color: Colors.green),
            ),
          ),
          visible: resetPasswordVisibility,
        ),
        Visibility(
          child: FlatButton(
            onPressed: () {
              submit();
            },
            child: Text(
              "SUBMIT",
              style: TextStyle(color: Colors.green),
            ),
          ),
          visible: submitVisibility,
        ),
      ],
    );
  }

  void getCode() async {
    if (!emailIdBlankCheck) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text("Generating Auth Code...")
              ],
            ),
          );
        },
      );

      _forgotPasswordResponse = await _apiInterface1.getAuthCode(
        ForgotPasswordRequest(
          emailAddress: _emailController.text,
        ),
      );

      if (_forgotPasswordResponse.status) {
        Navigator.pop(context);

        setState(() {
          getCodeVisibility = false;
          authCodeVisibility = true;
          resetPasswordVisibility = true;

          authCodeBlankCheck = true;

          forgotPasswordTitle = "REQUEST RESET PASSWORD";
        });

        Fluttertoast.showToast(
          msg: _forgotPasswordResponse.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Navigator.pop(context);

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(_forgotPasswordResponse.message),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    }
  }

  void resetPassword() async {
    if (!authCodeBlankCheck) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text("Requesting Reset Password...")
              ],
            ),
          );
        },
      );

      _forgotPasswordResponse = await _apiInterface2.forgotPassword(
        ForgotPasswordRequest(
            emailAddress: _emailController.text,
            authCode: _authCodeController.text),
      );

      if (_forgotPasswordResponse.status) {
        Navigator.pop(context);

        setState(() {
          emailIdVisibility = false;
          authCodeVisibility = false;
          resetPasswordVisibility = false;
          newPasswordVisibility = true;
          confirmPasswordVisibility = true;
          submitVisibility = true;

          newPasswordBlankCheck = true;
          confirmPasswordBlankCheck = true;

          forgotPasswordTitle = "SET NEW PASSWORD";
        });

        Fluttertoast.showToast(
          msg: _forgotPasswordResponse.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(_forgotPasswordResponse.message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
    }
  }

  void submit() async {
    if (!newPasswordBlankCheck && !confirmPasswordBlankCheck) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text("Setting New Password...")
              ],
            ),
          );
        },
      );

      _forgotPasswordResponse = await _apiInterface3.resetPassword(
        ForgotPasswordRequest(
          emailAddress: _emailController.text,
          authCode: _authCodeController.text,
          password: _newPasswordController.text,
          passwordConfirm: _confirmPasswordController.text,
        ),
      );

      if (_forgotPasswordResponse.status) {
        Navigator.pop(context);
        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: "Password reset successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(_forgotPasswordResponse.message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
    }
  }
}

class MyBlinkingEmailText extends StatefulWidget {
  @override
  _MyBlinkingEmailTextState createState() => _MyBlinkingEmailTextState();
}

class _MyBlinkingEmailTextState extends State<MyBlinkingEmailText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        "email cannot be blank",
        style: TextStyle(
          fontSize: 11,
          color: Colors.red,
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MyBlinkingAuthCodeText extends StatefulWidget {
  @override
  _MyBlinkingAuthCodeTextState createState() => _MyBlinkingAuthCodeTextState();
}

class _MyBlinkingAuthCodeTextState extends State<MyBlinkingAuthCodeText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        "enter 6 digit code sent to your email",
        style: TextStyle(
          fontSize: 11,
          color: Colors.red,
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MyBlinkingNewPassText extends StatefulWidget {
  @override
  _MyBlinkingNewPassTextState createState() => _MyBlinkingNewPassTextState();
}

class _MyBlinkingNewPassTextState extends State<MyBlinkingNewPassText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        "enter password",
        style: TextStyle(
          fontSize: 11,
          color: Colors.red,
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MyBlinkingConfPassText extends StatefulWidget {
  @override
  _MyBlinkingConfPassTextState createState() => _MyBlinkingConfPassTextState();
}

class _MyBlinkingConfPassTextState extends State<MyBlinkingConfPassText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        "re-enter password",
        style: TextStyle(
          fontSize: 11,
          color: Colors.red,
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
