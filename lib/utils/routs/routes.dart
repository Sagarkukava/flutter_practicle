
import 'package:flutter/material.dart';
import 'package:practical_task/utils/routs/routes_name.dart';
import 'package:practical_task/view/add_contact_screen.dart';
import 'package:practical_task/view/contact_screen.dart';
import 'package:practical_task/view/home_screen.dart';
import 'package:practical_task/view/login_screen.dart';
import 'package:practical_task/view/splash_screen.dart';


class Routes {

  static Route<dynamic> generateRoutes(RouteSettings settings){

    switch(settings.name){
      case RoutesName.Splesh:
        return MaterialPageRoute(builder: (BuildContext context) => const SpleshScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesName.contact:
        final userId = settings.arguments as String;
        return MaterialPageRoute(builder: (BuildContext context) => ContactScreen(userId: userId,));
      case RoutesName.addContact:
        return MaterialPageRoute(builder: (BuildContext context) => const AddContactScreen());
      default :
        return MaterialPageRoute(builder: (_){
          return
              Scaffold(
                body: Center(
                  child: Text("No routes defined"),
                ),
              );
        });
    }
  }
}