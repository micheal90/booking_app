import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';

class PlanningManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Planning Management'),
        ),
        body: Container(),
        drawer: MainDrawer(),
      ),
    );
  }
}
