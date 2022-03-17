import 'package:donerapp/Widgets/dropdownwidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Register_doner extends StatefulWidget {
  const Register_doner({Key? key}) : super(key: key);

  @override
  _Register_donerState createState() => _Register_donerState();
}

class _Register_donerState extends State<Register_doner> {
  String username = '';
  String userPhoneNo = '';
  String bloodGroup = '';

  get set => null;

  Widget nameField() {
    return TextField(
      onChanged: (value) => {username = value},
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Username',
        hintText: 'Enter your name',
      ),
    );
  }

  Widget phoneNoField() {
    return TextField(
      onChanged: (value) => {userPhoneNo = value},
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Phone No',
        hintText: 'Enter your phone number',
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.purple)),
        onPressed: () => {submitAction(context)},
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ));
  }

  void submitAction(BuildContext context) {
    if (username.isEmpty) {
      showAlert('Enter your name.', context);
      return;
    } else if (userPhoneNo.isEmpty) {
      showAlert('Enter your phone no.', context);
      return;
    } else if (bloodGroup.isEmpty) {
      showAlert('Enter your blood group.', context);
      return;
    }

    showAlert('All data entered', context);
  }

  void showAlert(String msg, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(''),
        content: Text(msg),
        actions: [
          TextButton(
              onPressed: (() => {Navigator.of(context).pop()}),
              child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Doner')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            nameField(),
            const SizedBox(
              height: 10,
            ),
            phoneNoField(),
            const SizedBox(
              height: 10,
            ),
            dropDownWidget(
                bGroup: (group) => ({
                      setState(() {
                        bloodGroup = group;
                      })
                    })),
            const SizedBox(
              height: 10,
            ),
            submitButton(context),
          ],
        ),
      ),
    );
  }
}
