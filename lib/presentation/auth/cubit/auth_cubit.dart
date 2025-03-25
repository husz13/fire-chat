import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseFirestore.instance;

  void login({required String email, required String password}) async {
    emit(AuthLoading());
    print(email);
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      print("***************************$e******************************");

      emit(AuthError(e));
    }
  }

  void register({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((response) {
        try {
          _storage.collection("users").add(<String, dynamic>{
            "email": email,
            "uid": response.user!.uid,
            "id": Random().nextInt(1000)
          });
        } catch (e) {
          print("***************************$e******************************");
        }
      });

      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e));
    }
  }
}
