import 'package:booking_app/constants.dart';
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

class ReservedDevicesScreen extends StatefulWidget {
  const ReservedDevicesScreen({Key? key}) : super(key: key);

  @override
  _ReservedDevicesScreenState createState() => _ReservedDevicesScreenState();
}

class _ReservedDevicesScreenState extends State<ReservedDevicesScreen> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _sort<T>(Comparable<T> getField(ReserveDeviceModel r), int columnIndex,
      bool ascending) {
    Provider.of<MainProvider>(context, listen: false)
        .reservedDevicesList
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
          title: Text('Reserved Devices'),
        ),
        body: Consumer<MainProvider>(
          builder: (context, valueMain, child) => valueMain
                  .reservedDevicesList.isEmpty
              ? Center(
                  child: CustomText(
                  text: 'No device reserved yet',
                  alignment: Alignment.center,
                  fontSize: 22,
                ))
              : NativeDataTable.builder(
                  showSelect: false,
                  totalItems: valueMain.reservedDevicesList.length,
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
                  itemCount: valueMain.reservedDevicesList.length,
                  itemBuilder: (index) => DataRow(cells: [
                    DataCell(
                        Text(valueMain.reservedDevicesList[index].deviceName)),
                    DataCell(Text(valueMain.reservedDevicesList[index].type)),
                    DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('From:'),
                            Text(DateFormat.yMd().format(DateTime.parse(
                                valueMain
                                    .reservedDevicesList[index].startDate))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('To:'),
                            Text(DateFormat.yMd().format(DateTime.parse(
                                valueMain.reservedDevicesList[index].endDate))),
                          ],
                        ),
                      ],
                    )),
                    DataCell(
                      Consumer<AuthProvider>(
                        builder: (context, valueAuth, child) => Row(
                          children: [
                            Text(valueAuth
                                .findEmployeeById(
                                    valueMain.reservedDevicesList[index].userId)
                                .name),
                            SizedBox(
                              width: 5,
                            ),
                            Text(valueAuth
                                .findEmployeeById(
                                    valueMain.reservedDevicesList[index].userId)
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

  Padding bodyListTilel() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<MainProvider>(
            builder: (context, valueMain, child) => Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: KPrimaryColor,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: valueMain.reservedDevicesList[index].type,
                        ),
                      ),
                    ),
                  ),
                  title: CustomText(
                    color: KPrimaryColor,
                    text: valueMain.reservedDevicesList[index].deviceName,
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'From: ' +
                            DateFormat.yMd().format(DateTime.parse(valueMain
                                .reservedDevicesList[index].startDate)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: 'To: ' +
                            DateFormat.yMd().format(DateTime.parse(
                                valueMain.reservedDevicesList[index].endDate)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  trailing: Text(
                    'By Employee\n' +
                        Provider.of<AuthProvider>(context, listen: false)
                            .findEmployeeById(
                                valueMain.reservedDevicesList[index].userId)
                            .name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                itemCount: valueMain.reservedDevicesList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
