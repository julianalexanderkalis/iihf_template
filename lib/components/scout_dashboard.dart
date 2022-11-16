// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:iihf_template/components/createAccessRequest.dart';
import 'package:iihf_template/components/viewAccessRequest.dart';
import 'package:iihf_template/helpers/web3functions.dart';

/**
 * Defines new class 'ScoutDashboard' that makes up the scouts view
 * 
 * Inputs:
 *   userRole, Type String
 * 
 */
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
  /**
   * A 'late' variable is a variable whose value is not set an the start but retrieved later
   */
  late Future<List<dynamic>> personalAccessRequests;
  /**
   * Asynchronous function that fetches all access Requests for the scout
   * 
   * Returns:
   *  List of dynamic objects
   */
  Future<List<dynamic>> fetchAccessRequestScout() async {
    return await Web3FunctionsForWeb().fetchAccessRequestsScout();
  }

  /**
   * Overrides the 'initState' method
   * 
   * Executes the 'fetchAccessRequests' function and stores it in the 'late' variable previously mentioned above
   */
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
                /**
                 * Here, the 'ViewAccessRequest' Widget is rendered
                 * Inputs:
                 *  'listOfRequests' , list of all access Requests, type List of dynamic
                 *  'role': role of the user, type String
                 */
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
      /**
       * Renders a simple dialog 
       */
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  // renders the 'CreateAccessRequest' Widget
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
