import 'dart:math';
import 'package:flutter/material.dart';

class Clockpage extends StatefulWidget {
  const Clockpage({super.key});

  @override
  State<Clockpage> createState() => _ClockpageState();
}

class _ClockpageState extends State<Clockpage> {
  int s = DateTime.now().second;
  int m = DateTime.now().minute;
  int h = DateTime.now().hour;

  void Setclock() {
    Future.delayed(const Duration(seconds: 1), () {
      s = DateTime.now().second;
      m = DateTime.now().minute;
      h = DateTime.now().hour;
      setState(() {});
      Setclock();
    });
  }

  @override
  void initState() {
    super.initState();
    Setclock();
  }

  bool isAnalog = true;
  bool isStrap = false;

  List<String> clocktheme = [
    "lib/assets/images/clockdial1.png",
    "lib/assets/images/clockdial2.png",
    "lib/assets/images/clockdial3.png",
  ];

  String selectedtheme = "lib/assets/images/clockdial1.png";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clock Page"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("om-savani"),
              accountEmail: Text("savaniom27@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/156919604?s=400&u=948693c27fd81a3b0c3d4da6e0431f0ccd545f7c&v=4"),
              ),
            ),
            const Text(
              "Clock Type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Analog",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: isAnalog,
                  onChanged: (val) {
                    isStrap = false;
                    isAnalog = val;
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Strap",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: isStrap,
                  onChanged: (val) {
                    isAnalog = false;
                    isStrap = val;
                    setState(() {});
                  },
                ),
              ],
            ),
            const Text(
              "Clock Theme",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Visibility(
              visible: isAnalog,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: clocktheme
                        .map((e) => GestureDetector(
                              onTap: () {
                                selectedtheme = e;
                                setState(() {});
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.asset(e),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                              ),
                            ))
                        .toList()),
              ),
            ),
            // Visibility(
            //   visible: isAnalog,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //         children: clocktheme
            //             .map((e) => GestureDetector(
            //                   onTap: () {
            //                     selectedtheme = e;
            //                     setState(() {});
            //                   },
            //                   child: Container(
            //                     height: 100,
            //                     width: 100,
            //                     child: Image.asset(e),
            //                     decoration: BoxDecoration(
            //                         border: Border.all(color: Colors.grey)),
            //                   ),
            //                 ))
            //             .toList()),
            //   ),
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isAnalog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 400,
                    width: 400,
                    child: Image(
                      image: AssetImage(selectedtheme),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: s * (pi * 2) / 60,
                      child: Divider(
                        color: Colors.red,
                        thickness: 2,
                        indent: 120,
                        endIndent: size.width * 0.5 - 16,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: m * (pi * 2) / 60,
                      child: Divider(
                        color: Colors.black,
                        thickness: 3,
                        indent: 160,
                        endIndent: size.width * 0.5 - 16,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: h * (pi * 2) / 12,
                      child: Divider(
                        color: Colors.black,
                        thickness: 4,
                        indent: 200,
                        endIndent: size.width * 0.5 - 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isStrap,
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: 5,
                      child: CircularProgressIndicator(
                        value: s / 60,
                        color: Colors.orange.shade900,
                        strokeWidth: 2,
                        backgroundColor: Colors.orange.shade200,
                      ),
                    ),
                    Transform.scale(
                      scale: 4,
                      child: CircularProgressIndicator(
                        value: m / 60,
                        color: Colors.green.shade900,
                        backgroundColor: Colors.green.shade200,
                        strokeWidth: 3,
                      ),
                    ),
                    Transform.scale(
                      scale: 3,
                      child: CircularProgressIndicator(
                        value: (h % 12) / 12,
                        color: Colors.blue.shade900,
                        backgroundColor: Colors.blue.shade200,
                        strokeWidth: 4.5,
                      ),
                    ),
                    Text(
                      "${h.toString()} : $m : $s",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('stop_watch');
        },
      ),
    );
  }
}
