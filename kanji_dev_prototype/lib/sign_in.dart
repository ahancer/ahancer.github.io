import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_styles.dart';
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
      backgroundColor: Styles.bgGray0,
      appBar: appBar('漢字 Prototype 5.4'),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 24.0,
          children: [
            ElevatedButton(
              onPressed: () async {
                await loginSpecial('natt@ahancer.com', 'test123');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Styles.bgWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img-alien-1.png',
                    height: 64,
                    width: 64,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Natt',
                    style: Styles.title,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await loginSpecial('tester1@ahancer.com', 'test123');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Styles.bgWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img-alien-2.png',
                    height: 64,
                    width: 64,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Noon',
                    style: Styles.subTitle,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await loginSpecial('tester2@ahancer.com', 'test123');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Styles.bgWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img-alien-3.png',
                    height: 64,
                    width: 64,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Dalad',
                    style: Styles.subTitle,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await loginSpecial('tester3@ahancer.com', 'test123');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Styles.bgWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the radius as needed
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img-alien-4.png',
                    height: 64,
                    width: 64,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Nan',
                    style: Styles.subTitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //-----P Natt Version------//
      // ListView(
      //   padding: const EdgeInsets.all(24.0),
      //   children: [
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

      //     const SizedBox(
      //       height: 16,
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         await loginSpecial('natt@ahancer.com', 'test123');
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => Home()),
      //         );
      //       },
      //       style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      //       child: const Text(
      //         'Natt Login',
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 24,
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         await loginSpecial('tester1@ahancer.com', 'test123');
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => Home()),
      //         );
      //       },
      //       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      //       child: const Text(
      //         'Noon Login',
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 24,
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         await loginSpecial('tester2@ahancer.com', 'test123');
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => Home()),
      //         );
      //       },
      //       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      //       child: const Text(
      //         'Dalad Login',
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 24,
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         await loginSpecial('tester3@ahancer.com', 'test123');
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => Home()),
      //         );
      //       },
      //       style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      //       child: const Text(
      //         'Nan Login',
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Future<void> loginSpecial(String UserName, String Password) async {
    await supabase.auth.signInWithPassword(email: UserName, password: Password);
  }
}
