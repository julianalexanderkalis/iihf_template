import 'package:flutter/material.dart';
import 'package:iihf_template/components/toDoList.dart';
import 'helpers/web3functions.dart';
import 'package:flutter_web3/flutter_web3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IIHF Demo application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
            background: Colors.grey[900],
            secondary: Colors.orange[400],
            primary: Colors.grey[900],
            tertiary: Colors.green[300]),
      ),
      home: const MyHomePage(title: 'Smart Contract ToDo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tasks = 0;
  String newTask = "";

  bool connected = false;
  late Future<List<Event>> listOfTasks = Web3FunctionsForWeb().getTaskCount();
  void connectWallet() async {
    var res = await Web3FunctionsForWeb().metamask();

    if (res['connected'] == true) {
      setState(() {
        connected = true;
      });
    }
  }

  void fetchTasks() {
    setState(() {
      listOfTasks = Web3FunctionsForWeb().getTaskCount();
    });
    Web3FunctionsForWeb().fetchProposals();
  }

  void addTask(task) {
    setState(() {
      newTask = task;
    });
  }

  void submitTask() {
    if (newTask == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Can't add an empty task"),
          backgroundColor: Colors.red[300],
        ),
      );
      return;
    }

    Web3FunctionsForWeb().addTask(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Spartan',
          ),
        ),
      ),
      body: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceEvenly,
          spacing: 50,
          children: <Widget>[
            SizedBox(
              height: 400,
              width: 400,
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const Text(
                        "My ToDo's",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Spartan',
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: MyToDos(
                          listOfTasks: listOfTasks,
                          key: const Key("mytodos"),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                          overlayColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                        ),
                        onPressed: () => {fetchTasks()},
                        child: const Text("Get my tasks",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Spartan',
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text(
                        "Add Task",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Spartan',
                        ),
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Spartan',
                        ),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: Color(0xFFBDBDBD),
                          ),
                          hintText: "Enter the task to add",
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        onChanged: (value) => {addTask(value)},
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                          overlayColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                        ),
                        onPressed: () => {submitTask()},
                        child: const Text("Add Task",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Spartan',
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text(
                        "Wallet connection",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Spartan',
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                          overlayColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                        ),
                        onPressed: () => {connectWallet()},
                        child: const Text("Connect Wallet",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Spartan',
                            )),
                      ),
                      if (connected == true)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Wallet connected",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontFamily: 'Spartan',
                              ),
                            )
                          ],
                        )
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
