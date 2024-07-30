import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int s = 0;
  int m = 0;
  int h = 0;
  int ms = 0;
  bool started = false;

  List<String> laps = [];

  void startStopTimer() {
    if (started) {
      started = false;
    } else {
      started = true;
      _runStopwatch();
    }
    setState(() {});
  }

  void _runStopwatch() {
    if (!started) return;

    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        ms += 10;
        if (ms >= 1000) {
          ms = 0;
          s++;
        }
        if (s >= 60) {
          s = 0;
          m++;
          if (m >= 60) {
            m = 0;
            h++;
          }
        }
      });
      _runStopwatch();
    });
  }

  void reset() {
    setState(() {
      s = 0;
      m = 0;
      h = 0;
      ms = 0;
      started = false;
      laps.clear();
    });
  }

  void addLap() {
    String lap =
        "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}:${(ms ~/ 10).toString().padLeft(2, '0')}";
    setState(() {
      laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stopwatch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('clock_page');
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
                Text(
                  ".${(ms ~/ 10).toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawMaterialButton(
                  onPressed: startStopTimer,
                  elevation: 5.0,
                  fillColor: Colors.purpleAccent.shade400,
                  constraints: const BoxConstraints(
                    minWidth: 50.0,
                    minHeight: 50.0,
                  ),
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: started
                        ? const Icon(
                            Icons.pause,
                            size: 30,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            size: 30,
                            color: Colors.white,
                          ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: addLap,
                  elevation: 5.0,
                  fillColor: Colors.purpleAccent.shade400,
                  constraints: const BoxConstraints(
                    minWidth: 50.0,
                    minHeight: 50.0,
                  ),
                  shape: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.flag,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: reset,
                  elevation: 5.0,
                  fillColor: Colors.purpleAccent.shade400,
                  constraints: const BoxConstraints(
                    minWidth: 50.0,
                    minHeight: 50.0,
                  ),
                  shape: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.restart,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Laps List
            Expanded(
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Lap ${index + 1}"),
                    trailing: Text(laps[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
