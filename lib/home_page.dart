import 'dart:isolate';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/gifs/animation_lk5db2tf_small.gif'),
              ElevatedButton(
                onPressed: () {
                  dynamic total = task();
                  debugPrint(total.toString());
                },
                child: const Text('1'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final ReceivePort receivePort =
                      ReceivePort(); // To receive the send port
                  await Isolate.spawn(
                      complexTask, receivePort.sendPort); // Created an Isolate
                  receivePort.listen((total) {
                    debugPrint(total.toString());
                  });
                },
                child: const Text('1'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('1'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double task() {
    double total = 0;
    for (var i = 1; i < 1000000000; i++) {
      total += 1;
    }
    return total;
  }
}

complexTask(SendPort sendPort) {
  double total = 0;
  for (var i = 1; i < 1000000000; i++) {
    total += 1;
  }
  sendPort.send(total);
}
