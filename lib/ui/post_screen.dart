import 'package:error_handling_either/controller/post_controlller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<PostController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Handling'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            newData(),
            ElevatedButton(
              child: const Text('Get Post'),
              onPressed: () async {
                await controller.getData();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget newData() {
    return Obx(() {
      // 화면 진입시 통신 전에 보여질 위젯
      // 통신 전에는 데이터가 없기 때문에 null 여부 검사를 추가하였다.
      if (controller.isNetworking.isFalse && controller.post == null) {
        return const StyledText('Press the button 👇');
      }
      // 통신을 하고 있는 동안 보여질 위젯
      if (controller.isNetworking.isTrue) {
        return const CircularProgressIndicator();
      } else {
        // 통신이 끝난 이후에 보여질 위젯
        // 통신이 성공적으로 끝난다면 받아온 데이터를 화면에 보여줌
        // 통신 과정에서 에러가 발생했다면 해당 에러에 따른 에러 메세지를 보여줌
        return controller.post!.fold(
            (failure) => StyledText(failure.toString()),
            (post) => StyledText(post.toString()));
      }
    });
  }
}

// 화면에 보여질 위젯
class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40),
    );
  }
}
