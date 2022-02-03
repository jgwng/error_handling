import 'package:dartz/dartz.dart';
import 'package:error_handling_either/post.dart';
import 'package:error_handling_either/post_service.dart';
import 'package:get/get.dart';
// 하나의 클래스안에 에러 & 정상반응 모두 선언 -> 불필요
// 정상반응 또는 에러를 가지고 있는 것을 필요로 한다.

// Either의 필요성
// To make sure only one type is available at the same time
// To Enforce the error handling(make the compiler complaint)

// Either란 무엇인가?
// ex) Either<A,B> response  = Right("Hello, im Right");
// 선언한 A,B타입중 하나만을 가지고 있게 하는 것

// 해당 변수가 왼쪽인지 오른쪽인지 선언만 해주면 선언끝!
class PostController extends GetxController {
  RxBool isLoading = false.obs;
  final _postService = PostService();
  Either<Failure, Post>? _post;
  Either<Failure, Post>? get post => _post;

  Future<void> getData() async {
    if (isLoading.isTrue) return;
    isLoading.value = true;
    await Task(() => _postService.getOnePost())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) => _setPost(value));
    isLoading.value = false;
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

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
