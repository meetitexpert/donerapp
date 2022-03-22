import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  // 1
  String name;
  String address;
  String phoneNo;
  String bloodGroup;
  String? referenceId;

  // 2
  Users(this.name, this.address,
      {required this.phoneNo, required this.bloodGroup, this.referenceId});
  // 3
  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    final newUser = Users.fromJson(snapshot.data() as Map<String, dynamic>);
    newUser.referenceId = snapshot.reference.id;
    return newUser;
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(json['name'] as String, json['address'] as String,
        phoneNo: json['phoneNo'] as String,
        bloodGroup: json['bloodGroup'] as String);
  }
  // 4
  Map<String, dynamic> toJson() => _usersToJson(this);

  @override
  String toString() => 'User<$Users>';

  Map<String, dynamic> _usersToJson(Users instance) => <String, dynamic>{
        'name': instance.name,
        'address': instance.address,
        'phoneNo': instance.phoneNo,
        'bloodGroup': instance.bloodGroup,
      };
}
