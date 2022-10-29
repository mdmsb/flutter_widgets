import 'dart:convert';

import 'package:essessacc/login.dart';
import 'package:essessacc/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SsAcc extends StatefulWidget {
  const SsAcc({super.key});

  @override
  State<SsAcc> createState() => _SsAccState();
}

Future<List?> getData(token, currYear, currMonth) async {
  // SharedPreferences.getInstance().then((value) {
  //   token = value.getString('token').toString();
  //   debugPrint(token);
  // });

  debugPrint("SsAcc: response Start");
  var authEndpoint =
      "http://192.168.0.142:8080/api/ssacc/$currYear/$currMonth/";
  debugPrint("SsAcc: ${token.toString()}");
  final response = await http.get(
    Uri.parse(authEndpoint),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Token $token"
    },
  );
  debugPrint("SsAcc: ${response.body.toString()}");
  var jsonData = jsonDecode(response.body);

  List<User> users = [];
  for (var u in jsonData) {
    User user = User(u['date'], u['name'], u['desc'], u['amount']);
    users.add(user);
  }
  debugPrint('SsAcc: ${users.length.toString()}');
  debugPrint('SsAcc: ${response.body}');
  debugPrint('SsAcc: ${response.statusCode.toString()}');
  debugPrint('SsAcc: ${jsonData.toString()}');
  debugPrint("SsAcc: response done");
  return users;
}

class User {
  final dynamic date, name, desc, amount;

  User(this.date, this.name, this.desc, this.amount);
}

class _SsAccState extends State<SsAcc> {
  int _selectedIndex = 0;
  int currYear = DateTime.now().year;
  int currMonth = DateTime.now().month;

  void previousMonth() {
    debugPrint("SsAcc : Previous Month $currYear , $currMonth");
    if (currMonth == 1) {
      currYear--;
      currMonth = 12;
    } else {
      currMonth--;
    }
  }

  void nextMonth() {
    debugPrint("SsAcc : Next Month $currYear , $currMonth");
    if (currMonth == 12) {
      currYear++;
      currMonth = 1;
    } else {
      currMonth++;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        previousMonth();
      }
      if (index == 1) {
        nextMonth();
      }
    });
  }

  getToken() async {
    debugPrint("SsAcc: getting prefs token");
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    debugPrint("SsAcc: got prefs token $token");
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Account'),
            const Spacer(),
            Text('$currMonth/$currYear'),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder(
            future: getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
                // SchedulerBinding.instance.addPostFrameCallback((_) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: ((context) => const LoginPage())));
                // });
                // return Container();
              } else {
                debugPrint("SsAcc: got future token ${snapshot.data}");
                return FutureBuilder(
                    future: getData(snapshot.data, currYear, currMonth),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.data == null) {
                        return Text(snapshot.error.toString());
                      } else {
                        return listViewBuilder(snapshot);
                      }
                    });
              }
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_left_outlined),
              label: "Previous Month"),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_right_outlined),
              label: "Next Month"),
        ],
      ),
    );
  }

  ListView listViewBuilder(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      reverse: false,
      itemBuilder: ((context, i) {
        return ListTile(
          title: Text(snapshot.data![i].date.toString()),
          // subtitle: Text(snapshot.data?[i].name),
          subtitle: Row(
            children: [
              Text(
                snapshot.data?[i].name,
                style: const TextStyle(color: Colors.amber),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Text(
                snapshot.data?[i].desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          trailing: Text(snapshot.data![i].amount.toString()),
        );
      }),
    );
  }

  @override
  Future pushLogin(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: ((context) => const LoginPage())));
  }
}
