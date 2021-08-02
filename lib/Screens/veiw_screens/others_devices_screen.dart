import 'package:booking_app/Screens/veiw_screens/device_details_screen.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OthersDevicesScreen extends StatefulWidget {
  @override
  _OthersDevicesScreenState createState() => _OthersDevicesScreenState();
}

class _OthersDevicesScreenState extends State<OthersDevicesScreen> {
  bool _isSearch = false;
  TextEditingController? searchController = TextEditingController();
  // List<DeviceModel> searchList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearch
            ? Consumer<MainProvider>(
                builder: (context, value, child) => TextField(
                  autofocus: true,
                  controller: searchController,
                  onChanged: (val) {
                    setState(() {
                      value.searchList = value.othersDevicesList
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(val.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: " Search...",
                      border: InputBorder.none,
                      // errorBorder: InputBorder.none,
                      //focusedBorder: InputBorder.none,
                      //enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)),
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Text("Others Devices"),
        actions: [
          IconButton(
              icon:
                  _isSearch ? Icon(Icons.cancel_outlined) : Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearch = !_isSearch;
                  searchController!.clear();
                });
                Provider.of<MainProvider>(context, listen: false).searchList =
                    [];
              })
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<MainProvider>(
          builder: (context, value, child) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisExtent: 200,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) => searchController!.text.isNotEmpty
                ? GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DeviceDetailsScreen(
                            deviceId: value.searchList[index].id))),
                    child: DeviceItemView(
                        imageUrl: value.searchList[index].imageUrl,
                        name: value.searchList[index].name,
                        model: value.searchList[index].model),
                  )
                : GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DeviceDetailsScreen(
                            deviceId: value.othersDevicesList[index].id))),
                    child: DeviceItemView(
                        imageUrl: value.othersDevicesList[index].imageUrl,
                        name: value.othersDevicesList[index].name,
                        model: value.othersDevicesList[index].model),
                  ),
            itemCount: searchController!.text.isNotEmpty
                ? value.searchList.length
                : value.othersDevicesList.length,
          ),
        ),
      ),
    );
  }
}
