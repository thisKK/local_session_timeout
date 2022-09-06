import 'package:example/providers/session_timeout.dart';
import 'package:example/screen/reading.dart';
import 'package:example/screen/writing.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionTimeoutProvider sessionTimeoutProvider = SessionTimeoutProvider();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home page"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // stop listening only after user goes to this page

                //! Its better to handle listening logic in state management
                //! libraries rather than writing them at random places in your app

                sessionTimeoutProvider.sessionStream
                    .add(SessionState.stopListening);

                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ReadingPage(),
                  ),
                );

                //! after user returns from that page start listening again
                sessionTimeoutProvider.sessionStream
                    .add(SessionState.startListening);
              },
              child: const Text("Reading page"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const WritingPage(),
                  ),
                );
              },
              child: const Text("Writing Page"),
            ),
          ],
        ),
      ),
    );
  }
}
