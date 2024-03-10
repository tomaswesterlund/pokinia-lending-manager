


import 'package:pokinia_lending_manager/util/string_extensions.dart';

class Organization {
  String id;
  DateTime createdAt;
  String name;


  Organization.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        createdAt = data['created_at'].toString().toDate(),
        name = data['name'];

}