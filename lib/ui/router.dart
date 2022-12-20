import 'package:flutter/material.dart';
import '../ui/menu_screen.dart';
import 'package:go_router/go_router.dart';
import 'search/search_airport_plane.dart';
import 'splash/screen/splash_screen.dart';

var router = GoRouter(routes: [
  // GoRoute(
  //   path: '/menu',
  //   builder: (context, state) => const SplashScreen(),
  // ),
  GoRoute(
    path: '/',
    builder: (context, state) => const SearchAirplaneAirportScreen(),
  ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => const MenuScreen(),
  // )
]);

Widget get errorPage => const Center(
      child: SizedBox(
        width: 200,
        child: Text('Error, maybe you forgot to include required obj'),
      ),
    );
