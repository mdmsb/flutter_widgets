import 'package:flutter/material.dart';
import 'package:flutter_widgets/widgets/widget_8.dart';

import 'widgets/widget_1.dart';
import 'widgets/widget_2.dart';
import 'widgets/widget_3.dart';
import 'widgets/widget_4.dart';
import 'widgets/widget_5.dart';
import 'widgets/widget_6.dart';
import 'widgets/widget_7.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Theme widget"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: const [
            WidgetList(myFun: ThemeWidget(), widgetName: "1. Static Theme"),
            WidgetList(
                myFun: ProviderWidget(), widgetName: "2. Using Provider"),
            WidgetList(
                myFun: SwitchWithSharedPref(),
                widgetName: "3. Switch with sharedpreference"),
            WidgetList(
                myFun: NavigateWithButton(),
                widgetName: "4. Navigate with Button"),
            WidgetList(
                myFun: LoadScreenWhileWait(),
                widgetName: "5. Load Screen While Wait"),
            WidgetList(
                myFun: DatePickerWidget(), widgetName: "6. Date Picker Widget"),
            WidgetList(
                myFun: DropdownButtonExample(),
                widgetName: "7. Dropdown Button Example"),
            WidgetList(myFun: SplashScreen(), widgetName: "8. Splash Screen"),
          ],
        ),
      ),
    );
  }
}

class WidgetList extends StatelessWidget {
  final Widget myFun;
  final String widgetName;
  const WidgetList({super.key, required this.myFun, required this.widgetName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widgetName),
            BuildNavigator(myFun: myFun),
          ],
        ),
      ),
    );
  }
}

class BuildNavigator extends StatelessWidget {
  final Widget myFun;
  const BuildNavigator({super.key, required this.myFun});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => myFun)));
        },
        child: const Text("Try >"),
      );
    });
  }
}
