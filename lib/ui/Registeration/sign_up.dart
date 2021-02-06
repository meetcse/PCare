import 'package:flutter/material.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<Map<String, String>> list = [
    {'text': 'FirstName'},
    {'text': 'LastName'},
    {'text': 'PassWord'},
    {'text': 'Re-Enter PassWord'},
    {'text': 'Address'},
    {'text': 'Gender'},
    {'text': 'Date Of Birth', 'onTap': 'Yes'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Column(children: <Widget>[
                TextFieldWidget(
                  labelText: list[index]['text'],
                  onTap: list[index]['onTap'] == "Yes"
                      ? () => {_selectDate(context)}
                      : null,
                ),
              ]),
            );
          }),
    );
  }
}

Future<void> _selectDate(BuildContext context) async {
  print("ghusa");
  final DateTime d = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015),
    lastDate: DateTime(2020),
  );
  print("Date selected : " + d.toString());
}
