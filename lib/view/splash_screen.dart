
import 'package:flutter/material.dart';
import 'package:practical_task/view_model/services/splesh_services.dart';


class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {

  SpleshServices spleshServices = SpleshServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spleshServices.checkauthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text('WELCOME' , style: TextStyle(color: Colors.blue,fontSize: 75, fontWeight: FontWeight.w700),)),
      ],
    )
    );
  }
}
