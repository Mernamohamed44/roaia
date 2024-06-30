/*
 {
        "id": 1,
        "fullName": "Gad",
        "age": 22,
        "relation": "Friend",
        "phoneNumber": null,
        "imageUrl": "http://roaiaofficial.somee.com/images/contact/5133f5f3-e92e-47e2-85b2-163ef4887588.jpg",
        "glassesId": "08e35bb4-352b-41d9-94f6-0ef8ce",
        "glasses": null
    },
*/

class Contact {
  final int id;
  final String fullName;
  final int age;
  final String? phoneNumber;
  final String relation;
  final String imageUrl;
  final String glassesId;

  Contact({
    required this.id,
    required this.fullName,
    required this.age,
    required this.relation,
    required this.imageUrl,
    required this.glassesId,
    this.phoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      fullName: json['fullName'],
      age: json['age'],
      relation: json['relation'],
      imageUrl: json['imageUrl'],
      glassesId: json['glassesId'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'age': age,
      'relation': relation,
      'imageUrl': imageUrl,
      'glassesId': glassesId,
      'phoneNumber': phoneNumber,
    };
  }
}
