import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart' as parser;

class AuthService {
  static const String baseUrl = 'https://cms2.ipsacademy.net';

  // Extract clean cookie
  static String extractCookie(String? rawCookie) {
    if (rawCookie == null) return '';
    String cookie = rawCookie.split(';')[0];
    return cookie;
  }

  // Login to college portal
  static Future<Map<String, dynamic>> login(
      String computerCode, String password) async {
    try {

      // Step 1: Get login page to get captcha
      final getResponse = await http.get(
        Uri.parse('$baseUrl/Login/sign_in'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Connection': 'keep-alive',
        },
      );

      // Get initial cookie
      String initialCookie = extractCookie(
        getResponse.headers['set-cookie']);
      print('Initial cookie: $initialCookie');

      // Get captcha from login page
      String loginPageHtml = getResponse.body;
      String captchaValue = '';
      var loginDoc = parser.parse(loginPageHtml);
      var captchaEl = loginDoc
        .querySelector('input[name="captcha"]');
      if (captchaEl != null) {
        captchaValue = 
          captchaEl.attributes['value'] ?? '';
      }
      print('Captcha: $captchaValue');

      // Step 2: POST to /Login/check with captcha
      final loginResponse = await http.post(
        Uri.parse('$baseUrl/Login/check'),
        headers: {
          'Content-Type': 
            'application/x-www-form-urlencoded',
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Referer': '$baseUrl/Login/sign_in',
          'Cookie': initialCookie,
          'Connection': 'keep-alive',
          'Upgrade-Insecure-Requests': '1',
        },
        body: {
          'computer_code': computerCode,
          'password': password,
          'captcha': captchaValue,
        },
      );

      print('Login status: ${loginResponse.statusCode}');

      // Get session cookie after login
      String sessionCookie = extractCookie(
        loginResponse.headers['set-cookie']);
      if (sessionCookie.isEmpty) {
        sessionCookie = initialCookie;
      }
      print('Session cookie: $sessionCookie');

      // Step 3: Fetch dashboard to verify login
      final dashResponse = await http.get(
        Uri.parse('$baseUrl/Student'),
        headers: {
          'Cookie': sessionCookie,
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Referer': '$baseUrl/Login/sign_in',
          'Connection': 'keep-alive',
          'Upgrade-Insecure-Requests': '1',
        },
      );

      String dashBody = dashResponse.body;
      print('Dash length: ${dashBody.length}');
      print('Dash preview: ${dashBody.substring(0, dashBody.length < 300 ? dashBody.length : 300)}');

      // Check if login successful
      if (!dashBody.contains('Attendance') &&
          !dashBody.contains('Assignments') &&
          !dashBody.contains('Dashboard')) {
        return {
          'success': false,
          'message': 'Wrong Computer Code or Password!',
        };
      }

      // Step 4: Get student name
      String studentName = computerCode;
      var document = parser.parse(dashBody);
      var nameEl =
        document.querySelector('b') ??
        document.querySelector('strong') ??
        document.querySelector('h4');

      if (nameEl != null &&
          nameEl.text.trim().isNotEmpty &&
          nameEl.text.trim().length > 2) {
        studentName = nameEl.text.trim();
      }

      // Step 5: Save session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('session_cookie', sessionCookie);
      await prefs.setString('computer_code', computerCode);
      await prefs.setString('student_name', studentName);
      await prefs.setBool('is_logged_in', true);

      return {
        'success': true,
        'student_name': studentName,
        'cookie': sessionCookie,
      };

    } catch (e) {
      print('Login error: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Fetch any page after login
  static Future<String> fetchPage(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String cookie = 
        prefs.getString('session_cookie') ?? '';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Cookie': cookie,
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.9',
          'Cache-Control': 'max-age=0',
          'Connection': 'keep-alive',
          'Referer': '$baseUrl/Student',
          'Upgrade-Insecure-Requests': '1',
        },
      );

      return response.body;
    } catch (e) {
      print('Fetch error: $e');
      return '';
    }
  }

  // Check if already logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // Get saved student name
  static Future<String> getStudentName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('student_name') ?? 'Student';
  }

  // Get saved computer code
  static Future<String> getComputerCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('computer_code') ?? '';
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}