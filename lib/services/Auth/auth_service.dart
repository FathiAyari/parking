import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/models/end_user.dart';

class AuthService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final GoogleSignIn _googleAuth = GoogleSignIn();

  //Init Firebase user
  EndUser _userFirebaseUser(User? firebaseUser) {
    return EndUser(
      uid: firebaseUser!.uid,
    );
  }

  //Signin Email/Pass
  Future loginUser(String login, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: login, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseUser(firebaseUser);
    } catch (e) {
      print('Account login failed, reason: ' + e.toString());
      return null;
    }
  }

  //Signup Email/Pass
  Future registerUser(String email, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseUser(firebaseUser);
    } catch (e) {
      print('Account creation failed, reason: ' + e.toString());
      return null;
    }
  }

  Future createUserDocument(String docId, EndUser mUser, String type) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(docId)
          .set(mUser.toJson(type));
    } catch (e) {
      print(e);
    }
  }

  /*Future createUserDocument(String docId, EndUser mUser) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(docId)
          .set(mUser.toJson());
    } catch (e) {
      print(e);
    }
  }*/

  Future updateUserDocument(String docID) async {
    EndUser uptated = EndUser(phone: '000001', username: 'yahya1');
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(docID)
          .update(uptated.toJsonUpdate());
    } catch (e) {
      print(e);
    }
  }

  Future deleteUser(String userId) async {
    try {
      _firebaseFirestore.collection('users').doc(userId).delete();
    } catch (e) {
      print(e);
    }
  }

  //Sign out
  Future<void> logout() async {
    try {
      print('logging out...');
      //await _googleAuth.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Stream<EndUser>? get user {
    return _firebaseAuth.authStateChanges().map(_userFirebaseUser);
  }
}
