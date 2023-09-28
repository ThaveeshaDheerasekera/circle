import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository extends ChangeNotifier {
  // Firebase Authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUSer => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  String _message = '';

  String get getMessage {
    return _message;
  }

  void clearMessage() {
    _message = '';
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _message = e.message!;
      notifyListeners();
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String conPassword,
  }) async {
    try {
      if (password != conPassword) {
        _message = 'Password do not match';
        notifyListeners();
      } else if (name.isEmpty || conPassword.isEmpty) {
        _message = 'All fields must be filled';
        notifyListeners();
      } else {
        // Create user in the firebase authentication
        final UserCredential _userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get uid from the created user to save
        // in th users collection in firestore
        final uid = _userCredential.user?.uid;

        // add displayName of the created user
        await _userCredential.user?.updateDisplayName(name);

        print('-------------' + uid! + email + name + '-------------');
        // save user in the users collection in firestore
        await _firestore.collection('users').doc(uid).set({
          'email': email,
          'name': name,
        }).onError(
          (e, _) => print("Error writing document: $e"),
        );
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      _message = e.message!;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}
