class Test {
  bool? success;
  String? description;
  List<TestData>? data;

  Test({this.success, this.description, this.data});

  Test.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
    if (json['data'] != null) {
      data = <TestData>[];
      json['data'].forEach((v) {
        data!.add(new TestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['description'] = this.description;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestData {
late  int? id;
late  int? user;
late  Folder? folder;
late  String? image;
late  String? type;
late  dynamic size;
late  dynamic lat;
late  dynamic long;
late  String? comment;
late  String? createdAt;
late  String? updatedAt;

  TestData();

  TestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    folder = json['folder'] != null ? Folder.fromJson(json['folder']) : null;
    image = json['name'];
    type = json['type'];
    size = json['size'];
    lat = json['lat'];
    long = json['long'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    if (this.folder != null) {
      data['folder'] = this.folder!.toJson();
    }
    data['name'] = this.image;
    data['type'] = this.type;
    data['size'] = this.size;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Folder {
  int? id;
  int? user;
  dynamic? folder;
  String? name;
  String? createdAt;
  String? updatedAt;

  Folder(
      {this.id,
      this.user,
      this.folder,
      this.name,
      this.createdAt,
      this.updatedAt});

  Folder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    folder = json['folder'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['folder'] = this.folder;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
