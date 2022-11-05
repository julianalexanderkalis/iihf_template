import 'package:flutter/material.dart';
import 'package:iihf_template/helpers/web3functions.dart';

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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Generate access request for account?"),
              ),
              ElevatedButton(
                  onPressed: () =>
                      Web3FunctionsForWeb().generateAccessRequest(),
                  child: Text("Generate AC"))
            ],
          ),
        ),
      ],
    );
  }
}
