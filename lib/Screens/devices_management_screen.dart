import 'package:booking_app/Screens/add_device.dart';
import 'package:booking_app/Screens/edit_device_screen.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesManagementScreen extends StatelessWidget {
  final TextEditingController? searchController = TextEditingController();

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
      child: Consumer<MainProvider>(
        builder: (context, valueMain, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: valueMain.isSearch.value
                ? Consumer<MainProvider>(
                    builder: (context, value, child) => TextField(
                      autofocus: true,
                      controller: searchController,
                      onChanged: (val) =>
                          valueMain.searchFunction(val, value.allDevicesList),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "Search...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10)),
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Text('Devices Management'),
            actions: [
              IconButton(
                  icon: valueMain.isSearch.value
                      ? Icon(Icons.cancel_outlined)
                      : Icon(Icons.search),
                  onPressed: () {
                    valueMain.changeIsSearch();
                    searchController!.clear();
                    valueMain.searchList = [];
                  })
            ],
          ),
          body: ListView.separated(
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) => Container(
              height: 200,
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EditDeviceScreen(
                        deviceId: searchController!.text.isNotEmpty
                            ? valueMain.searchList[index].id
                            : valueMain.allDevicesList[index].id))),
                child: DeviceItemView(
                    imageUrl: searchController!.text.isNotEmpty
                        ? valueMain.searchList[index].imageUrl
                        : valueMain.allDevicesList[index].imageUrl,
                    name: searchController!.text.isNotEmpty
                        ? valueMain.searchList[index].name
                        : valueMain.allDevicesList[index].name,
                    model: searchController!.text.isNotEmpty
                        ? valueMain.searchList[index].model
                        : valueMain.allDevicesList[index].model,
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
                                    searchController!.text.isNotEmpty
                                        ? TextButton(
                                            onPressed: () async {
                                              deleteDevice(
                                                  value,
                                                  value.searchList[index].id,
                                                  context);
                                            },
                                            child: Text('Yes'))
                                        : TextButton(
                                            onPressed: () async =>
                                                await deleteDevice(
                                                    value,
                                                    value.allDevicesList[index]
                                                        .id,
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
            itemCount: searchController!.text.isNotEmpty
                ? valueMain.searchList.length
                : valueMain.allDevicesList.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
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
      ),
    );
  }
}
