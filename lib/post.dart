import 'dart:convert';

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    this.id = 0,
    this.userId = 0,
    this.title = '',
    this.body = '',
  });

  static Post fromMap(Map<String, dynamic>? map) {
    if (map == null) return Post();

    return Post(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      body: map['body'],
    );
  }

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post id: $id, userId: $userId, title: $title, body: $body';
  }
}
