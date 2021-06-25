import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:booking_app/models/device_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookDeviceScreen extends StatelessWidget {
  final DeviceModel deviceModel;
  const BookDeviceScreen({
    Key? key,
    required this.deviceModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Device'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(
            children: [
              Container(
                  height: 275,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    deviceModel.imageUrl[0],
                    fit: BoxFit.fill,
                  )),
              
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomText(
                      text: deviceModel.name,
                      fontSize: 20,
                      color: KPrimaryColor,
                    ),
                    CustomText(
                      text: 'Type: ' + deviceModel.type,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'Model: ' + deviceModel.model,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'OS: ' + deviceModel.os,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'ScreenSize: ' + deviceModel.screenSize,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'Battery: ' + deviceModel.battery,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      onPressed: () => showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2050))
                          .then((date) => value.changeStartDateTime(date!)),
                      icon: Icon(Icons.date_range),
                      label: CustomText(
                        text: 'From',
                      )),
                  CustomText(
                      color: KPrimaryColor,
                      text: value.startDateTime == null
                          ? ''
                          : DateFormat()
                              .add_yMMMMEEEEd()
                              .format(value.startDateTime!)
                              .toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      onPressed: () => showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2050))
                          .then((date) => value.changeEndDateTime(date!)),
                      icon: Icon(Icons.date_range),
                      label: CustomText(
                        text: 'To',
                      )),
                  CustomText(
                      color: KPrimaryColor,
                      text: value.endDateTime == null
                          ? ''
                          : DateFormat()
                              .add_yMMMMEEEEd()
                              .format(value.endDateTime!)
                              .toString())
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                text: 'Booke',
              )
            ],
          ),
        ),
      ),
    );
  }
}
