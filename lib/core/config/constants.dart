

import 'package:flutter/material.dart';

import '../../main.dart';

class Constants {

  static var mediaQuery = MediaQuery.of(navigatorKey.currentState!.context).size;
  static var theme = Theme.of(navigatorKey.currentState!.context);
   static var baseUrl = "https://api.themoviedb.org/3";
  static var apiKey = "690f0c022e9d4a5f970b8bdd5f666bae";
  static var pathImage = "https://image.tmdb.org/t/p/original/";
}