import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_container_planning.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanningManagementScreen extends StatefulWidget {
  const PlanningManagementScreen({Key? key}) : super(key: key);

  @override
  _PlanningManagementScreenState createState() =>
      _PlanningManagementScreenState();
}

class _PlanningManagementScreenState extends State<PlanningManagementScreen> {
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
              : Text('Planning Management'),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomContainerPlanning(
                    text: 'Device',
                  ),
                  CustomContainerPlanning(
                    text: 'Period',
                  ),
                  CustomContainerPlanning(
                    text: 'By',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<MainProvider>(
                builder: (context, value, child) => Expanded(
                  child: ListView.separated(
                    itemCount:searchController!.text.isNotEmpty
                        ? value.searchList.length
                        : value.reservedDevicesList.length,
                    itemBuilder: (context, index) =>searchController!.text.isNotEmpty
                          ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            value.searchList[index].deviceName,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Text(
                            'From: ${value.searchList[index].startDate}' +
                                '\nTo: ${value.searchList[index].endDate}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            value
                                .findEmployeeById(
                                    value.searchList[index].id)
                                .name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            value.reservedDevicesList[index].deviceName,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Text(
                            'From: ${value.reservedDevicesList[index].startDate}' +
                                '\nTo: ${value.reservedDevicesList[index].endDate}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            value
                                .findEmployeeById(
                                    value.reservedDevicesList[index].id)
                                .name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  ),
                ),
              )
            ],
          ),
        ),
        drawer: MainDrawer(),
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: Consumer<MainProvider>(
        builder: (context, value, child) => ListView.separated(
          shrinkWrap: true,
          itemCount: value.reservedDevicesList.length,
          itemBuilder: (context, index) => ListTile(
              leading: Text(
                value.reservedDevicesList[index].deviceName,
                textAlign: TextAlign.center,
              ),
              title: Text(
                'From: ${value.reservedDevicesList[index].startDate}',
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'To: ${value.reservedDevicesList[index].endDate}',
                textAlign: TextAlign.center,
              ),
              trailing: Text(
                value
                    .findEmployeeById(value.reservedDevicesList[index].id)
                    .name,
                textAlign: TextAlign.center,
              )),
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
    );
  }
}

