import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailure(ErrorMessage: 'No User Found For This Email'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(ErrorMessage: 'Wrong Password , Try again'));
          }
        } catch (ex) {
          LoginFailure(ErrorMessage: 'Someting Went Wrong');
        }
      } else if (event is RegisterEvent) {
        try {
          emit(RegisterLoading());
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.Email,
            password: event.password,
          );
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailure(ErrorMessage: 'Weak-Password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFailure(ErrorMessage: 'email-already-in-use'));
          }
        } catch (ex) {
          emit(RegisterFailure(ErrorMessage: 'There Is An Error'));
        }
      }
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
