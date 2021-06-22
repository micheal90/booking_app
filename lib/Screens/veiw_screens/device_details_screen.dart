import 'package:booking_app/constants.dart';
import 'package:booking_app/widgets_model/custom_container_device_details.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:booking_app/models/device_model.dart';

class DeviceDetailsScreen extends StatelessWidget {
  final DeviceModel deviceModel;
  DeviceDetailsScreen({
    Key? key,
    required this.deviceModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 275,
          backgroundColor: Colors.grey.shade300,
          flexibleSpace: FlexibleSpaceBar(
              title: Text(
                deviceModel.name,
                style: TextStyle(
                    color: Colors.white, backgroundColor: Colors.black45),
              ),
              background: CarouselSlider.builder(
                  itemCount: deviceModel.imageUrl.length,
                  itemBuilder: (context, index, realIndex) => Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/loading.png'),
                          image: NetworkImage(
                            deviceModel.imageUrl[index],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: true,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ))
              // background: FadeInImage(
              //   placeholder: AssetImage('assets/images/loading.png'),
              //   image: NetworkImage(deviceModel.imageUrl[0]),
              //   fit: BoxFit.fill,
              // ),
              ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomContainerDeviceDetail(
                  title: 'Type',
                  detail: deviceModel.type.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Model',
                  detail: deviceModel.model.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'OS',
                  detail: deviceModel.os.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Screen Size',
                  detail: deviceModel.screenSize.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Battery',
                  detail: deviceModel.battery.toUpperCase(),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: CustomElevatedButton(
                    text: 'Booked',
                  ),
                )
              ],
            ),
          )
        ]))
      ],
    ));
  }
}
