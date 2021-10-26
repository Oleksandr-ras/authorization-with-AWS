import 'package:login_in_bloc/auth/auth_repository.dart';
import 'package:login_in_bloc/auth/form_submission_status.dart';
import 'package:login_in_bloc/auth/login/login_events.dart';
import 'package:login_in_bloc/auth/login/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState>{
  final AuthRepository? authRepository;

  LoginBloc({this.authRepository}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if(event is OnChangeUserName){
      yield state.copyWith(username: event.loginName);
    } else if(event is OnChangePassword) {
      yield state.copyWith(password: event.password);
    } else if(event is ButtonClickEvent){
      yield state.copyWith(formStatus: FormSubmitting());
      try{
        await authRepository!.tryToLogin();
        yield state.copyWith(formStatus: FormSubmittedSuccess());
      } catch (e){
        yield state.copyWith(formStatus: FormSubmittedFailed(exception: e));
      }
    }
  }
}