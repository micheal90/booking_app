import 'package:booking_app/models/reserve_device_model.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:data_tables/data_tables.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SchedulePlanningScreen extends StatefulWidget {
  @override
  _SchedulePlanningScreenState createState() => _SchedulePlanningScreenState();
}

class _SchedulePlanningScreenState extends State<SchedulePlanningScreen> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _sort<T>(Comparable<T> getField(ReserveDeviceModel r), int columnIndex,
      bool ascending) {
    Provider.of<MainProvider>(context, listen: false)
        .orderResvDevicesList
        .sort((ReserveDeviceModel a, ReserveDeviceModel b) {
      if (!ascending) {
        final ReserveDeviceModel c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Schedule Planning'),
        ),
        body: Consumer<MainProvider>(
          builder: (context, valueMain, child) => valueMain.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : valueMain.orderResvDevicesList.isEmpty
                  ? Center(
                      child: CustomText(
                      text: 'No scheduled reserved yet',
                      alignment: Alignment.center,
                      fontSize: 22,
                    ))
                  : NativeDataTable.builder(
                      showSelect: false,
                      totalItems: valueMain.orderResvDevicesList.length,
                      alwaysShowDataTable: false,
                      sortAscending: _sortAscending,
                      sortColumnIndex: _sortColumnIndex,
                      mobileIsLoading: CircularProgressIndicator(),
                      onRefresh: () async => await valueMain.refresh(),
                      showSort: true,
                      handleNext: () {},
                      columns: [
                        DataColumn(
                            label: Text('Device Name'),
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>(
                                    (ReserveDeviceModel d) => d.deviceName,
                                    columnIndex,
                                    ascending)),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Period')),
                        DataColumn(label: Text('By Employee')),
                      ],
                      itemCount: valueMain.orderResvDevicesList.length,
                      itemBuilder: (index) => DataRow(cells: [
                        DataCell(Text(
                            valueMain.orderResvDevicesList[index].deviceName)),
                        DataCell(
                            Text(valueMain.orderResvDevicesList[index].type)),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('From:'),
                                Text(DateFormat.yMd().format(DateTime.parse(
                                    valueMain.orderResvDevicesList[index]
                                        .startDate))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('To:'),
                                Text(DateFormat.yMd().format(DateTime.parse(
                                    valueMain
                                        .orderResvDevicesList[index].endDate))),
                              ],
                            ),
                          ],
                        )),
                        DataCell(
                          Consumer<AuthProvider>(
                            builder: (context, valueAuth, child) => Row(
                              children: [
                                Text(valueAuth
                                    .findEmployeeById(valueMain
                                        .orderResvDevicesList[index].userId)
                                    .name),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(valueAuth
                                    .findEmployeeById(valueMain
                                        .orderResvDevicesList[index].userId)
                                    .lastName),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
