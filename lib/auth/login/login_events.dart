import 'package:login_in_bloc/auth/login/login_rename.dart';

abstract class LoginEvents {}

//when text field with userName are changed
class OnChangeUserName extends LoginEvents{

  String? loginName;
  OnChangeUserName({this.loginName});
}

//when text field with password are changed
class OnChangePassword extends LoginEvents {

  String? password;
  OnChangePassword ({this.password});
}

//when button are clicked
class ButtonClickEvent extends LoginEvents {}