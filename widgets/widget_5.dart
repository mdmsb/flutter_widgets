import 'package:flutter/material.dart';

class LoadScreenWhileWait extends StatefulWidget {
  const LoadScreenWhileWait({super.key});

  @override
  State<LoadScreenWhileWait> createState() => _LoadScreenWhileWaitState();
}

class _LoadScreenWhileWaitState extends State<LoadScreenWhileWait> {
  final ValueNotifier<bool> loadingstat = ValueNotifier<bool>(false);

  loadData() async {
    loadingstat.value = true;
    await Future.delayed(const Duration(seconds: 5));

    loadingstat.value = false;
    debugPrint("LoadScreenWhileWait: Finished loadData() Async func completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoadScreenWhileWait'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        debugPrint("LoadScreenWhileWait: Calling loadData()");
                        loadData();
                        debugPrint(
                            "LoadScreenWhileWait: Finished loadData() call");
                      },
                      child: Text("Load"),
                    ),
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
              if (value) {
                return const Center(
                  child: SizedBox(
                    child: Text("pop up box"),
                  ),
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
