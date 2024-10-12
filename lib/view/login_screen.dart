import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_task/utils/utils.dart';
import 'package:practical_task/view_model/admin_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  ValueNotifier<bool> _obsecurepassword = ValueNotifier(true);

  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final adminviewmodel = Provider.of<AdminViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: mobileNoController,
                focusNode: mobileNoFocusNode,
                decoration: InputDecoration(
                  hintText: "Mobile",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)
                  ),
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldFocuschange(
                      context, mobileNoFocusNode, passwordFocusNode);
                },
                // obscureText: isPassword,
              ),
              SizedBox(height: height * .01),
              ValueListenableBuilder(
                  valueListenable: _obsecurepassword,
                  builder: (context, value, child){
                    return TextField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: _obsecurepassword.value,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: InkWell(
                            onTap: (){
                              _obsecurepassword.value = !_obsecurepassword.value;
                            },
                            child: Icon(
                              _obsecurepassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)
                        ),
                      ),
                    );
                  }),
              SizedBox(height: height * .03),
              ElevatedButton(
                onPressed: () {
                  if(mobileNoController.text.isEmpty){
                    Utils.flushbarErrormessage("Please enter username", context);
                  }else if(passwordController.text.isEmpty){
                    Utils.flushbarErrormessage("Please enter password", context);
                  }else{
                    Map data ={
                      'mobile': mobileNoController.text.toString(),
                      'password': passwordController.text.toString()
                    };
                    adminviewmodel.loginApi(data, context);
                  }
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Login ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
