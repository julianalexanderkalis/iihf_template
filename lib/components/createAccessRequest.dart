// ignore_for_file: slash_for_doc_comments, file_names

import 'package:flutter/material.dart';
import 'package:iihf_template/helpers/web3functions.dart';

/**
 * Defines new class 'CreateAccessRequest' that makes up the create access request dialog
 */
class CreateAccessRequest extends StatelessWidget {
  const CreateAccessRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          right: -40.0,
          top: -40.0,
          child: InkResponse(
            // on tap of the closing icon, 'pops' the upmost Widget, e.g. closes the dialog Widget
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close),
            ),
          ),
        ),
        Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Perform Analysis",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Select players to compare"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(initialValue: "Simon Knak"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(initialValue: "Kasper Simontaival"),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add_circle),
              ),
              DropdownButton<String>(
                value: "Match winning goals",
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  // setState(() {
                  //   dropdownValue = value!;
                  // });
                },
                items: [
                  "Match winning goals",
                  "Penalty scores",
                  "+ Search marketplace"
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  // Generates access request on button press
                  onPressed: () =>
                      Web3FunctionsForWeb().generateAccessRequest(),
                  child: const Text("Generate Request for Data"))
            ],
          ),
        ),
      ],
    );
  }
}
