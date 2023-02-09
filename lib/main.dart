import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'NewPage.dart';
import 'OTT_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const FirstPage(),
        'myApp': (context) => const MyApp(),
        'newPage': (context) => const NewPage(),
        'ottPage': (context) => const OttPage(),
        'ottApp': (context) => const OttApp(),
      },
    ),
  );
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home Page",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/educate.png",
                      height: 400,
                    ),
                    Container(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    Align(
                      alignment: const Alignment(0, 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pushNamed('myApp');
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Education Wesite",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/music.png",
                      height: 400,
                    ),
                    Container(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    Align(
                      alignment: Alignment(0, 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pushNamed('ottApp');
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "OTT Platform",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
