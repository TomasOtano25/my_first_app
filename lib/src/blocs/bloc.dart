import 'dart:async';
import './validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators{
  /*final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();*/

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to stream
  // get changeEmail => emailController.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Retrieve data from stream
  // get email => emailController.stream;
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    print('Email is $validEmail, Password is $validPassword');
  }

  void dispose(){
   /* _emailController.close();
    _passwordController.close();*/
    _email.close();
    _password.close();
  }
}

// Single global instance
final bloc = Bloc();