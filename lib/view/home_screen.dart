import 'package:flutter/material.dart';
import 'package:practical_task/data/response/status.dart';
import 'package:practical_task/res/components/Constants.dart';
import 'package:practical_task/utils/routs/routes_name.dart';
import 'package:practical_task/view_model/home_view_model.dart';
import 'package:practical_task/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.ContactListApi(Constants.token, context);
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece =  Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Contact list")),
        actions: [
          InkWell(
            onTap: (){
              Constants.clearData();
              userPrefernece.remove().then((value){
                Navigator.pushReplacementNamed(context, RoutesName.login);
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.logout_outlined),
            ),
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>.value(
       value:  homeViewModel,
        child: Consumer<HomeViewModel>(
            builder: (context, value, _){
              switch(value.contactlist.status){
                case Status.LODING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Text(value.contactlist.message.toString());
                case Status.COMPLATED:
                 List<dynamic>? data = value.contactlist.data!.data;
                  return ListView.builder(
                    itemCount: value.contactlist.data!.data!.length,
                      itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              final userId = data[index].id.toString();
                              Navigator.pushNamed(context, RoutesName.contact,arguments: userId);
                            },
                            child: Card(
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(Icons.person),
                                      Text(data![index].firstName.toString()),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                    child: Text(data[index].mobile.toString()),
                                  ),
                                )
                            ),
                          );
                      }
                  );
                case null:
                  return Container();
              }
              // return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.addContact);
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
