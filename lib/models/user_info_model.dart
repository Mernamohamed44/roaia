class UserInfoModel {
  dynamic message;
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? blindId;
  String? imageUrl;
  dynamic phoneNumber;
  List<String>? roles;

  UserInfoModel(
      {this.message,
        this.id,
        this.firstName,
        this.lastName,
        this.userName,
        this.email,
        this.blindId,
        this.imageUrl,
        this.phoneNumber,
        this.roles});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    blindId = json['blindId'];
    imageUrl = json['imageUrl'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
  }

}