import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kanji_prototype/home.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';

final supabase = Supabase.instance.client;


class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('漢字 Prototype 5.2'),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // SupaEmailAuth(
          //   redirectTo: kIsWeb ? null : 'io.supabase.flutter://',
          //   onSignInComplete: (response) {
          //     Navigator.of(context).pushReplacementNamed('/home');
          //   },
          //   onSignUpComplete: (response) {
          //     Navigator.of(context).pushReplacementNamed('/home');
          //   },
          //   metadataFields: [
          //     MetaDataField(
          //       prefixIcon: const Icon(Icons.person),
          //       label: 'Username',
          //       key: 'username',
          //       validator: (val) {
          //         if (val == null || val.isEmpty) {
          //           return 'Please enter something';
          //         }
          //         return null;
          //       },
          //     ),
          //   ],
          // ),
          // SupaSocialsAuth(
          //   socialProviders: [
          //       SocialProviders.apple,
          //       SocialProviders.google,
          //       SocialProviders.facebook,
          //   ],
          //   colored: true,
          //   redirectUrl: kIsWeb
          //         ? null
          //         : 'io.supabase.flutter://reset-callback/',
          //   onSuccess: (Session response) { 
          //       Navigator.of(context).pushReplacementNamed('/home');
          //   },
          // ),
          const SizedBox(height: 16,),
          ElevatedButton(
            onPressed: () async {
              await loginSpecial('natt@ahancer.com', 'test123');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: const Text('Natt Login',),
          ),
          const SizedBox(height: 24,),
          ElevatedButton(
            onPressed: () async {
              await loginSpecial('tester1@ahancer.com', 'test123');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Noon Login',),
          ),
          const SizedBox(height: 24,),
          ElevatedButton(
            onPressed: () async {
              await loginSpecial('tester2@ahancer.com', 'test123');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Dalad Login',),
          ),
          const SizedBox(height: 24,),
          ElevatedButton(
            onPressed: () async {
              await loginSpecial('tester3@ahancer.com', 'test123');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Nan Login',),
          ),
        ],
      ),
    );
  }

  Future<void> loginSpecial(String UserName, String Password) async {
  await supabase.auth.signInWithPassword(
    email: UserName,
    password: Password
  );
}
}
