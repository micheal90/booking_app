import 'package:booking_app/constants.dart';
import 'package:booking_app/widgets_model/custom_container_device_details.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:booking_app/models/device_model.dart';

class DeviceDetailsScreen extends StatelessWidget {
  final DeviceModel deviceModel;
  DeviceDetailsScreen({
    Key? key,
    required this.deviceModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              deviceModel.name,
              style: TextStyle(
                  color: Colors.white, backgroundColor: Colors.black45),
            ),
            background: FadeInImage(
              placeholder: AssetImage('assets/images/loading.png'),
              image: NetworkImage(deviceModel.imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomContainerDeviceDetail(
                  title: 'Type',
                  detail: deviceModel.type.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Model',
                  detail: deviceModel.model.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'OS',
                  detail: deviceModel.os.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Screen Size',
                  detail: deviceModel.screenSize.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Battery',
                  detail: deviceModel.battery.toUpperCase(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: CustomElevatedButton(
                    text: 'Booked',
                  ),
                )
              ],
            ),
          )
        ]))
      ],
    ));
  }
}
