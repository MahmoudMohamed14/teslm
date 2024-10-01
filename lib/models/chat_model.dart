class Chat {
  final String? id;
  final List<Messages>? messages;

  Chat({this.id, this.messages});
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((i) => Messages.fromJson(i))
              .toList()
          : null,
    );}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['messages'] = messages!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Messages {
  final String? id;
  final String? content;
  final String? createdAt;
  final String? from;

  Messages({this.id, this.content, this.createdAt, this.from});

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      id: json['id'],
      content: json['content'],
      createdAt: json['createdAt'],
      from: json['from'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['from'] = from;
    return data;
  }

}