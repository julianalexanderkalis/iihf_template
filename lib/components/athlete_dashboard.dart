// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:iihf_template/components/viewAccessRequest.dart';
import 'package:iihf_template/helpers/web3functions.dart';

/**
 * Defines new class 'AthleteDashboard' that makes up the athletes view
 * 
 * Inputs:
 *   userRole, Type String
 * 
 */
class AthleteDashboard extends StatefulWidget {
  final String userRole;
  const AthleteDashboard({
    super.key,
    required this.userRole,
  });

  @override
  State<AthleteDashboard> createState() => _AthleteDashboardState();
}

class _AthleteDashboardState extends State<AthleteDashboard> {
  /**
   * A 'late' variable is a variable whose value is not set an the start but retrieved later
   */
  late Future<List<dynamic>> personalAccessRequests;

  /**
   * Asynchronous function that fetches all access Requests for the athlete
   * 
   * Returns:
   *  List of dynamic objects
   */
  Future<List<dynamic>> fetchAccessRequest() async {
    return await Web3FunctionsForWeb().fetchAccessRequests();
  }

  /**
   * Overrides the 'initState' method
   * 
   * Executes the 'fetchAccessRequests' function and stores it in the 'late' variable previously mentioned above
   */
  @override
  void initState() {
    personalAccessRequests = fetchAccessRequest();
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
                      'Requests',
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
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "My access requests",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                width: 800,
                height: 800,
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
              ),
            ],
          )
        ],
      ),
      // Maybe use, otherwise remove, since it does nothing yet
    );
  }
}
