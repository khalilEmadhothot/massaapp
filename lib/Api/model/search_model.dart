class SearchModel {
  late int id;
  late int user;
  late Folder? folder;
  late String name;
  late String type;
  late double size;
  late int lat;
  late int long;
  late String comment;
  late String createdAt;
  late String updatedAt;

  SearchModel();

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    folder = json['folder'] != null ? Folder.fromJson(json['folder']) : null;
    name = json['name'];
    type = json['type'];
    size = json['size'];
    lat = json['lat'];
    long = json['long'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Folder {
  late int id;
  late int user;
  late String? folder;
  late String name;
  late String createdAt;
  late String updatedAt;

  Folder();

  Folder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    folder = json['folder'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
