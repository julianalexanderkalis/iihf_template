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
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Generate access request for account?"),
              ),
              ElevatedButton(
                  // Generates access request on button press
                  onPressed: () =>
                      Web3FunctionsForWeb().generateAccessRequest(),
                  child: const Text("Generate AC"))
            ],
          ),
        ),
      ],
    );
  }
}
