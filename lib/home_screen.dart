import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'result_screen.dart';
import 'timetable_screen.dart';
import 'notice_screen.dart';
import 'profile_screen.dart';
import 'assignment_screen.dart';
class HomeScreen extends StatelessWidget {
  final String computerCode;
  final String studentName;
  const HomeScreen({
    required this.computerCode,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          'IES Student Hub',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Welcome Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back! 👋',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
  studentName,
  style: TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),
                  SizedBox(height: 4),
                  Text(
                    'IPS Academy IES',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Menu Title
            Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            SizedBox(height: 16),

            // Menu Grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: NeverScrollableScrollPhysics(),
              children: [
                menuCard(
                  icon: Icons.bar_chart,
                  title: 'Attendance',
                  subtitle: 'View your attendance',
                  color: Colors.blue[700]!,
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AttendanceScreen(),
    ),
  );
},
                ),
                menuCard(
                  icon: Icons.grade,
                  title: 'Results & MST',
                  subtitle: 'Check your marks',
                  color: Colors.green[700]!,
                   onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultsScreen(),
    ),
  );
},
                ),
                menuCard(
                  icon: Icons.calendar_today,
                  title: 'Timetable',
                  subtitle: 'View schedule',
                  color: Colors.orange[700]!,
                onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TimetableScreen(),
    ),
  );
},
                ),
                menuCard(
                  icon: Icons.announcement,
                  title: 'Notices',
                  subtitle: 'College notices',
                  color: Colors.purple[700]!,
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NoticesScreen(),
    ),
  );
},
                ),
                menuCard(
                  icon: Icons.assignment,
                  title: 'Assignments',
                  subtitle: 'Your assignments',
                  color: Colors.red[700]!,
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AssignmentScreen(),
    ),
  );
},
                ),
                menuCard(
                  icon: Icons.person,
                  title: 'Profile',
                  subtitle: 'Your details',
                  color: Colors.teal[700]!,
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfileScreen(
        computerCode: computerCode,
      ),
    ),
  );
},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF1A237E),
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}