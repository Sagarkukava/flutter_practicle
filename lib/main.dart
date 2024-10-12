
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical_task/res/components/Constants.dart';
import 'package:practical_task/utils/routs/routes.dart';
import 'package:practical_task/utils/routs/routes_name.dart';
import 'package:practical_task/view_model/add_contact_view_model.dart';
import 'package:practical_task/view_model/admin_view_model.dart';
import 'package:practical_task/view_model/contact_details_view_model.dart';
import 'package:practical_task/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Constants.initSharedPreferences();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AdminViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => ContactDetailsViewModel()),
          ChangeNotifierProvider(create: (_) => AddContactViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RoutesName.Splesh,
          onGenerateRoute: Routes.generateRoutes,
        ));
  }
}
