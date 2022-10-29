import 'dart:convert';

import 'package:essessacc/main.dart';
import 'package:essessacc/ssacc.dart';
import 'package:essessacc/theme.dart';
import 'package:essessacc/widgets/widget_4.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

postLogin(user, pass) async {
  final prefs = await SharedPreferences.getInstance();
  debugPrint("Login: response start");
  var authEndpoint = "http://192.168.0.142:8080/api/auth/";

  Map data = {
    'username': user,
    'password': pass,
  };
  var body = json.encode(data);
  var response = await http
      .post(
        Uri.parse(authEndpoint),
        headers: {"Content-Type": "application/json"},
        body: body,
      )
      .timeout(const Duration(seconds: 10));
  debugPrint("Login: response returned");
  var jsonData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    await prefs.setString('token', jsonData["token"]);
    debugPrint("Login: Saved token to sharedpref");
    return "true";
  }
  debugPrint("Login: ${response.body}");
  debugPrint("Login: ${response.statusCode.toString()}");
  debugPrint("Login: ${jsonData.toString()}");
  debugPrint("Login: ${jsonData["token"]}");
  debugPrint("Login: End of post login function");
  return "false";
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> loadingstat = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SS Account'),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 4,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            debugPrint("Login: ${nameController.text}");
                            debugPrint("Login: ${passwordController.text}");
                            loadingstat.value = true;
                            postLogin(nameController.text,
                                    passwordController.text)
                                .then((result) {
                              debugPrint("Login: ${result}");

                              loadingstat.value = false;
                              if (result == "true") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => const SsAcc())));
                              }
                            });
                          },
                        )),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: loadingstat,
            builder: (BuildContext context, dynamic value, Widget? child) {
              if (loadingstat.value) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  child: Icon(Icons.replay_outlined),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
