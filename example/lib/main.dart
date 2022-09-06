import 'dart:async';

import 'package:example/providers/session_timeout.dart';
import 'package:example/screen/auth.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionTimeoutProvider>(
          create: (context) => SessionTimeoutProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  /// Make this stream available throughout the widget tree with with any state management library
  /// like bloc, provider, GetX, ..
  final session = StreamController<SessionState>();
  SessionTimeoutProvider sessionTimeoutProvider = SessionTimeoutProvider();

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 3),
      invalidateSessionForUserInactiviity: const Duration(seconds: 5),
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // stop listening, as user will already be in auth page
      sessionTimeoutProvider.start();
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
        _navigator.push(MaterialPageRoute(
          builder: (_) => AuthPage(
              loggedOutReason: "Logged out because of user inactivity"),
        ));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        _navigator.push(MaterialPageRoute(
          builder: (_) =>
              AuthPage(loggedOutReason: "Logged out because app lost focus"),
        ));
      }
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      sessionStateStream: sessionTimeoutProvider.sessionStream.stream,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthPage(),
      ),
    );
  }
}
