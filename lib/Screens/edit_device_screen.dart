import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:booking_app/constants.dart';
import 'package:booking_app/models/device_model.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';

class EditDeviceScreen extends StatefulWidget {
  final String deviceId;
  EditDeviceScreen({
    Key? key,
    required this.deviceId,
  }) : super(key: key);

  @override
  _EditDeviceScreenState createState() => _EditDeviceScreenState();
}

class _EditDeviceScreenState extends State<EditDeviceScreen> {
  bool isLoading = false;
  TextEditingController? nameController = TextEditingController();
  TextEditingController? modelController = TextEditingController();
  TextEditingController? osController = TextEditingController();
  TextEditingController? screenSizeController = TextEditingController();
  TextEditingController? batteryController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  DeviceModel? deviceModel;
  List<String> categoryTypeList = ['ANDROID', 'IOS', 'PC', 'OTHERS'];
  String categoryType = '';

  @override
  void initState() {
    deviceModel = Provider.of<MainProvider>(context, listen: false)
        .findDeviceById(widget.deviceId);
    nameController!.text = deviceModel!.name;
    modelController!.text = deviceModel!.model;
    osController!.text = deviceModel!.os;
    screenSizeController!.text = deviceModel!.screenSize;
    batteryController!.text = deviceModel!.battery;
    categoryType = deviceModel!.type;
    super.initState();
  }

  void changeType(String type) {
    setState(() {
      categoryType = type;
    });
  }

  void update(BuildContext context, MainProvider value) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (deviceModel!.imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('At least one image should be added')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await value.updateDevice(
        deviceId: deviceModel!.id,
        deviceName: nameController!.text.trim(),
        modNum: modelController!.text.trim(),
        os: osController!.text.trim(),
        isBooked: deviceModel!.isBooked,
        imageUrl: deviceModel!.imageUrl,
        type: categoryType,
        screenSize: screenSizeController!.text.trim(),
        battery: batteryController!.text.trim(),
      );
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Device updated')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    nameController!.clear();
    modelController!.clear();
    osController!.clear();
    screenSizeController!.clear();
    batteryController!.clear();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteDevice(MainProvider value, BuildContext context) async {
    try {
      await value.deleteDevice(deviceModel!.id).then((value) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The device has been deleted')));
      }).then((value) => Navigator.of(context).pop());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Occurred error!... try again')));
    }
  }

  void deleteImage(int index) async {
    if (deviceModel!.imageUrl.length > 0) {
      //store imageUrl in list for deleted from fireStorage after update device
      Provider.of<MainProvider>(context, listen: false)
          .selectedImageUrlDeleted
          .add(deviceModel!.imageUrl[index]);

      //remove image localy
      setState(() {
        deviceModel!.imageUrl.removeAt(index);
      });
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => Consumer<MainProvider>(
            builder: (context, valueMain, child) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to discard the changes'),
              actions: [
                valueMain.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: new Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await valueMain.fetchDataAfterCheck();
                              valueMain.selectedImages.clear();
                              Navigator.of(context).pop(true);
                            },
                            child: new Text('Yes'),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Device"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: CustomText(
                          text: 'Are you sure!',
                        ),
                        content: Consumer<MainProvider>(
                          builder: (context, value, child) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: ' device delete',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () async =>
                                          await deleteDevice(value, context),
                                      child: Text('Yes')),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete_outline)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Consumer<MainProvider>(
                builder: (context, valueMain, child) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Stack(
                                  children: [
                                    deviceModel!.imageUrl.first.isEmpty
                                        ? Container()
                                        : Container(
                                            height: 140,
                                            width: 140,
                                            child: Image.network(
                                              deviceModel!.imageUrl[index],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          color: Colors.red.shade500,
                                          icon: Icon(
                                            Icons.cancel_outlined,
                                          ),
                                          onPressed: () => deleteImage(index)),
                                    )
                                  ],
                                ),
                              ),
                          itemCount: deviceModel!.imageUrl.length),
                    ),
                    SizedBox(height: 15),
                    CustomText(
                      text: 'Select the type:',
                    ),
                    DropdownButton<String>(
                      value: categoryType,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style:
                          const TextStyle(color: KPrimaryColor, fontSize: 18),
                      underline: Container(height: 2, color: Colors.black45),
                      onChanged: (String? newValue) {
                        changeType(newValue!);
                      },
                      items: categoryTypeList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    CustomAddTextFormField(
                      controller: nameController,
                      //initialValue: widget.deviceModel.name,
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
                      controller: modelController,
                      //initialValue: widget.deviceModel.model,
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
                      controller: osController,
                      //initialValue: widget.deviceModel.os,
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
                      controller: screenSizeController,
                      // initialValue: widget.deviceModel.screenSize,
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
                      controller: batteryController,
                      //initialValue: widget.deviceModel.battery,
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
                      height: 200,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () async {
                                await Provider.of<MainProvider>(context,
                                        listen: false)
                                    .pickImages();
                              },
                              child: CustomText(
                                text: 'Add Image',
                                color: KPrimaryColor,
                                alignment: Alignment.center,
                              )),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              children: List.generate(
                                  valueMain.selectedImages.length, (index) {
                                File file = valueMain.selectedImages[index];
                                return Image.file(
                                  file,
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.fill,
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : CustomElevatedButton(
                            text: 'Update',
                            onPressed: () => update(context, valueMain),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
