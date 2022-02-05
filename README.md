# error_handling_either
 본 프로젝트는 dartz 패키지 내의 either를 통해 에러 핸들링을 공부하기 위해 작성한 미니 프로젝트 입니다.
 
 참고)
  - https://medium.com/nerd-for-tech/better-error-handling-with-either-type-in-dart-b91bef20d716
  - https://resocoder.com/category/tutorials/flutter/error-handling/
 
## Either에 관한 설명 

  보통 서버와 통신을 함에 있어 에러가 나는 경우의 수는 상당히 많다. 대표적인 경우는 데이터 연결없이 통신 시도하는 경우이다.
  이렇게 에러 났을때와 정상적으로 데이터를 받은 경우를 하나의 데이터 타입으로 관리 할 수 있으면 좋지 않을까?라는 생각으로 만들어진 것이 Either이다. 
  
   기본적으로 제공하고 있는 type이 없기 때문에 dartz라는 함수형 프로그래밍 패키지를 활용한다.
   해당 패키지에 Either<Left,Right>을 지원한다.

   Either는 선언한 타입중 하나만을 가지고 있기 위해 사용한다. 
   보통 통신 이후의 데이터 타입과 에러에 대한 타입을 선언할때 사용한다.

   Either의 사용법은 간단하다. ex) Either<int,String> response  = Right("Hello, im Right");
   해당 값이 왼쪽 / 오른쪽 타입인지 선언후( Left(~)  / Right (~)) 선언한 타입에 맞는 값을 설정하면 된다.
   
   코드 예시   
   ```dart
   void main(){
      Either<int, String> response = Right("Hello, im right");
      response.fold(
            (integerValue) => print('Integer : $integerValue'),
            (stringValue) => print('String : $stringValue')
        );
  //prints 'String : Hello, im right'
  }
  ```
 
 fold 함수의 경우 정해진 Either의 형태에 따라 이후 동작을 선언한다.
 위의 예시에선 response가 왼쪽 즉, 정수인 경우 print('Integer : $integerValue') 호출
 오른쯕, 즉 문자열인 경우 print('String : $stringValue')를 호출한다.

 위의 FOLD 함수 이외에도 많은 함수들이 제공된다.
 .isLeft() / .isRight => bool값 반환 , 말 그대로 해당 값이 왼쪽/오른쪽인지 확인하는 함수
 .getOrElse() => Right값 리턴
 .toOption() => 해당 값을 Option 형태로 변환해준다.

 Option 또한 Either와 비슷하다. 보통 option은 에러방지 보다는 리턴 값의 null 방지를 위해 사용한다.
 Either를 통해 error 핸들링 강화 및 불필요한 타입 선언을 방지 할 수 있다.
 
 ## 앱 화면 캡쳐
<p align="center">
 <img src="https://user-images.githubusercontent.com/71699167/152634919-723d5201-4341-4032-af7e-cf4d95643e7f.png" width="200" height="400"/>
 
 <img src="https://user-images.githubusercontent.com/71699167/152634920-0ed54633-933f-4c86-b4e4-efb1ae7dfa82.png" width="200" height="400" />
 
 <img src="https://user-images.githubusercontent.com/71699167/152634921-20698ca4-d2b2-4200-92c0-b7addf918ad6.png" width="200" height="400"/>
 

 
## 참고사항
 해당 프로젝트의 코드 기반은 - https://resocoder.com/category/tutorials/flutter/error-handling/을 기반으로 작성하였다.
 해당 사이트에서 제공하는 코드와 다른점
  - 해당 사이트에선 상태관리를 provider를 통해 진행했지만, 이 프로젝트에서는  GetX를 사용하였다.
  - 단순 delay만을 통해 값을 리턴하는것이 아니라, 실제 api 통신을 통해 오류 확인도 할 수 있다.
 코드에 관한 기본적인 설명에 관해 주석을 추가적으로 작성하였다.


 
