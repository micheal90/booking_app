import 'package:booking_app/Screens/add_employee_screen.dart';
import 'package:booking_app/Screens/add_device.dart';
import 'package:booking_app/Screens/veiw_screens/device_details_screen.dart';
import 'package:booking_app/Screens/veiw_screens/android_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/ios_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/pc_devices_screen.dart';
import 'package:booking_app/constants.dart';
import 'package:booking_app/models/category_model.dart';
import 'package:booking_app/models/device_model.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/custom_list_tile.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:booking_app/widgets_model/gatecory_widget.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CatergoryModel> categories = [
    CatergoryModel(
        name: 'Android', imagUrl: 'assets/images/category/android-96.png'),
    CatergoryModel(name: 'IOS', imagUrl: 'assets/images/category/ios-96.png'),
    CatergoryModel(name: 'PC', imagUrl: 'assets/images/category/laptop-96.png'),
  ];
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).filterDevices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Booking App"),
          centerTitle: true,
        ),
        body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                CustomText(
        text: 'Categories',
        fontSize: 18,
        fontWeight: FontWeight.bold,
                ),
                SizedBox(
        height: 15,
                ),
                Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AndroidDevicesScreen())),
            child: CategoryWidget(
              text: categories[0].name,
              imageUrl: categories[0].imagUrl,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IosDevicesScreen())),
            child: CategoryWidget(
              text: categories[1].name,
              imageUrl: categories[1].imagUrl,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PcDevicesScreen())),
            child: CategoryWidget(
              text: categories[2].name,
              imageUrl: categories[2].imagUrl,
            ),
          ),
        ],
                ),
                SizedBox(
        height: 15,
                ),
                CustomText(
        text: 'Recent Add',
        fontSize: 18,
        fontWeight: FontWeight.bold,
                ),
                SizedBox(
        height: 15,
                ),
                Expanded(
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  //mainAxisExtent: 200,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DeviceDetailsScreen(
            deviceModel: value.devicesNotBookedList[index]))),
                child: DeviceItemView(
                    imageUrl:
            value.devicesNotBookedList[index].imageUrl[0],
                    name: value.devicesNotBookedList[index].name,
                    screenSize:
            value.devicesNotBookedList[index].screenSize),
              ),
              itemCount: value.devicesNotBookedList.length,
            ),
        ),
                )
              ])),
        drawer: MainDrawer());
  }
}
