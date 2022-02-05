//통신을 통해 받아온 데이터 모델
class Post {
  final int id;
  final int userId;
  final String title;
  String body;

  Post({
    this.id = 0,
    this.userId = 0,
    this.title = '',
    this.body = '',
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  @override
  String toString() {
    return 'Post id: $id, userId: $userId, title: $title, body: $body';
  }
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
