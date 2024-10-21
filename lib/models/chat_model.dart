class ChatModel {
  final String? id;
  final List<MessagesModel>? messages;

  ChatModel({this.id, this.messages});
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((i) => MessagesModel.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['messages'] = messages!.map((v) => v.toJson()).toList();
    return data;
  }
}

class MessagesModel {
  final int? id;
  final String? content;
  final String? createdAt;
  final String? from;
  final String? audioUrl;
  final List<String> imageUrls;

  MessagesModel(
      {this.imageUrls = const [],
      this.id,
      this.audioUrl,
      this.content,
      this.createdAt,
      this.from});

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      id: json['id'],
      audioUrl: json['audioUrl'],
      content: json['content'],
      createdAt: json['createdAt'],
      from: json['from'],
      imageUrls:
          json['imageUrls'] != null ? List<String>.from(json['imageUrls']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['from'] = from;
    data['imageUrls'] = imageUrls;
    return data;
  }
}
