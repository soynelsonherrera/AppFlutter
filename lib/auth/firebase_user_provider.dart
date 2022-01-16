import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MurielFastFoodFirebaseUser {
  MurielFastFoodFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MurielFastFoodFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MurielFastFoodFirebaseUser> murielFastFoodFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MurielFastFoodFirebaseUser>(
            (user) => currentUser = MurielFastFoodFirebaseUser(user));
