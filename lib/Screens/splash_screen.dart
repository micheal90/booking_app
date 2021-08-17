import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Image.asset(
            'assets/icon/icon.png',
            height: 150,
            width: 150,
          ),
          Spacer(),
          CustomText(
            text: 'Developed by Micheal Hana',
            alignment: Alignment.center,
            fontSize: 22,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    ));
  }
}
