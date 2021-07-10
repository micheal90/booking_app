import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _modelController = TextEditingController();

  TextEditingController _osController = TextEditingController();

  TextEditingController _screenSizeController = TextEditingController();

  TextEditingController _batteryController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;

  void add(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    Provider.of<MainProvider>(context, listen: false)
        .addDevice(
            deviceName: _nameController.text.trim(),
            modNum: _modelController.text.trim(),
            os: _osController.text.trim(),
            screenSize: _screenSizeController.text.trim(),
            battery: _batteryController.text.trim())
        .then((value) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Device added')));
    });
    setState(() {
      isLoading = false;
    });
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Select the type:',
                ),
                Consumer<MainProvider>(
                    builder: (context, value, child) => DropdownButton<String>(
                          value: value.categoryType,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: KPrimaryColor, fontSize: 18),
                          underline:
                              Container(height: 2, color: Colors.black45),
                          onChanged: (String? newValue) {
                            value.changeType(newValue!);
                          },
                          items: value.categoryTypeList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),

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
                  controller: _nameController,
                  label: 'Device Name',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter device name';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _modelController,
                  label: 'Model Number',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter model number';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _osController,
                  label: 'Operating System',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter operating system';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _screenSizeController,
                  label: 'Screen Size',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter screen size';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _batteryController,
                  label: 'Battery',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter battery';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 175,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Consumer<MainProvider>(
                    builder: (context, value, child) => Column(
                      children: [
                        TextButton(
                            onPressed: () async {
                              await Provider.of<MainProvider>(context,
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
                isLoading
                    ? CircularProgressIndicator()
                    : CustomElevatedButton(
                        text: 'Add',
                        onPressed: () => add(context),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
