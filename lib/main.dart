// ignore_for_file: slash_for_doc_comments

/**
 * These are the imports that are needed throughout this file.
 * UI Components from the Flutter framework as well as 
 * our own created Widgets and external packages are imported here.
 */
import 'package:flutter/material.dart';
import 'package:iihf_template/components/athlete_dashboard.dart';
import 'package:iihf_template/components/scout_dashboard.dart';
import 'helpers/web3functions.dart';
import 'package:get_storage/get_storage.dart';

/**
 * Main function that starts the WebApp.
 * Initializes local web storage object to store items in temp
 * browser memory (e.g. cookies, etc)
 */
void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

/**
 * Class 'MyApp' that is the entry Widget to the Application
 * 
 */
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // Create 'State' to be able to manipulate/store objetcs in the app state
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /** 
   * Initialize empty string to manage the 2 different roles later on
   *  Type: String
   */
  String role = "";

  /**
   * Function that alters the 'role' variable
   *  Input argument: value
   *    Type: dynamic
   * Alters state and updates 'role' to chosen 'value'
   */
  void setRole(value) {
    setState(() {
      role = value;
    });
    // print(role);  for debugging, comment out 'print' statement
  }

  /**
   * Function that renders the WebApps body
   *  No Input argument
   * 
   *  Calls the method 'metamask()' of the 'Web3FunctionsForWeb()' class
   *  to connect to the Metamask wallet of the user
   * 
   *  Checks the users current 'role' and renders 'MyHomePage()' accordingly.
   * 
   */
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
    }
  }

  // This widget is the root of the application.
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
        /**
         * The 'theme' argument can be used to set global variables such as 
         * color, fonts, sizes and layout specific values
         */
      ),
      home: renderBody(), // calls the 'renderBody()' function
    );
  }
}

/**
 * Setup for the 'MyHomePage' Widget
 *  Input Arguments:
 *    'title', type String
 *    'setRole', type Function
 */
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          // Wrap is a widget that can either be used as a 'Row' or 'Column' replacement.
          // It aligns Widgets on the specified axis.
          crossAxisAlignment: WrapCrossAlignment
              .center, // Center 'child' Widgets in the middle of the available space with respect to the vertical axis
          alignment: WrapAlignment
              .spaceEvenly, // align the 'child' Widgets evenly on the horizontal axis
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
                    mainAxisSize:
                        MainAxisSize.max, // use maximal available space
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
                        // if the button is pressed, call the Widgets 'setRole' function with 'scout' as as String argument
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
                        // if the button is pressed, call the Widgets 'setRole' function with 'athlete' as as String argument
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
