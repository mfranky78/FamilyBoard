

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/auth_repo.dart';
import 'auth_state.dart';

/// [AuthCubit]-Klasse, die von [Cubit<AuthState>] erbt
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _firebaseAuth;

  /// Konstruktor für die AuthCubit-Klasse
  AuthCubit(this._firebaseAuth, this._authRepository, super.initialState);

  /// Methode zum Anmelden mit Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      emit(AuthLoading("Lädt"));
      await _authRepository.loginWithGoogle();

      emit(Authenticated(
        _authRepository.getCurrentUser()!.email.toString(),
      ));
      if (context.mounted) Navigator.popAndPushNamed(context, "/homescreen");
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Methode zum Anmelden mit E-Mail und Passwort
  Future<void> singInWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      emit(const AuthLoading("Lädt"));
      
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(
        Authenticated(
          
          userCredential.user!.email.toString(),
          
        ),
      );
      if (context.mounted) Navigator.pushNamed(context, "/homescreen");
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.toString()));
    }
  } // Mehtode um einen User zu erstellen
 Future<void> createUserWithEmailAndPassword(
  String email, String password, BuildContext context) async {
  try {
    emit(const AuthLoading('Lädt'));
    
    if (email.isEmpty || password.isEmpty) {
      // Überprüfung durchführen und einen Fehler auslösen, wenn Felder leer sind.
      throw FirebaseAuthException(
        code: 'empty-fields',
        message: 'E-Mail und Passwort dürfen nicht leer sein',
      );
    }
  } on FirebaseAuthException catch (e) {
    emit(AuthError(e.toString()));
  }
}

  /// Methode zum Abmelden
  Future<void> signOut(BuildContext context) async {
    await _authRepository.signOut();
    emit(Unauthenticated());
    if (context.mounted) Navigator.popAndPushNamed(context, "/loginpage");
  }
}