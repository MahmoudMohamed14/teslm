class Chat {
  String? id;
  List<Messages>? messages;

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }
}

class Messages {
  String? id;
  String? content;
  String? createdAt;
  String? from;

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['createdAt'];
    from = json['from'];
  }

}