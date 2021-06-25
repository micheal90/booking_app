import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

import 'package:booking_app/constants.dart';
import 'package:booking_app/models/device_model.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';

class EditDeviceScreen extends StatelessWidget {
  final DeviceModel deviceModel;
  const EditDeviceScreen({
    Key? key,
    required this.deviceModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Device"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<HomeProvider>(context, listen: false)
                    .deleteDevice();
              },
              icon: Icon(Icons.delete_outline))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAddTextFormField(
                initialValue: deviceModel.name,
                label: 'Device Name',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                initialValue: deviceModel.model,
                label: 'Model Number',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                initialValue: deviceModel.os,
                label: 'Operating System',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                initialValue: deviceModel.screenSize,
                label: 'Screen Size',
                onSave: (value) {},
                validator: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomAddTextFormField(
                initialValue: deviceModel.battery,
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
                text: 'Update',
                onPressed: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .updateDevice();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
