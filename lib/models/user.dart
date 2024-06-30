/*
{
    "message": null,
    "id": "3c46a550-0c43-4a27-89fb-41b492a65f70",
    "firstName": "Roaia",
    "lastName": "Official",
    "userName": "admin",
    "email": "roaiaofficial@gmail.com",
    "blindId": null,
    "imageUrl": "http://roaiaofficial.somee.com/images/avatar.png",
    "phoneNumber": null,
    "roles": null
}
*/

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String imageUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
