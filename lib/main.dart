import 'package:flutter/material.dart';
import 'package:iihf_template/components/athlete_dashboard.dart';
import 'package:iihf_template/components/scout_dashboard.dart';
import 'helpers/web3functions.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String role = "";

  void setRole(value) {
    setState(() {
      role = value;
    });
    print(role);
  }

  renderBody() {
    Web3FunctionsForWeb().metamask();
    if (role == "") {
      return MyHomePage(
        title: 'Smart Contract ToDo List',
        setRole: setRole,
      );
    } else if (role == "scout") {
      return const ScoutDashboard(
        userRole: "scout",
      );
    } else {
      return const AthleteDashboard(
        userRole: "athlete",
      );
      ;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IIHF Demo application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          secondary: Colors.black,
          primary: Colors.black,
        ),
      ),
      home: renderBody(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Function setRole;

  const MyHomePage({
    super.key,
    required this.title,
    required this.setRole,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tasks = 0;
  String newTask = "";

  bool connected = false;

  void connectWallet() async {
    var res = await Web3FunctionsForWeb().metamask();

    if (res['connected'] == true) {
      setState(() {
        connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceEvenly,
          spacing: 50,
          children: <Widget>[
            SizedBox(
              height: 600,
              width: 400,
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "For Scouts",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Spartan',
                        ),
                      ),
                      const Text(
                        "Some sample text",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Spartan',
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                        ),
                        onPressed: () => {
                          widget.setRole("scout"),
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Spartan',
                                fontSize: 18,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 600,
              width: 400,
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "For Athletes",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Spartan',
                        ),
                      ),
                      const Text(
                        "Some sample text",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Spartan',
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                        ),
                        onPressed: () => {
                          widget.setRole("athlete"),
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Spartan',
                                fontSize: 18,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
