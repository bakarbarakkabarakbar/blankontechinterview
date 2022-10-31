import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController username =
      TextEditingController(text: "text@interview.com");
  TextEditingController password = TextEditingController(text: "12345678");
  var dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchData();
  }

  String _fetchedData = "Auth Data";

  // void _fetchData() {
  //   String uri = "https://dev-api-partners.blankontech.com";
  //   var url = Uri.https(uri, "account/auth");
  //   var authData = http.post(url,
  //       body: {"username": "test@interview.com", "password": "12345678"});
  // }

  @override
  Widget build(BuildContext context) {
    var _statusCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Initialized Auth',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Status Code : $_statusCode",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Fetched Data : $_fetchedData",
              style: Theme.of(context).textTheme.headline4,
            ),
            TextFormField(
              controller: username,
            ),
            TextFormField(
              controller: password,
            ),
            ElevatedButton(
                onPressed: () async {
                  var url = Uri.parse(
                      "https://dev-api-partners.blankontech.com/account/auth");
                  var urihttps = Uri.https(
                      "dev-api-partners.blankontech.com", "/account/auth", {
                    "username": "test@interview.com",
                    "password": "12345678"
                  });
                  var map = new Map<String, dynamic>();
                  map['username'] = "test@interview.com";
                  map['password'] = "12345678";
                  http.Response authData = await http.post(urihttps, body: {
                    "username": username.text,
                    "password": password.text
                  });
                  print(authData.statusCode);
                  print(authData.body);
                  // setState(() {
                  //   _statusCode = authData.statusCode.toString();
                  //   _fetchedData = authData.body;
                  //   print(authData.body);
                  // });
                },
                child: Text(
                  'Auth Using Http',
                  style: Theme.of(context).textTheme.headline4,
                )),
            ElevatedButton(
                onPressed: () async {
                  final authData = await dio.post(
                      "https://dev-api-partners.blankontech.com/account/auth",
                      data: {
                        "username": "test@interview.com",
                        "password": "12345678"
                      });
                  print(authData.statusCode);
                  print(authData.data);
                },
                child: Text(
                  'Auth Using DIO',
                  style: Theme.of(context).textTheme.headline4,
                ))
          ],
        ),
      ),
    );
  }
}
