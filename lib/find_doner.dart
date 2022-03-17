import 'package:donerapp/Widgets/dropdownwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class Find_Doner extends StatefulWidget {
  const Find_Doner({Key? key}) : super(key: key);

  @override
  _Find_DonerState createState() => _Find_DonerState();
}

// ignore: camel_case_types
class _Find_DonerState extends State<Find_Doner> {
  String selectGroup = '';
  
  Widget listView() {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, i) {
          return const ListTile(
            title: Text("Text"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Doner')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SectionTableView(
            sectionCount: 2,
            numOfRowInSection: (section) {
              return section == 0 ? 1 : 5;
            },
            cellAtIndexPath: (section, row) {
              return section == 0
                  ? dropDownWidget(
                    
                      bGroup: (group) {
                        setState(() {
                          selectGroup = group;
                        });
                      },
                    )
                  : Card(
                      child: ListTile(
                        title: Text('Text $row'),
                        subtitle: const Text('0336 7268704 \n B+'),
                      ),
                    );
            },
            headerInSection: (section) {
              return Container(
                height: section == 0 ? 0 : 5.0,
                color: Colors.white,
              );
            },
            divider: Container(
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
