
import 'package:charts_example/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_controller.dart';
import 'home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // animated builder listens to the app controller, when the change theme color changes
    // it notifies it's parents (App) and it reloads the application with the new brightness
    return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child){
          return MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.indigo,
                  brightness: AppController.instance.isDarkTheme?
                  Brightness.dark : Brightness.light
              ),
              initialRoute: '/login',
              routes: {
                '/login': (context) => LoginPage(),
                '/home': (context) => HomePage(),
              }
          );
        }
    );
  }
}
