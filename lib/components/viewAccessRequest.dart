import 'package:flutter/material.dart';
import 'package:iihf_template/helpers/web3functions.dart';

class ViewAccessRequest extends StatefulWidget {
  final Future<List<dynamic>> listOfRequests;

  const ViewAccessRequest({
    super.key,
    required this.listOfRequests,
  });

  @override
  State<ViewAccessRequest> createState() => _ViewAccessRequestState();
}

class _ViewAccessRequestState extends State<ViewAccessRequest> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.listOfRequests,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          print(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(snapshot.data![0][4].toString())),
          );
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
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
                                snapshot.data![index][1],
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
                                snapshot.data![index][2].length.toString(),
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
                                snapshot.data![index][3].toString(),
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
                                            snapshot.data![index][4]
                                                .toString()) *
                                        1000)
                                    .toString(),
                                style: const TextStyle(
                                  fontFamily: 'Spartan',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => {Web3FunctionsForWeb().acceptAccessRequest(int.parse(snapshot.data![index][0].toString()),),},
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
                }),
          );
        } else if (snapshot.hasError) {
          return const Text(
            "There occured an error loading the task list",
            style: TextStyle(color: Colors.black),
          );
        }
        return const CircularProgressIndicator(
          color: Colors.amber,
        );
      },
    );
  }
}
