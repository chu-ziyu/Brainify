// ignore_for_file: lines_longer_than_80_chars

import 'package:brainify/core/navigation/route.dart';
import 'package:brainify/feature/chat/chat_page.dart';
import 'package:brainify/feature/home/home_page.dart';
import 'package:brainify/feature/welcome/welcome_page.dart';
import 'package:brainify/splash_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoute.home.path,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoute.chat.path,
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: AppRoute.welcome.path,
      builder: (context, state) => const WelcomePage(),
    ),
  ],
);
