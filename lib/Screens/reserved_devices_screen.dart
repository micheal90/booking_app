import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservedDevicesScreen extends StatefulWidget {
  const ReservedDevicesScreen({Key? key}) : super(key: key);

  @override
  _ReservedDevicesScreenState createState() => _ReservedDevicesScreenState();
}

class _ReservedDevicesScreenState extends State<ReservedDevicesScreen> {
  bool _isSearch = false;

  TextEditingController? searchController = TextEditingController();
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
                        value.searchList = value.reservedDevicesList
                            .where((element) => element.deviceName
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
              : Text('Reserved Devices'),
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
        body: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<MainProvider>(
                builder: (context, value, child) => Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => searchController!
                            .text.isNotEmpty
                        ? ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: KPrimaryColor,
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: value.searchList[index].type,
                                  ),
                                ),
                              ),
                            ),
                            title: CustomText(
                              color: KPrimaryColor,
                              text: value.searchList[index].deviceName,
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: 'From: ' +
                                      value.searchList[index].startDate,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  text:
                                      'To: ' + value.searchList[index].endDate,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            trailing: Text(
                              'By Employee\n' +
                                  value
                                      .findEmployeeById(
                                          value.reservedDevicesList[index].id)
                                      .name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: KPrimaryColor,
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: value.reservedDevicesList[index].type,
                                  ),
                                ),
                              ),
                            ),
                            title: CustomText(
                              color: KPrimaryColor,
                              text: value.reservedDevicesList[index].deviceName,
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: 'From: ' +
                                      value
                                          .reservedDevicesList[index].startDate,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  text: 'To: ' +
                                      value.reservedDevicesList[index].endDate,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            trailing: Text(
                              'By Employee\n' +
                                  value
                                      .findEmployeeById(
                                          value.reservedDevicesList[index].id)
                                      .name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                    itemCount: searchController!.text.isNotEmpty
                        ? value.searchList.length
                        : value.reservedDevicesList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
