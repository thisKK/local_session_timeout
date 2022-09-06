import 'dart:async';

import 'package:example/providers/session_timeout.dart';
import 'package:example/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

class AuthPage extends StatelessWidget {
  String loggedOutReason;

  AuthPage({Key? key, this.loggedOutReason = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionTimeoutProvider sessionTimeoutProvider = SessionTimeoutProvider();

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loggedOutReason != "")
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  child: Text(loggedOutReason),
                ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // start listening only after user logs in
                  sessionTimeoutProvider.sessionStream
                      .add(SessionState.stopListening);
                  loggedOutReason = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MyHomePage(),
                    ),
                  );
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ));
  }
}
