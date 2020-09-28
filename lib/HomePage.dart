import 'package:flutter/material.dart';
import 'package:pcare/widgets/empty_app_bar_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future<void> main() async {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var email = prefs.getString('email');
  //     print(email);
  //     runApp(MaterialApp(home: email == null ? Login() : Home()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
