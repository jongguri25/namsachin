import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBJYi7Azynfkkszsm-SBO0OvW66S-xYsIg",
            authDomain: "livetest2-a26ab.firebaseapp.com",
            projectId: "livetest2-a26ab",
            storageBucket: "livetest2-a26ab.appspot.com",
            messagingSenderId: "762613373677",
            appId: "1:762613373677:web:b041cc51c2006126f44ae4"));
  } else {
    await Firebase.initializeApp();
  }
}
