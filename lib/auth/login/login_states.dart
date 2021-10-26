import 'package:login_in_bloc/auth/form_submission_status.dart';

class LoginState {
  final String username;
  final String password;

  bool get isValidateUsername => username.length > 3;
  bool get isValidatePassword => password.length > 7;


  final FormSubmissionStatus formStatus;

  LoginState({this.username = '', this.password ='', this.formStatus = const InitialFormStatus()});

  LoginState copyWith({String? username, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}