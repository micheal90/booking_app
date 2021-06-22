import 'package:booking_app/Screens/edit_device_screen.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesManagementScreen extends StatelessWidget {
  const DevicesManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reserved Devices'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) => ListView.separated(
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) => Dismissible(
            background: Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                size: 35,
              ),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                size: 35,
              ),
            ),
            onDismissed: (direction) {
              //delete the device from database
              print('the device is deleted');
            },
            key: UniqueKey(),
            child: Container(
              height: 200,
              width: double.infinity,
              child: GestureDetector(
                onTap: () =>Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => EditDeviceScreen(
                              deviceModel: value.allDevicesList[index]))),
                              child: DeviceItemView(
                    imageUrl: value.allDevicesList[index].imageUrl[0],
                    name: value.allDevicesList[index].name,
                    screenSize: value.allDevicesList[index].screenSize),
              ),
            ),
          ),
          itemCount: value.allDevicesList.length,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
