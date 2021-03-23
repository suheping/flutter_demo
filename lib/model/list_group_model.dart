class ListGroupModel {
  int code;
  String msg;
  Errors errors;
  List<Group> data;

  ListGroupModel({this.code, this.msg, this.errors, this.data});

  ListGroupModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if (json['data'] != null) {
      data = new List<Group>();
      json['data'].forEach((v) {
        data.add(new Group.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  String sortNo;

  Errors({this.sortNo});

  Errors.fromJson(Map<String, dynamic> json) {
    sortNo = json['sort_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sort_no'] = this.sortNo;
    return data;
  }
}

class Group {
  int id;
  String name;
  int sortNo;

  Group({this.id, this.name, this.sortNo});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sortNo = json['sort_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sort_no'] = this.sortNo;
    return data;
  }
}
