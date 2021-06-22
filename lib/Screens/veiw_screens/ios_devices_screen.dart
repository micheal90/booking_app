import 'package:booking_app/Screens/veiw_screens/device_details_screen.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IosDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IOS Devices"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisExtent: 200,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => DeviceDetailsScreen(
                              deviceModel: value.iosDevicesList[index]))),
                          child: DeviceItemView(
                  imageUrl: value.iosDevicesList[index].imageUrl,
                  name: value.iosDevicesList[index].name,
                  screenSize: value.iosDevicesList[index].screenSize),
            ),
            itemCount: value.iosDevicesList.length,
          ),
        ),
      ),
    );
  }
}
