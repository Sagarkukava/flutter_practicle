import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practical_task/res/components/Constants.dart';
import 'package:practical_task/view_model/add_contact_view_model.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController contactTypes = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController contryIdController = TextEditingController();
  final TextEditingController stateIdController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  String? profileImagePath;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    contactTypes.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    landmarkController.dispose();
    contryIdController.dispose();
    stateIdController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          profileImagePath = image.path;
        });
      }
    } catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Widget buildTextField(
      {required TextEditingController controller, required String label, TextInputType? keyboardType, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    final addContactViewModel = Provider.of<AddContactViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Contact"),
        actions: [
          InkWell(
            onTap: () {
              if (formKey.currentState!.validate()) {
                Map<String, dynamic> data = {
                  "first_name": firstNameController.text,
                  "last_name": lastNameController.text,
                  "email": emailController.text,
                  "mobile": mobileController.text,
                  "profile": profileImagePath ?? "",
                  "contact_types": [
                    {"id": contactTypes.text}
                  ],
                  "addresses": [
                    {
                      "address_line_1": addressLine1Controller.text,
                      "address_line_2": addressLine2Controller.text,
                      "landmark": landmarkController.text,
                      "country_id": contryIdController.text,
                      "state_id": stateIdController.text,
                      "city": cityController.text,
                      "pincode": pincodeController.text,
                      "is_default": 1
                    }
                  ]
                };
                addContactViewModel.addContactApi(data, Constants.token, context);
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("Save"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImagePath != null ? FileImage(File(profileImagePath!)) : null,
                    child: profileImagePath == null ? Icon(Icons.camera_alt, size: 50) : null,
                  ),
                ),
                SizedBox(height: 16),
                buildTextField(
                  controller: firstNameController,
                  label: 'First Name',
                  validator: (value) => value == null || value.isEmpty ? 'Please enter first name' : null,
                ),
                buildTextField(
                  controller: lastNameController,
                  label: 'Last Name',
                  validator: (value) => value == null || value.isEmpty ? 'Please enter last name' : null,
                ),
                buildTextField(
                  controller: emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter email' : null,
                ),
                buildTextField(
                  controller: mobileController,
                  label: 'Mobile Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter mobile number' : null,
                ),
                buildTextField(
                  controller: contactTypes,
                  label: 'Contact Types',
                  validator: (value) => value == null || value.isEmpty ? 'Please enter contact type' : null,
                ),
                buildTextField(
                  controller: addressLine1Controller,
                  label: 'Address Line 1',
                  validator: (value) => value == null || value.isEmpty ? 'Please enter address' : null,
                ),
                buildTextField(
                  controller: addressLine2Controller,
                  label: 'Address Line 2',
                  validator: (value) => value == null || value.isEmpty ? 'Please enter address' : null,
                ),
                buildTextField(
                  controller: landmarkController,
                  label: 'Landmark',
                  validator: (value) => value == null || value.isEmpty ? 'Please enter landmark' : null,
                ),
                buildTextField(
                  controller: contryIdController,
                  label: 'Country ID',
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter country id' : null,
                ),
                buildTextField(
                  controller: stateIdController,
                  label: 'State ID',
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter state id' : null,
                ),
                buildTextField(
                  controller: cityController,
                  label: 'City',
                  validator: (value) => value == null || value.isEmpty ? 'Please enter city' : null,
                ),
                buildTextField(
                  controller: pincodeController,
                  label: 'Pincode',
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a pincode' : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
