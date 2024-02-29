
class Customer {
  String id;
  String name;


  Customer.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'];

}