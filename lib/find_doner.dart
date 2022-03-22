import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donerapp/Models/Users.dart';
import 'package:donerapp/Widgets/dropdownwidget.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_table_view/cupertino_table_view.dart';
import 'package:donerapp/Models/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class Find_Doner extends StatefulWidget {
  const Find_Doner({Key? key}) : super(key: key);

  @override
  _Find_DonerState createState() => _Find_DonerState();
}

// ignore: camel_case_types
class _Find_DonerState extends State<Find_Doner>
    with AutomaticKeepAliveClientMixin<Find_Doner> {
  String selectGroup = 'All';
  final DataRepository repository = DataRepository();
  late Iterable<DocumentSnapshot>? filteredUsers = [];
  late Iterable<DocumentSnapshot>? allUsersData = [];

  @override
  bool get wantKeepAlive => true;

  Widget _noDataFound(BuildContext context) {
    return const ListTile(
      minVerticalPadding: 200,
      title: Center(child: Text('No Data Found')),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // 4
    final user = Users.fromSnapshot(snapshot);

    final name = user.name;
    final pNo = user.phoneNo;
    final address = user.address;
    final bGroup = user.bloodGroup;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$pNo\n$address\n$bGroup',
          style: TextStyle(height: 1.5),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.call,
            color: Colors.blue,
          ),
          onPressed: () {
            launch("tel:$pNo");
          },
        ),
      ),
    );
  }

  CupertinoTableViewDelegate generateDelegate(
      Iterable<DocumentSnapshot>? snapshot) {
    return CupertinoTableViewDelegate(
      numberOfSectionsInTableView: () => 2,
      numberOfRowsInSection: (section) {
        var rows = 0;
        if (section != 0) {
          rows = snapshot!.isEmpty ? 1 : snapshot.length;
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
                if (selectGroup == "All") {
                  filteredUsers = [];
                } else {
                  filteredUsers = allUsersData?.where((element) =>
                      Users.fromSnapshot(element).bloodGroup == selectGroup);
                  debugPrint("${filteredUsers!.length}");
                }
              });
            },
          );
        } else {
          return snapshot!.isEmpty
              ? _noDataFound(context)
              : _buildListItem(context, snapshot.elementAt(indexPath.row));
        }
      },
      headerInSection: (context, section) => Container(
        height: 0,
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 5),
      ),

      pressedOpacity: 0.4,
      canSelectRowAtIndexPath: (indexPath) => true,
      didSelectRowAtIndexPath: (indexPath) => debugPrint('$indexPath'),
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
            allUsersData = snapshot.data?.docs ?? [];
            if (selectGroup == "All") {
              filteredUsers = allUsersData;
            }

            return donersList(context, filteredUsers);
          }),
    );
  }
}
