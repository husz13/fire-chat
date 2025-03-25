import 'package:fire_chat/presentation/chat/pages/home_screen.dart';
import 'package:fire_chat/presentation/auth/pages/login_screen.dart';
import 'package:fire_chat/presentation/auth/pages/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  final user = FirebaseAuth.instance.currentUser;

  late final String initialRoute;
  late final GoRouter router;

  MyRouter() {
    initialRoute = user == null ? "/login" : "/home";
    router = GoRouter(initialLocation: initialRoute, routes: [
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
      ),
      GoRoute(
        path: "/register",
        pageBuilder: (context, state) => MaterialPage(child: RegisterScreen()),
      ),
      GoRoute(
          path: "/home",
          pageBuilder: (context, state) => MaterialPage(child: HomeScreen())),
    ]);
  }
}
