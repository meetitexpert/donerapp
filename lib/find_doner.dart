import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donerapp/Models/Users.dart';
import 'package:donerapp/Widgets/dropdownwidget.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_table_view/cupertino_table_view.dart';
import 'package:donerapp/Models/DataRepository.dart';

class Find_Doner extends StatefulWidget {
  const Find_Doner({Key? key}) : super(key: key);

  @override
  _Find_DonerState createState() => _Find_DonerState();
}

// ignore: camel_case_types
class _Find_DonerState extends State<Find_Doner> {
  String selectGroup = '';
  final DataRepository repository = DataRepository();
  late Iterable<DocumentSnapshot>? filteredUsers = [];

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // 4
    final user = Users.fromSnapshot(snapshot);

    final name = user.name;
    final pNo = user.phoneNo;
    final bGroup = user.bloodGroup;
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('$pNo\n$bGroup'),
      ),
    );
    ;
  }

  CupertinoTableViewDelegate generateDelegate(
      Iterable<DocumentSnapshot>? snapshot) {
    return CupertinoTableViewDelegate(
      numberOfSectionsInTableView: () => 2,
      numberOfRowsInSection: (section) {
        var rows = 0;
        if (section != 0) {
          rows = snapshot!.length;
        } else {
          rows = 1;
        }

        return rows;
      },
      cellForRowAtIndexPath: (context, indexPath) {
        if (indexPath.section == 0) {
          return dropDownWidget(
            bGroup: (group) {
              setState(() {
                selectGroup = group;
                filteredUsers = snapshot?.where((element) =>
                    Users.fromSnapshot(element).bloodGroup == selectGroup);
                debugPrint("${filteredUsers!.length}");
                
              });
            },
          );
        } else {
          return _buildListItem(context, snapshot!.elementAt(indexPath.row));
        }
      },
      headerInSection: (context, section) => Container(
        height: 0,
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 5),
      ),

      pressedOpacity: 0.4,
      canSelectRowAtIndexPath: (indexPath) => true,
      didSelectRowAtIndexPath: (indexPath) => print('$indexPath'),
      // marginForSection: marginForSection, // set marginForSection when using boxShadow
    );
  }

  Widget donersList(
      BuildContext context, Iterable<DocumentSnapshot>? snapshot) {
    return CupertinoTableView(
      delegate: generateDelegate(snapshot),
      backgroundColor: Colors.black12,
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Doner')),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            filteredUsers = snapshot.data?.docs ?? [];
            return donersList(context, filteredUsers);
          }),
    );
  }
}
