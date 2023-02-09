import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'Globals.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController? inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Educational Website",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: Globals.education.map((e) {
            return GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, 'newPage',
                    arguments: [inAppWebViewController, e['path']]);
                print("${e['id']}");
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.blueGrey.withOpacity(0.1),
                child: Image.asset(
                  "${e['image']}",
                  height: 80,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  List<String> bookmark = [];

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.blue),
        onRefresh: () async {
          if (Platform.isAndroid) {
            await inAppWebViewController!.reload();
          } else if (Platform.isIOS) {
            await inAppWebViewController!.loadUrl(
              urlRequest: URLRequest(
                url: await inAppWebViewController!.getUrl(),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    List s = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await inAppWebViewController!
                  .loadUrl(urlRequest: URLRequest(url: Uri.parse("${s[1]}")));
            },
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                inAppWebViewController!.goBack();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () {
              inAppWebViewController!.reload();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoForward()) {
                inAppWebViewController!.goForward();
              }
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(s[1]),
        ),
        onWebViewCreated: (val) {
          inAppWebViewController = val;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Uri? uri = await inAppWebViewController!.getUrl();

          bookmark.add(uri!.toString());

          showDialog(context: context, builder: (context){
            return Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 30,right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("$bookmark",style: TextStyle(fontSize: 15,color: Colors.black),),
              ),
            );
          });
        },
        child: const Icon(
          Icons.bookmark_border,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
