import 'package:booking_app/Screens/search_screens/search_devices.dart';
import 'package:booking_app/Screens/veiw_screens/device_details_screen.dart';
import 'package:booking_app/Screens/veiw_screens/android_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/ios_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/others_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/pc_devices_screen.dart';

import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:booking_app/widgets_model/gatecory_widget.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController? searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Consumer<MainProvider>(
        builder: (context, valueMain, child) => Scaffold(
          appBar: AppBar(
            title: Text("Booking App"),
            actions: [
              IconButton(
                  onPressed: () =>showSearch(context: context, delegate: SearchDevices()), icon: Icon(Icons.search))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async => await valueMain.refresh(),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Categories',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      // GestureDetector(
                      //   onTap: () =>
                      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => CategoriesManagementScreen(),
                      //   )),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 5),
                      //     child: CustomText(
                      //       text: 'Edit',
                      //       color: KPrimaryColor,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildRowCategories(context, valueMain),
                  //const SizedBox(
                  //   height: 15,
                  // ),
                  CustomText(
                    text: 'Recent Add',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  valueMain.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : buildGridDevices(valueMain)
                ])),
          ),
          drawer: MainDrawer(),
        ),
      ),
    );
  }

  Container buildRowCategories(BuildContext context, MainProvider valueMain) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AndroidDevicesScreen())),
            child: CategoryWidget(
              text: valueMain.categories[0].name,
              imageUrl: valueMain.categories[0].imageUrl,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => IosDevicesScreen())),
            child: CategoryWidget(
              text: valueMain.categories[1].name,
              imageUrl: valueMain.categories[1].imageUrl,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PcDevicesScreen())),
            child: CategoryWidget(
              text: valueMain.categories[2].name,
              imageUrl: valueMain.categories[2].imageUrl,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OthersDevicesScreen())),
            child: CategoryWidget(
              text: valueMain.categories[3].name,
              imageUrl: valueMain.categories[3].imageUrl,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridDevices(MainProvider valueMain) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          //mainAxisExtent: 200,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => searchController!.text.isNotEmpty
          ? GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DeviceDetailsScreen(
                      deviceId: valueMain.searchList[index].id))),
              child: DeviceItemView(
                  imageUrl: valueMain.searchList[index].imageUrl,
                  name: valueMain.searchList[index].name,
                  model: valueMain.searchList[index].model),
            )
          : GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DeviceDetailsScreen(
                      deviceId: valueMain.devicesNotBookedList[index].id))),
              child: DeviceItemView(
                  imageUrl: valueMain.devicesNotBookedList[index].imageUrl,
                  name: valueMain.devicesNotBookedList[index].name,
                  model: valueMain.devicesNotBookedList[index].model),
            ),
      itemCount: searchController!.text.isNotEmpty
          ? valueMain.searchList.length
          : valueMain.devicesNotBookedList.length,
    );
  }

  ListView buildListViewCatigories(MainProvider value) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AndroidDevicesScreen())),
              child: CategoryWidget(
                text: value.categories[index].name,
                imageUrl: value.categories[index].imageUrl,
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(
            width: MediaQuery.of(context).size.width / value.categories.length -
                20),
        itemCount: value.categories.length);
  }
}
