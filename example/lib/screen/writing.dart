import 'package:example/providers/session_timeout.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:provider/provider.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  SessionTimeoutProvider sessionTimeoutProvider = SessionTimeoutProvider();

  @override
  void initState() {
    sessionTimeoutProvider = context.read<SessionTimeoutProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sessionTimeoutProvider.sessionStream.add(SessionState.startListening);
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      // softkeyboard is open
      sessionTimeoutProvider.sessionStream.add(SessionState.stopListening);
    } else {
      // keyboard is closed
      sessionTimeoutProvider.sessionStream.add(SessionState.startListening);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
                "If the user is typing into the textbox, you may want to disable the session timeout listeners because typing events aren't captured by session timeout manager and it may conclude that user is inactive"),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 16, 17, 17))),
                hintText: 'Start typing here',
                helperText: 'when keyboard is open, session won"t expire',
                prefixText: ' ',
                suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Color.fromARGB(255, 14, 14, 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
