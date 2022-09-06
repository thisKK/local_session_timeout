import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

class SessionTimeoutProvider with ChangeNotifier {
  final StreamController<SessionState> sessionStream =
      StreamController<SessionState>();

  final sessionConfig = SessionConfig(
    invalidateSessionForAppLostFocus: const Duration(seconds: 3),
    invalidateSessionForUserInactiviity: const Duration(seconds: 5),
  );

  @override
  void dispose() {
    sessionStream.close();
    super.dispose();
    notifyListeners();
  }
}
