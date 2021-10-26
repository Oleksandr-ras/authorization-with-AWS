import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_in_bloc/auth/auth_repository.dart';
import 'package:login_in_bloc/auth/form_submission_status.dart';
import 'package:login_in_bloc/auth/login/login_events.dart';
import 'package:login_in_bloc/auth/login/login_states.dart';

import 'login_bloc.dart';

class LogInWidget extends StatelessWidget {
  LogInWidget({Key? key}) : super(key: key);

  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(authRepository: context.read<AuthRepository>()),
        child: loginForm(),
      )
    );
  }

  Widget loginForm() {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      final formStts = state.formStatus;
      if(formStts is FormSubmittedFailed) {
        _showSnackBar(context, formStts.exception.toString());
      }
    },
    child: Form (
      key: _fromKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginField(),
                const SizedBox(height: 15),
                passwordField(),
                const SizedBox(height: 15),
                loginButton()
              ]
          ),
        ),
      ),
    ));
  }

  Widget loginField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return  TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Username',
        ),
        validator: (value) => state.isValidateUsername ? null : 'Too short username',
        onChanged: (value) => context.read<LoginBloc>().add(OnChangeUserName(loginName: value)),
      );
    });
  }

  Widget passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return  TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) => state.isValidatePassword ? null : 'Too short password',
        onChanged: (value) => context.read<LoginBloc>().add(OnChangePassword(password: value)),
      );
    });
  }

  Widget loginButton() {
    return BlocBuilder<LoginBloc, LoginState>( builder: (context, state) {
        return state.formStatus is FormSubmitting ?
          const CircularProgressIndicator() :
        ElevatedButton(
            onPressed: () {
              if(_fromKey.currentState!.validate()) {
                context.read<LoginBloc>().add(ButtonClickEvent());
              }
            },
            child: const Text('Login')
        );
      }
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
