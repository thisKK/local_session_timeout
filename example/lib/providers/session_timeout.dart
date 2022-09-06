import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

class SessionTimeoutProvider with ChangeNotifier {
  final StreamController<SessionState> sessionStream =
      StreamController<SessionState>();

  void start() {
    sessionStream.add(SessionState.startListening);
    notifyListeners();
  }

  void stop() {
    sessionStream.add(SessionState.stopListening);
    notifyListeners();
  }
}
