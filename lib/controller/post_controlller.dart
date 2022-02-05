import 'package:dartz/dartz.dart';
import 'package:error_handling_either/model/post.dart';
import 'package:error_handling_either/service/post_service.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxBool isNetworking = false.obs;
  final _postService = PostService();
  Either<Failure, Post>? _post;
  Either<Failure, Post>? get post => _post;

  Future<void> getData() async {
    // 중복된 데이터 통신을 방지 하기 위해
    // 통신중에 함수 실행시, 실행 중지
    if (isNetworking.isTrue) return;
    isNetworking.value = true;
    //통신 이후 통신 결과를 UI에 반영해주기 위한 과정
    await Task(() => _postService.getOnePost())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) => _setPost(value));

    // 모든 통신이 끝이 났다고 알려줌
    isNetworking.value = false;
  }

  void _setPost(Either<Failure, dynamic> post) {
    _post = post as Either<Failure, Post>?;
  }
}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}
