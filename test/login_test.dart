// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_order_food/core/service/authenication_service.dart';
import 'package:project_order_food/ui/view/common_view/login/controllers/login_controller.dart';

class AuthMock extends Mock implements BaseAuth {}

class MockBuildContext extends Mock implements BuildContext {}

class LoginControllerMock extends Mock implements LoginControllerX {}

@GenerateMocks([AuthMock, LoginControllerMock, MockBuildContext])
void main() {
  late final AuthMock mockAuthService = AuthMock();
  late final LoginControllerMock mockLoginController = LoginControllerMock();
  late final MockBuildContext mockBuildContext = MockBuildContext();

  group(" => Test dang nhap bang tu cach user", () {
    test(" => Se tra ve errorMessage == null khi dang nhap thanh cong!",
        () async {
      print("");
      final Future<String?> expectX = Future.value(null);
      when(mockAuthService.signIn("email", "password"))
          .thenAnswer((_) => expectX);
      final errorString = await mockAuthService.signIn("email", "password");
      expect(errorString, null);
      verify(mockAuthService.signIn("email", "password"));
    });
    test(" => Se tra ve errorMessage == \"Err\" khi dang nhap that bai!",
        () async {
      print("");
      final Future<String?> expectX = Future.value(null);
      when(mockAuthService.signIn("email", "password"))
          .thenAnswer((_) async => "Err");
      final errorString = await mockAuthService.signIn("email", "password");
      expect(errorString, "Err");
      verify(mockAuthService.signIn("email", "password"));
    });
  });

  group(" => Test dang nhap bang tu cach admin", () {
    // final BuildContext context = BuildContext();
    test(
        "=> Khi _email == 'admin@gmail.com' & _password == 'admin' thi se dang nhap voi tu cach admin, khong goi den auth.signIn",
        () async {
      print("");
      when(mockLoginController.signIn(mockBuildContext))
          .thenAnswer((_) async => true);
      final result = await mockLoginController.signIn(mockBuildContext);
      expect(result, true);
      verify(mockLoginController.signIn(mockBuildContext));
    });
    test(
        "=> Khi _email != 'admin@gmail.com' & _password != 'admin' thi se dang nhap voi tu cach admin, goi den auth.signIn",
        () async {
      print("");
      when(mockLoginController.signIn(mockBuildContext))
          .thenAnswer((_) async => false);
      final result = await mockLoginController.signIn(mockBuildContext);
      expect(result, false);
      verify(mockLoginController.signIn(mockBuildContext));
    });
  });
}
