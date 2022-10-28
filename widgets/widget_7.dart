import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Theme",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Theme widget"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              FirstDropDown(),
              SecondDropDown(),
            ],
          ),
        ));
  }
}

class FirstDropDown extends StatefulWidget {
  const FirstDropDown({super.key});

  @override
  State<FirstDropDown> createState() => _FirstDropDownState();
}

class _FirstDropDownState extends State<FirstDropDown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SecondDropDown extends StatefulWidget {
  const SecondDropDown({super.key});

  @override
  State<SecondDropDown> createState() => _SecondDropDownState();
}

class _SecondDropDownState extends State<SecondDropDown> {
  var _selectedItem = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButton(
        underline: DropdownButtonHideUnderline(child: Container()),
        value: _selectedItem,
        isExpanded: true,
        // items: ['Lion', 'Tiger', 'Cheetah']
        //     .map<DropdownMenuItem<String>>((String value) {
        //   return DropdownMenuItem<String>(
        //     value: value,
        //     child: Text(value),
        //   );
        // }).toList(),
        items: const [
          DropdownMenuItem(
              value: "",
              child: Text(
                "Select Animal",
                style: TextStyle(color: Color.fromARGB(255, 175, 175, 175)),
              )),
          DropdownMenuItem(value: "Tiger", child: Text("Tiger")),
          DropdownMenuItem(value: "Lion", child: Text("Lion")),
          DropdownMenuItem(value: "Dog", child: Text("Dog")),
        ],
        onChanged: (value) {
          setState(() {
            _selectedItem = value!;
          });
        },
      ),
    );
  }
}
