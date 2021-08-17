import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
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
  List<String> categoryTypeList = ['ANDROID', 'IOS', 'PC', 'OTHERS'];
  String categoryType = 'ANDROID';

  void changeType(String type) {
   setState(() {
      categoryType = type;
   });
  }

  void addDevice(BuildContext context, MainProvider value) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    try {
      await value.addDevice(
          deviceName: _nameController.text.trim(),
          modNum: _modelController.text.trim(),
          os: _osController.text.trim(),
          type: categoryType,
          screenSize: _screenSizeController.text.trim(),
          battery: _batteryController.text.trim());

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Device added')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Device"),
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
                  CustomText(
                    text: 'Select the type:',
                  ),
                  DropdownButton<String>(
                    value:categoryType,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: KPrimaryColor, fontSize: 18),
                    underline: Container(height: 2, color: Colors.black45),
                    onChanged: (String? newValue) {
                      changeType(newValue!);
                    },
                    items:categoryTypeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
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
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () async => await valueMain.pickImages(),
                            child: CustomText(
                              text: 'Add Image',
                              color: KPrimaryColor,
                              alignment: Alignment.center,
                            )),
                        // Expanded(
                        //   child: GridView.count(
                        //     crossAxisCount: 3,
                        //     children: List.generate(
                        //         valueMain.selectedImages.length, (index) {
                        //       Asset asset = valueMain.selectedImages[index];
                        //       return AssetThumb(
                        //         asset: asset,
                        //         width: 300,
                        //         height: 300,
                        //       );
                        //     }),
                        //   ),
                        // ),
                        Expanded(
                            child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: valueMain.selectedImages.length,
                          itemBuilder: (context, index) =>
                              Image.file(valueMain.selectedImages[index]),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 5,
                          ),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                          text: 'Add',
                          onPressed: () => addDevice(context, valueMain),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
