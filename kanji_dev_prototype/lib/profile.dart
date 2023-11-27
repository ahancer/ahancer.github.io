import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  
  final String UserID;
  final String UserName;

  const Profile({super.key, required this.UserID, required this.UserName});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Profile'),
    ),
    body: Center(
      child: Column(
        children: [
              const SizedBox(height: 24.0),
              Text(
                widget.UserName,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8.0),
              Text(widget.UserID.toString()),
              const SizedBox(height: 24.0),
              ElevatedButton(
              onPressed: () {
                Supabase.instance.client.auth.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ),
    );
  }
}