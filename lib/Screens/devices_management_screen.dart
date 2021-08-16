import 'package:booking_app/Screens/add_device.dart';
import 'package:booking_app/Screens/edit_device_screen.dart';
import 'package:booking_app/models/search_models/search_devices.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesManagementScreen extends StatelessWidget {
  Future<void> deleteDevice(
      MainProvider value, String id, BuildContext context) async {
    try {
      await value.deleteDevice(id).then((value) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The device has been deleted')));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Occurred error!... try again')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Devices Management'),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () =>
                    showSearch(context: context, delegate: SearchDevices()))
          ],
        ),
        body: Consumer<MainProvider>(
          builder: (context, valueMain, child) => ListView.separated(
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) => Container(
              height: 200,
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EditDeviceScreen(
                        deviceId: valueMain.allDevicesList[index].id))),
                child: DeviceItemView(
                    imageUrl: valueMain.allDevicesList[index].imageUrl,
                    name: valueMain.allDevicesList[index].name,
                    model: valueMain.allDevicesList[index].model,
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => showDialog(
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
                                            await deleteDevice(
                                                value,
                                                value.allDevicesList[index].id,
                                                context),
                                        child: Text('Yes')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            itemCount: valueMain.allDevicesList.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddDeviceScreen(),
            ));
          },
          child: Icon(Icons.add),
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
