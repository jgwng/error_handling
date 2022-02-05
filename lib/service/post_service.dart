import 'dart:convert';
import 'dart:io';
import 'package:error_handling_either/model/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<Post> getOnePost() async {
    try {
      var response = await http
          .get(Uri.parse('htt://jsonplaceholder.typicode.com/posts/1'));
      var result = jsonDecode(response.body);

      Post post = Post.fromJson(result);
      // 해당부분의 길이 조절을 위해 일부만 사용
      post.body = post.body.substring(0, 10);
      return post;
    }
    // 인터넷 연결이 안되어 있는 경우 오류 발생
    on SocketException {
      throw Failure('No Internet connection 😑');
    }
    // 접근하라고 작성한 웹 주소를 찾지 못하는 경우 오류 발생
    on HttpException {
      throw Failure("Couldn't find the post 😱");
    }
    // 선언한 데이터 타입에 맞지 않는 데이터가 반환 됬을 경우
    on FormatException {
      throw Failure("Bad response format 👎");
    }
  }
}
