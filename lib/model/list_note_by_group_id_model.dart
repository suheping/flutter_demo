class ListNoteByGroupIdModel {
  int code;
  String msg;
  Errors errors;
  List<Note> data;

  ListNoteByGroupIdModel({this.code, this.msg, this.errors, this.data});

  ListNoteByGroupIdModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if (json['data'] != null) {
      data = new List<Note>();
      json['data'].forEach((v) {
        data.add(new Note.fromJson(v));
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

class Note {
  int id;
  String name;
  int groupId;
  int sortNo;
  String content;

  Note({this.id, this.name, this.groupId, this.sortNo, this.content});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    groupId = json['group_id'];
    sortNo = json['sort_no'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['group_id'] = this.groupId;
    data['sort_no'] = this.sortNo;
    data['content'] = this.content;
    return data;
  }
}
