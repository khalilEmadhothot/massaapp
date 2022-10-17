class Folder {
  bool? success;
  String? description;
  List<Data>? data;

  Folder({this.success, this.description, this.data});

  Folder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? user;
  Null? folder;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Folders>? folders;

  Data(
      {this.id,
        this.user,
        this.folder,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.folders});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    folder = json['folder'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['folders'] != null) {
      folders = <Folders>[];
      json['folders'].forEach((v) {
        folders!.add(new Folders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['folder'] = this.folder;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.folders != null) {
      data['folders'] = this.folders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Folders {
  int? id;
  int? user;
  int? folder;
  String? name;
  String? createdAt;
  String? updatedAt;

  Folders(
      {this.id,
        this.user,
        this.folder,
        this.name,
        this.createdAt,
        this.updatedAt});

  Folders.fromJson(Map<String, dynamic> json) {
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