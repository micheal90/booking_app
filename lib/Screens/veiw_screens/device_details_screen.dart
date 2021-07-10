import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_container_device_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:booking_app/models/device_model.dart';
import 'package:provider/provider.dart';

class DeviceDetailsScreen extends StatefulWidget {
  final String deviceId;
  DeviceDetailsScreen({
    Key? key,
    required this.deviceId,
  }) : super(key: key);

  @override
  _DeviceDetailsScreenState createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  DeviceModel? deviceModel;
  @override
  void initState() {
    deviceModel = Provider.of<MainProvider>(context, listen: false)
        .findDeviceById(widget.deviceId);
    super.initState();
  }

  

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
                deviceModel!.name,
                style: TextStyle(
                    color: Colors.white, backgroundColor: Colors.black45),
              ),
              background: CarouselSlider.builder(
                  itemCount: deviceModel!.imageUrl.length,
                  itemBuilder: (context, index, realIndex) => Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/loading.png'),
                          image: NetworkImage(
                            deviceModel!.imageUrl[index],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: deviceModel!.imageUrl.length > 1 ? true : false,
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
                  detail: deviceModel!.type.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Model',
                  detail: deviceModel!.model.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'OS',
                  detail: deviceModel!.os.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Screen Size',
                  detail: deviceModel!.screenSize.toUpperCase(),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomContainerDeviceDetail(
                  title: 'Battery',
                  detail: deviceModel!.battery.toUpperCase(),
                ),
                SizedBox(
                  height: 40,
                ),
                // Container(
                //   child: CustomElevatedButton(
                //     text: 'Edit',
                //     onPressed: () =>
                //         Navigator.of(context).push(MaterialPageRoute(
                //       builder: (_) =>
                //           EditDeviceScreen(deviceId: deviceModel!.id),
                //     )),
                //   ),
                // ),
              ],
            ),
          )
        ]))
      ],
    ));
  }
}
