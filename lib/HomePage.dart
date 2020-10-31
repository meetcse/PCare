import 'package:flutter/material.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/routes/animation_route.dart';
import 'package:pcare/routes/routes.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/empty_app_bar_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> _loggedInUser = {
    "username": "John",
  };

  bool _isChange = false;
  changeAppBarTitle() async {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isChange = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // changeAppBarTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        //TODO: ADD ANIMATED TITLE IF POSSIBLE
        title: UniversalStrings.welcome + ' ' + _loggedInUser['username'] + '!',
      ),
    );
  }
}
