// ignore_for_file: slash_for_doc_comments, file_names

import 'package:flutter/material.dart';
import 'package:iihf_template/helpers/web3functions.dart';

/**
 * Defines new class 'ViewAccessRequest' that renders a list of all the access requests
 * 
 * Inputs:
 *   listOfRequests, type Future List of dynamic
 *   role, type String
 */
class ViewAccessRequest extends StatefulWidget {
  final Future<List<dynamic>> listOfRequests;
  final String role;

  const ViewAccessRequest({
    super.key,
    required this.listOfRequests,
    required this.role,
  });

  @override
  State<ViewAccessRequest> createState() => _ViewAccessRequestState();
}

class _ViewAccessRequestState extends State<ViewAccessRequest> {
  @override
  Widget build(BuildContext context) {
    /**
     * The 'FutureBuilder' is a Widget that renders a 'Future' value
     * This is a value retrieved from a source not present and start.
     */
    return FutureBuilder<List<dynamic>>(
      future: widget.listOfRequests,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        // uses Buildcontext and retrieved Future value as 'snapshot'
        if (snapshot.hasData) {
          // print(
          //   DateTime.fromMillisecondsSinceEpoch(
          //       int.parse(snapshot.data![0][4].toString())),
          // ); just debug
          return ListView.builder(
              itemCount: snapshot.data!
                  .length, // all items in the snapshot object, e.g. all accessRequests for the account
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        // Render following widget only if the user has the 'role' of athlete
                        if (widget.role == "athlete")
                          Row(
                            children: [
                              const Text(
                                "Request sender:",
                                style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                snapshot.data![index][
                                    1], // uses second item in the list object, which is the account of the request sender
                                style: const TextStyle(
                                  fontFamily: 'Spartan',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            const Text(
                              "Players in comparison:",
                              style: TextStyle(
                                fontFamily: 'Spartan',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              snapshot.data![index][2].length
                                  .toString(), // uses third item in the list object, which are the players requested
                              style: const TextStyle(
                                fontFamily: 'Spartan',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Players accepted:",
                              style: TextStyle(
                                fontFamily: 'Spartan',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              snapshot.data![index][3]
                                  .toString(), // uses fourth item in the list object, which shows which players have accepted the request so far
                              style: const TextStyle(
                                fontFamily: 'Spartan',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Created at:",
                              style: TextStyle(
                                fontFamily: 'Spartan',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              DateTime.fromMillisecondsSinceEpoch(int.parse(
                                          snapshot.data![index][4].toString()) *
                                      1000)
                                  .toString(), // render the date when the accessRequest was created, a lot of stupid formatting was needed ... :(
                              style: const TextStyle(
                                fontFamily: 'Spartan',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        if (widget.role == "athlete")
                          Row(
                            children: [
                              IconButton(
                                // Accept the Access request on button press
                                onPressed: () => {
                                  Web3FunctionsForWeb().acceptAccessRequest(
                                    int.parse(snapshot.data![index][0]
                                        .toString()), // this is the ID of the request, used for updating the corresponding object on the smart contract
                                  ),
                                },
                                icon: const Icon(Icons.verified),
                                color: Colors.green,
                              ),
                              IconButton(
                                onPressed: () => {},
                                icon: const Icon(Icons.close),
                                color: Colors.red,
                              )
                            ],
                          )
                      ],
                    ),
                  ),
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
    );
  }
}
