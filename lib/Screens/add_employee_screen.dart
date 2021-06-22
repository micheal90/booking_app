import 'dart:io';

import 'package:booking_app/constants.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeeScreen extends StatelessWidget {
  final picker = ImagePicker();
  late File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
            
              Stack(clipBehavior: Clip.none, children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      //check if image not equal null to show image saved in db
                      backgroundImage: AssetImage('assets/images/profile.png')),
                ),
                Positioned(
                  bottom: -5,
                  right: -10,
                  child: Container(
                      //padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(40)),
                      child: IconButton(
                        onPressed: () {
                          pickedDialog(context);
                        },
                        icon: Icon(Icons.edit),
                      )),
                )
              ]),
              SizedBox(height: 15,),
              CustomAddTextFormField(
                label: 'Name',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Last Name',
                onSave: (value) {},
                validator: (value) {},
              ),
               SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Occupation Group',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Email',
                onSave: (value) {},
                validator: (value) {},
              ),
             SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'password',
                onSave: (value) {},
                validator: (value) {},
              ),
               SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Phone',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(text: 'Add',)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> pickedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Choose the profile image'),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.camera,
                        color: KPrimaryColor,
                      ),
                      title: Text('From Camera'),
                      onTap: () async {
                        await pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: KPrimaryColor,
                      ),
                      title: Text('From Gallery'),
                      onTap: () async {
                        await pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      //save imagefile in db
    } else {
      print('No image selected.');
    }
  }
}
