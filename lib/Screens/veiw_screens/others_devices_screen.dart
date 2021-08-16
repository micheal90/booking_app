import 'package:booking_app/Screens/veiw_screens/device_details_screen.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OthersDevicesScreen extends StatefulWidget {
  @override
  _OthersDevicesScreenState createState() => _OthersDevicesScreenState();
}

class _OthersDevicesScreenState extends State<OthersDevicesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Others Devices"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<MainProvider>(
          builder: (context, valueMain, child) => valueMain.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : valueMain.othersDevicesList.isEmpty
                  ? Center(
                      child: CustomText(
                        text: 'No devices',
                        alignment: Alignment.center,
                        fontSize: 22,
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 200,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => DeviceDetailsScreen(
                                    deviceId: valueMain
                                        .othersDevicesList[index].id))),
                        child: DeviceItemView(
                            imageUrl:
                                valueMain.othersDevicesList[index].imageUrl,
                            name: valueMain.othersDevicesList[index].name,
                            model: valueMain.othersDevicesList[index].model),
                      ),
                      itemCount: valueMain.othersDevicesList.length,
                    ),
        ),
      ),
    );
  }
}
