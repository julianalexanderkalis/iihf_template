// ignore_for_file: file_names

import 'package:flutter_web3/flutter_web3.dart';
import 'package:flutter/material.dart';

class MyToDos extends StatefulWidget {
  final Future<List<Event>> listOfTasks;

  const MyToDos({
    required this.listOfTasks,
    super.key,
  });

  @override
  State<MyToDos> createState() => _MyToDosState();
}

class _MyToDosState extends State<MyToDos> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: widget.listOfTasks,
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        snapshot.data![index].args[1],
                        style: const TextStyle(
                          fontFamily: 'Spartan',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.hasError) {
          return const Text("There occured an error loading the task list");
        }
        return const CircularProgressIndicator(
          color: Colors.amber,
        );
      },
    );
  }
}
