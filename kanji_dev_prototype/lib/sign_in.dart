import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/home.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgGray0,
      appBar: AppBar(
        title: Text(
          '漢字 Prototype 7.0',
          style: Styles.jpSmall.copyWith(color: Styles.textColorWhite).copyWith(fontSize: 24),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        child: Column(
          children: [
            //For Debug font
            // Text(
            //   '今, 言, 少, 空, 化, 灰, 豚',
            //   style: Styles.jpSmall,
            // ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  SpecialLoginButton(
                    email: 'tester1@ahancer.com',
                    password: 'test123',
                    mascotImage: 'assets/images/img-mascot-a.png',
                    mascotName: 'Chita',
                  ),
                  SpecialLoginButton(
                    email: 'natt@ahancer.com',
                    password: 'test123',
                    mascotImage: 'assets/images/img-mascot-b.png',
                    mascotName: 'Natt',
                  ),
                  SpecialLoginButton(
                    email: 'tester2@ahancer.com',
                    password: 'test123',
                    mascotImage: 'assets/images/img-mascot-c.png',
                    mascotName: 'Dalad',
                  ),
                  SpecialLoginButton(
                    email: 'tester3@ahancer.com',
                    password: 'test123',
                    mascotImage: 'assets/images/img-mascot-d.png',
                    mascotName: 'Dalad',
                  ),
                 SpecialLoginButton(
                    email: 'tester4@ahancer.com',
                    password: 'test123',
                    mascotImage: 'assets/images/img-mascot-e.png',
                    mascotName: 'New User',
                  ),
                  SpecialLoginButton(
                    email: 'tester5@ahancer.com',
                    password: 'test123',
                    mascotImage: 'assets/images/img-mascot-f.png',
                    mascotName: 'New User',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class SpecialLoginButton extends StatelessWidget {
  final String email;
  final String password;
  final String mascotImage;
  final String mascotName;

  SpecialLoginButton({
    required this.email,
    required this.password,
    required this.mascotImage,
    required this.mascotName,
  });

  Future<void> loginSpecial(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await loginSpecial(email, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Styles.bgWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            mascotImage,
            height: 80,
            width: 80,
          ),
          const SizedBox(height: 8),
          Text(
            mascotName,
            style: Styles.body.copyWith(color: Styles.textColorPrimary),
          ),
        ],
      ),
    );
  }
}