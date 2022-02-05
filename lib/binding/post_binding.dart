import 'package:error_handling_either/controller/post_controlller.dart';
import 'package:get/get.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}
