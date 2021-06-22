import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservedDevicesScreen extends StatelessWidget {
  const ReservedDevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reserved Devices'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8,bottom: 8),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<HomeProvider>(
              builder: (context, value, child) => Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
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
                      
                      text: value.reservedDevicesList[index].name,
                    ),
                    subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text:
                                  'Model: ' + value.reservedDevicesList[index].model,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: 'OS: ' + value.reservedDevicesList[index].os,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                    trailing: Text(
                      'Screen Size\n' +
                          value.reservedDevicesList[index].screenSize,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  itemCount: value.reservedDevicesList.length,
                   separatorBuilder: (BuildContext context, int index)=>Divider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
