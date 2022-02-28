import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Register_doner extends StatefulWidget {
  const Register_doner({Key? key}) : super(key: key);

  @override
  _Register_donerState createState() => _Register_donerState();
}

class _Register_donerState extends State<Register_doner> {
  String username = '';
  String userPhoneNo = '';
  String bloodGroup = '';
  final List<String> genderItems = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-"
  ];

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

  Widget bloodGroupField() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: const Text(
        'Select Your Blood Group',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: genderItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select blood group.';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
        bloodGroup = value.toString();
      },
      onSaved: (value) {
        bloodGroup = value.toString();
      },
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
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
            bloodGroupField(),
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
