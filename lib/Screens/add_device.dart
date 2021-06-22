import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

class AddDeviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Device"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Select the type:',
              ),
              Consumer<HomeProvider>(
                builder: (context, value, child) => Row(
                  children: [
                    Radio(
                      value: CategoryType.Android,
                      groupValue: value.categoryType,
                      onChanged: (CategoryType? type) =>
                          value.changeType(type!),
                    ),
                    CustomText(
                      text: 'Android',
                    ),
                    Radio(
                      value: CategoryType.IOS,
                      groupValue: value.categoryType,
                      onChanged: (CategoryType? type) =>
                          value.changeType(type!),
                    ),
                    CustomText(
                      text: 'IOS',
                    ),
                    Radio(
                      value: CategoryType.PC,
                      groupValue: value.categoryType,
                      onChanged: (CategoryType? type) =>
                          value.changeType(type!),
                    ),
                    CustomText(
                      text: 'PC',
                    )
                  ],
                ),
              ),

              // RadioListTile(
              //   title: CustomText(
              //     text: 'Android',
              //   ),
              //   value: CategoryType.Android,
              //   groupValue: categoryType,
              //   onChanged: (CategoryType? type) => changeType(type!),
              // ),
              // RadioListTile(
              //   title: CustomText(
              //     text: 'IOS',
              //   ),
              //   value: CategoryType.IOS,
              //   groupValue: categoryType,
              //   onChanged: (CategoryType? type) => changeType(type!),
              // ),
              // RadioListTile(
              //   title: CustomText(
              //     text: 'PC',
              //   ),
              //   value: CategoryType.PC,
              //   groupValue: categoryType,
              //   onChanged: (CategoryType? type) => changeType(type!),
              // ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Device Name',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Model Number',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Operating System',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Screen Size',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                label: 'Battery',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: Consumer<HomeProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await Provider.of<HomeProvider>(context,
                                    listen: false)
                                .loadAssets();
                          },
                          child: CustomText(
                            text: 'Add Image',
                            color: KPrimaryColor,
                            alignment: Alignment.center,
                          )),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(value.selectedImages.length,
                              (index) {
                            Asset asset = value.selectedImages[index];
                            return AssetThumb(
                              asset: asset,
                              width: 300,
                              height: 300,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                text: 'Add',
              )
            ],
          ),
        ),
      ),
    );
  }
}
