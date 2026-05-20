import 'package:firebase_project/auth/screens/login_screen.dart';
import 'package:firebase_project/auth/services/auth_service.dart';
import 'package:firebase_project/tasks/screens/task_screen.dart';
import 'package:firebase_project/users/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = AuthService();

  UserModel? _currentUser;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    UserModel? user = await _authService.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: _currentUser == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${_currentUser!.name}!'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to tasks screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskScreen()),
                      );
                    },
                    child: Text('View Tasks'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _authService.logout();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
      ),
    );
  }
}
