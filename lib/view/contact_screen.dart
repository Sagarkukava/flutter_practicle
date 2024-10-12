import 'package:flutter/material.dart';
import 'package:practical_task/data/response/status.dart';
import 'package:practical_task/res/components/Constants.dart';
import 'package:practical_task/view_model/contact_details_view_model.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  final String userId;

  const ContactScreen({super.key, required this.userId});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  ContactDetailsViewModel contactDetailsViewModel = ContactDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userId);
    contactDetailsViewModel.ContactDetailsApi(Constants.token,widget.userId,context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Contact Details")),
      ),
      body: ChangeNotifierProvider<ContactDetailsViewModel>.value(
        value:  contactDetailsViewModel,
        child: Consumer<ContactDetailsViewModel>(
            builder: (context, value, _){
              switch(value.contactdetails.status){
                case Status.LODING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Text(value.contactdetails.message.toString());
                case Status.COMPLATED:
                 // List<dynamic>? data = value.contactlist.data!.data;
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                              Text(value.contactdetails.data?.data?.firstName ?? 'No firstName'),
                              SizedBox(width: 10,),
                              Text(value.contactdetails.data?.data?.lastName ?? 'No lastName'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              Text(value.contactdetails.data?.data?.mobile ?? 'No mobile')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.email),
                              Text(value.contactdetails.data?.data?.email ?? 'No email')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text(
                                value.contactdetails.data?.data?.addresses?.isNotEmpty == true
                                    ? value.contactdetails.data?.data?.addresses![0].addressLine1 ?? 'No address line'
                                    : 'No addresses',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text(
                                value.contactdetails.data?.data?.addresses?.isNotEmpty == true
                                    ? value.contactdetails.data?.data?.addresses![0].city ?? 'No city'
                                    : 'No city',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                case null:
                  return Container();
              }
            }),
      ),
    );
  }
}
