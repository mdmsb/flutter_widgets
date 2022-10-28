import 'package:flutter/material.dart';

class NavigateWithButton extends StatefulWidget {
  const NavigateWithButton({super.key});

  @override
  State<NavigateWithButton> createState() => _NavigateWithButtonState();
}

class _NavigateWithButtonState extends State<NavigateWithButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nav with Button"),
      ),
      body: Column(
        children: [
          const Text("Navigate with button"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const BuildNavigate())));
            },
            child: const Text("Build widget"),
          ),
        ],
      ),
    );
  }
}

class BuildNavigate extends StatelessWidget {
  const BuildNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Text("New Body"),
    );
  }
}
