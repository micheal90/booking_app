import 'package:booking_app/constants.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';

class DeviceItemView extends StatelessWidget {
 final  List<String> imageUrl;
 final String name;
 final String model;
 final Widget? trailing;

  const DeviceItemView(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.model,
      this.trailing,
      
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: GridTile(
          child: FadeInImage(
            placeholder: AssetImage('assets/images/loading.png'),
            image: NetworkImage(
              imageUrl.isNotEmpty?imageUrl.first:notImageAvailableUrl,
            ),
            imageErrorBuilder: (context, error, stackTrace) =>
                new Icon(Icons.error_outline_outlined),
            fit: BoxFit.fill,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black26,
            title: CustomText(
              color: Colors.white,
              text: name,
            ),
            subtitle: CustomText(
              color: Colors.white,
              text: model,
            ),
            trailing:trailing ,
          ),
        ));
  }
}
