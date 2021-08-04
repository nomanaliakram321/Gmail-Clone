import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmail_flutter_clone/services/user_services.dart';

class User {
  storeUserData(user, email, username, password, imageUrl) {
    UserServices _services = UserServices();

    _services.users.doc(email).set({
      'email': email,
      'username': username,
      'password': password,
      'imageUrl': imageUrl,
    });
  }
}
