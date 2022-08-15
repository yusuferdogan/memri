class Events {
  String? id;
  String? type;
  Actor? actor;
  Repo? repo;
  Payload? payload;
  bool? public;
  String? createdAt;

  Events(
      {this.id,
      this.type,
      this.actor,
      this.repo,
      this.payload,
      this.public,
      this.createdAt});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    actor = json['actor'] != null ? Actor.fromJson(json['actor']) : null;
    repo = json['repo'] != null ? Repo.fromJson(json['repo']) : null;
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    public = json['public'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    if (actor != null) {
      data['actor'] = actor!.toJson();
    }
    if (repo != null) {
      data['repo'] = repo!.toJson();
    }
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['public'] = public;
    data['created_at'] = createdAt;
    return data;
  }
}

class Actor {
  int? id;
  String? login;

  Actor({
    this.id,
    this.login,
  });

  Actor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['login'] = login;
    return data;
  }
}

class Repo {
  int? id;
  String? name;

  Repo({this.id, this.name});

  Repo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}

class Payload {
  int? pushId;
  int? size;

  Payload({this.pushId, this.size});

  Payload.fromJson(Map<String, dynamic> json) {
    pushId = json['push_id'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['push_id'] = pushId;
    data['size'] = size;

    return data;
  }
}
