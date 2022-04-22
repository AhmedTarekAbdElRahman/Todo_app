import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightMode = ThemeData(
  primarySwatch:defaultColor,
  appBarTheme:AppBarTheme(
      titleSpacing: 20.0,
      iconTheme:IconThemeData(
          color: Colors.black
      ) ,
      backgroundColor: Colors.white,
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      elevation: 20.0,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight:FontWeight.w600,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 16.0,
        fontWeight:FontWeight.w600,
        color: Colors.black,
      )
  ),
  fontFamily: 'Jannah',
);


ThemeData darkMode = ThemeData(
  primarySwatch: defaultColor,
  appBarTheme:AppBarTheme(
      titleSpacing: 20.0,
      iconTheme:IconThemeData(
          color: Colors.white
      ) ,
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight:FontWeight.w600,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontSize: 16.0,
        fontWeight:FontWeight.w600,
        color: Colors.white,
      )
  ),
  scaffoldBackgroundColor:HexColor('333739') ,
  fontFamily: 'Jannah',
);