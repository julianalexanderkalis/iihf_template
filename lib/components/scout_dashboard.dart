// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:iihf_template/components/createAccessRequest.dart';
import 'package:iihf_template/components/viewAccessRequest.dart';
import 'package:iihf_template/helpers/athlete_mapping.dart';
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
  late Future<List<dynamic>> rankings;
  /**
   * Asynchronous function that fetches all access Requests for the scout
   * 
   * Returns:
   *  List of dynamic objects
   */
  Future<List<dynamic>> fetchAccessRequestScout() async {
    return await Web3FunctionsForWeb().fetchAccessRequestsScout();
  }

  Future<List<dynamic>> fetchRankings() async {
    return await Web3FunctionsForWeb().getStats();
  }

  /**
   * Overrides the 'initState' method
   * 
   * Executes the 'fetchAccessRequests' function and stores it in the 'late' variable previously mentioned above
   */
  @override
  void initState() {
    personalAccessRequests = fetchAccessRequestScout();
    rankings = fetchRankings();
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
          Column(
            children: [
              const SizedBox(
                height: 50,
                width: 50,
              ),
              const Text(
                "Top compared athletes",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Spartan',
                  color: Colors.black,
                ),
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 500,
                    child: FutureBuilder<List<dynamic>>(
                      future: rankings,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount:
                                  5, // all items in the snapshot object, e.g. all accessRequests for the account
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        athleteNames[index],
                                        style: const TextStyle(
                                          fontFamily: 'Spartan',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      snapshot.data![0][index]
                                          .toString(), // uses second item in the list object, which is the account of the request sender
                                      style: const TextStyle(
                                        fontFamily: 'Spartan',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else if (snapshot.hasError) {
                          // if the 'snapshot' object should not have any data in it
                          return const Text(
                            "There occured an error loading the task list",
                            style: TextStyle(color: Colors.black),
                          );
                        }
                        // while waiting for the data, display a round loading button
                        return const CircularProgressIndicator(
                          color: Colors.amber,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                width: 500,
                child: Divider(color: Colors.black, height: 2, thickness: 1),
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
            ],
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
        backgroundColor: Colors.white,
        elevation: 25,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        tooltip: "Create analysis",
      ),
    );
  }
}
