import 'dart:io';

import 'package:error_handling_either/post.dart';
import 'package:error_handling_either/post_controlller.dart';

class FakeHttpClient {
  Future<String> getResponseBody() async {
    await Future.delayed(const Duration(seconds: 1));
    return '{"userId":1,"id":1,"title":"nice title","body":"cool body"}';
  }
}

class PostService {
  final httpClient = FakeHttpClient();
  Future<Post> getOnePost() async {
    try {
      final responseBody = await httpClient.getResponseBody();
      return Post.fromJson(responseBody);
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }
}
