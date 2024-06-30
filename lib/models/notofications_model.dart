class NotificationsModel {
  int? id;
  String? title;
  String? body;
  String? imageUrl;
  String? audioUrl;
  String? glassesId;
  String? createdAt;
  String? type;
  bool? isRead;

  NotificationsModel(
      {this.id,
        this.title,
        this.body,
        this.imageUrl,
        this.audioUrl,
        this.glassesId,
        this.createdAt,
        this.type,
        this.isRead});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    imageUrl = json['imageUrl'];
    audioUrl = json['audioUrl'];
    glassesId = json['glassesId'];
    createdAt = json['createdAt'];
    type = json['type'];
    isRead = json['isRead'];
  }

}