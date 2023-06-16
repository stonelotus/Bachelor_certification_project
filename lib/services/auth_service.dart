import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:licenta_main/models/user_model.dart';
import 'package:licenta_main/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      final UserModel userModel = UserModel.fromFirebaseUser(user);
      await FirestoreService().saveUserToFirestore(userModel);
    }
    return userCredential.user;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final UserModel userModel =
          UserModel.fromFirebaseUser(userCredential.user!);
      await FirestoreService().saveUserToFirestore(userModel);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPasswordOrganizer(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final UserModel userModel =
          UserModel.fromFirebaseUser(userCredential.user!);
      userModel.isOrganizer = true;
      userModel.isVerified = false;
      await FirestoreService().saveUserToFirestore(userModel);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }

    // try {
    //   var acs = ActionCodeSettings(
    //       // URL you want to redirect back to. The domain (www.example.com) for this
    //       // URL must be whitelisted in the Firebase Console.
    //       url: 'localhost',
    //       // This must be true
    //       handleCodeInApp: true,
    //       iOSBundleId: 'com.example.ios',
    //       androidPackageName: 'com.example.android',
    //       // installIfNotAvailable
    //       androidInstallApp: true,
    //       // minimumVersion
    //       androidMinimumVersion: '12');
    //   await _firebaseAuth
    //       .sendSignInLinkToEmail(email: email, actionCodeSettings: acs)
    //       .catchError((onError) {
    //     print('Error sending email verification $onError');
    //     return false;
    //   }).then((value) =>
    //           print('Successfully sent email verification to $email'));
    // } on FirebaseAuthException catch (e) {
    //   print(e.message);
    //   return null;
    // }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      print("Will try to sign in with email and password: " +
          email +
          " and " +
          password);
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Finished signing in");
      print("Got here" + userCredential.toString());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("ERROR ON SIGN IN");
      print(e.message);
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
