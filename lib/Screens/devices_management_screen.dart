import 'package:booking_app/Screens/add_device.dart';
import 'package:booking_app/Screens/edit_device_screen.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/device_item_view.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesManagementScreen extends StatefulWidget {
  const DevicesManagementScreen({Key? key}) : super(key: key);

  @override
  _DevicesManagementScreenState createState() =>
      _DevicesManagementScreenState();
}

class _DevicesManagementScreenState extends State<DevicesManagementScreen> {
  bool _isSearch = false;
  TextEditingController? searchController = TextEditingController();

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
          centerTitle: true,
          title: _isSearch
              ? Consumer<MainProvider>(
                  builder: (context, value, child) => TextField(
                    autofocus: true,
                    controller: searchController,
                    onChanged: (val) {
                      setState(() {
                        value.searchList = value.allDevicesList
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
                        contentPadding: EdgeInsets.all(10)),
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Text('Devices Management'),
          actions: [
            IconButton(
                icon: _isSearch
                    ? Icon(Icons.cancel_outlined)
                    : Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearch = !_isSearch;
                    searchController!.clear();
                  });
                  Provider.of<MainProvider>(context, listen: false).searchList =
                      [];
                })
          ],
        ),
        body: Consumer<MainProvider>(
          builder: (context, value, child) => ListView.separated(
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) => Container(
              height: 200,
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EditDeviceScreen(
                        deviceId: searchController!.text.isNotEmpty
                            ? value.searchList[index].id
                            : value.allDevicesList[index].id))),
                child: DeviceItemView(
                    imageUrl: searchController!.text.isNotEmpty
                        ? value.searchList[index].imageUrl
                        :value.allDevicesList[index].imageUrl,
                    name: searchController!.text.isNotEmpty
                        ? value.searchList[index].name
                        : value.allDevicesList[index].name,
                    model: searchController!.text.isNotEmpty
                        ? value.searchList[index].model
                        : value.allDevicesList[index].model,
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
                ? value.searchList.length
                : value.allDevicesList.length,
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
