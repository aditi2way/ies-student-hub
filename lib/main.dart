import 'package:flutter/material.dart';
import 'home_screen.dart';
void main() {
  runApp(IESStudentHub());
}

class IESStudentHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IES Student Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1A237E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1A237E),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final computerCodeController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 40),

                // Logo
                Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Text(
    'IES',
    style: TextStyle(
      color: Color(0xFF1A237E),
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
  ),
),
                SizedBox(height: 16),

                // App Name
                Text(
                  'IES Student Hub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'IPS Academy',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 50),

                // Login Card
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Computer Code
                      TextField(
                        controller: computerCodeController,
                        decoration: InputDecoration(
                          labelText: 'Computer Code',
                          prefixIcon: Icon(Icons.person,
                            color: Color(0xFF1A237E)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFF1A237E), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Password
                      TextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Default: dd-mm-yyyy',
                          prefixIcon: Icon(Icons.lock,
                            color: Color(0xFF1A237E)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                              color: Color(0xFF1A237E),
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFF1A237E), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomeScreen(
        computerCode: computerCodeController.text,
      ),
    ),
  );
},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1A237E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),
                Text(
                  'For 1st, 2nd, 3rd & 4th Year Students',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}