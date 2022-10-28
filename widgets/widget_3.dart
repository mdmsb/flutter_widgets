import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchWithSharedPref extends StatefulWidget {
  const SwitchWithSharedPref({super.key});

  @override
  State<SwitchWithSharedPref> createState() => _SwitchWithSharedPrefState();
}

class _SwitchWithSharedPrefState extends State<SwitchWithSharedPref> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    isSwitched = await getTheme();
    setState(() {});
  }

  getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('theme') ?? false;
  }

  saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', isSwitched);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Theme",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Theme widget"),
        ),
        body: Center(
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
              isSwitched == false
                  ? debugPrint(isSwitched.toString())
                  : debugPrint(isSwitched.toString());
              saveTheme();
            },
          ),
        ),
      ),
    );
  }
}
