class BlindInfoModel {
  dynamic message;
  String? id;
  String? fullName;
  int? age;
  String? gender;
  String? imageUrl;
  dynamic imageUpload;
  List<String>? diseases;

  BlindInfoModel({
    this.message,
    this.id,
    this.fullName,
    this.age,
    this.gender,
    this.imageUrl,
    this.imageUpload,
    this.diseases,
  });

  BlindInfoModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    fullName = json['fullName'];
    age = json['age'];
    gender = json['gender'];
    imageUrl = json['imageUrl'];
    imageUpload = json['imageUpload'];
    diseases = json['diseases'].cast<String>();
  }
}
