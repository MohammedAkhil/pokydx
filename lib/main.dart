import 'package:Pokydx/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  debugPaintSizeEnabled = false;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1e1e1e),
      systemNavigationBarColor: Colors.white12,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(PokeFlutter());
}

class PokeFlutter extends StatefulWidget {
  @override
  _PokeFlutterState createState() => _PokeFlutterState();
}

class _PokeFlutterState extends State<PokeFlutter> {
  bool isDarkMode = true;

  final ThemeData themeLight = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      accentColor: Colors.red,
      cardColor: Color(0xfff3f2f7),
      fontFamily: 'Jost',
      textTheme: lightTextTheme);

  final ThemeData themeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white12,
    cardColor: Colors.black38,
    appBarTheme: AppBarTheme(color: Color(0xff1e1e1e), elevation: 0),
    accentColor: Colors.red,
    fontFamily: 'Jost',
    textTheme: darkTextTheme,
  );

  static final TextTheme lightTextTheme = TextTheme(
      headline: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.black87),
      title: TextStyle(
          color: Colors.black54, fontSize: 28, fontWeight: FontWeight.w500),
      subtitle: TextStyle(
          fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w500),
      body1: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
      body2: TextStyle(
          fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
      display1: TextStyle(fontSize: 32, color: Colors.black54),
      caption: TextStyle(fontSize: 20, color: Colors.black45));

  static final TextTheme darkTextTheme = TextTheme(
      headline: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.white70),
      title: TextStyle(
          color: Colors.white54, fontSize: 28, fontWeight: FontWeight.w500),
      subtitle: TextStyle(
          fontSize: 20, color: Colors.white54, fontWeight: FontWeight.w500),
      body1: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white70),
      body2: TextStyle(
          fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w500),
      display1: TextStyle(fontSize: 32, color: Colors.white54),
      caption: TextStyle(fontSize: 20, color: Colors.white54));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokydx',
      theme: isDarkMode ? themeDark : themeLight,
      home: Home(
        modifyTheme: modifyTheme,
      ),
    );
  }

  void modifyTheme() {
    updateState();
  }

  void updateState() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode ? Color(0xff1e1e1e) : Colors.white,
        systemNavigationBarColor: isDarkMode ? Colors.white12 : Colors.white,
        systemNavigationBarDividerColor:
            isDarkMode ? Colors.white : Colors.white12,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
