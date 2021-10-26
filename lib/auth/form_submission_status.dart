import 'package:flutter/cupertino.dart';

abstract class FormSubmissionStatus{
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus{
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus{

}

class FormSubmittedSuccess extends FormSubmissionStatus{

}

class FormSubmittedFailed extends FormSubmissionStatus {
  final Object? exception;
  FormSubmittedFailed({this.exception});
}