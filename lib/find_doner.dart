import 'package:donerapp/Widgets/dropdownwidget.dart';
import 'package:flutter/material.dart';

class Find_Doner extends StatefulWidget {
  const Find_Doner({Key? key}) : super(key: key);

  @override
  _Find_DonerState createState() => _Find_DonerState();
}



class _Find_DonerState extends State<Find_Doner> {

  String selectGroup = ''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Doner')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: false,
          children: [
            dropDownWidget(bGroup: (group) { 
              setState(() {
                selectGroup = group;
              }); 
            },),
          ],
        ),
        
      ),
    );
  }
}
