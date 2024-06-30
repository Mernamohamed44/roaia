class ContactsModel {
  dynamic id;
  dynamic fullName;
  dynamic age;
  dynamic relation;
  dynamic phoneNumber;
  dynamic imageUrl;
  dynamic glassesId;
  dynamic glasses;

  ContactsModel(
      {this.id,
        this.fullName,
        this.age,
        this.relation,
        this.phoneNumber,
        this.imageUrl,
        this.glassesId,
        this.glasses});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    age = json['age'];
    relation = json['relation'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    glassesId = json['glassesId'];
    glasses = json['glasses'];
  }

}