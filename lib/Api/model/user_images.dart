class UserImage {
  late int user;
  late String folder;
  late String name;
  late String type;
  late String lat;
  late String long;
  late String size;
  late String comment;
  late String updatedAt;
  late String createdAt;
  late int id;

  UserImage();

  UserImage.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    folder = json['folder'];
    name = json['name'];
    type = json['type'];
    lat = json['lat'];
    long = json['long'];
    size = json['size'];
    comment = json['comment'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
