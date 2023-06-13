class Contact{
  int?id;
  String? name;
  String? address;
  String? phoneNumber;

  Contact({this.id, this.name, this.address, this.phoneNumber });

  Contact.fromMap(Map<String, dynamic>map) {
    id = map['id'];
    name = map['name'];
    address = map['address'];
    phoneNumber = map['phoneNumber'];
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber
    };
  }

}