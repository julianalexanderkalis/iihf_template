import 'package:flutter/material.dart';
import 'package:iihf_template/components/createAccessRequest.dart';
import 'package:iihf_template/components/viewAccessRequest.dart';
import 'package:iihf_template/helpers/web3functions.dart';

class ScoutDashboard extends StatefulWidget {
  final String userRole;
  const ScoutDashboard({
    super.key,
    required this.userRole,
  });

  @override
  State<ScoutDashboard> createState() => _ScoutDashboardState();
}

class _ScoutDashboardState extends State<ScoutDashboard> {
  late Future<List<dynamic>> personalAccessRequests;
  Future<List<dynamic>> fetchAccessRequestScout() async {
    var t = await Web3FunctionsForWeb().fetchAccessRequestsScout();

    return t;
  }

  @override
  void initState() {
    personalAccessRequests = fetchAccessRequestScout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IIHF Recruitment Platform"),
      ),
      body: Row(
        children: [
          Drawer(
            child: ListView(
              padding: const EdgeInsets.all(25),
              children: [
                const SizedBox(height: 50),
                Container(
                  color: Colors.black,
                  child: ListTile(
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  color: Colors.black,
                  child: ListTile(
                    title: const Text(
                      'Comparisons',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  color: Colors.black,
                  child: ListTile(
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 250),
                const Divider(color: Colors.black),
                const SizedBox(height: 250),
                Row(
                  children: const <Widget>[
                    Icon(Icons.exit_to_app),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 800,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: ViewAccessRequest(
                  listOfRequests: personalAccessRequests,
                  role: widget.userRole,
                  key: const Key("1"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: CreateAccessRequest(),
                );
              })
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
