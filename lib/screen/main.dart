import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cummins/utils/colors.dart';
import 'package:cummins/services/routers.dart';
import 'package:cummins/services/auth.dart';
Widget screen(context){
  if(Platform.isAndroid || Platform.isIOS){
    return buildScreen(context);
  }else{
    return  Routers.splash();
  }
}

buildScreen(context){
  final navigatorKey = GlobalKey<NavigatorState>();
  return MaterialApp(
    title: 'Cummins',
    navigatorKey: navigatorKey,
    theme: ThemeData(
      // This is the theme of your application.
      primarySwatch: primarySwatch,
      primaryColor: primaryColor,
      backgroundColor: primaryTextColor,
      appBarTheme: AppBarTheme(
          color: primaryColor,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: primaryTextColor)
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: primaryColor,
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
    ),
    home: FutureBuilder(
      future: Provider.of<AuthService>(context).getUserForLaunch(),
      builder: (context, AsyncSnapshot snapshot){
        return Routers.landing(snapshot);
      },
    ),
    onGenerateRoute: (settings){
      return Routers.generatedRoutes(settings);
    },
    onUnknownRoute: Routers.unKnownRoute,
    routes: Routers.routes(),
  );
}