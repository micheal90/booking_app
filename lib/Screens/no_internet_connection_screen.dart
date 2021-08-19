import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 80,
          ),
          CustomText(
            text: 'No Internet Connection!',
            alignment: Alignment.center,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 5,
          ),
          CustomText(
            text: 'Please check your internet connection.',
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
