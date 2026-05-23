import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String computerCode;
  const ProfileScreen({required this.computerCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                ),
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Student Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    computerCode,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'B.Tech CSE — 3rd Year',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Stats Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  statCard('76%', 'Attendance', Colors.blue),
                  SizedBox(width: 12),
                  statCard('8.2', 'CGPA', Colors.green),
                  SizedBox(width: 12),
                  statCard('3rd', 'Year', Colors.orange),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Info Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  SizedBox(height: 12),
                  infoCard(Icons.badge, 'Computer Code', computerCode),
                  infoCard(Icons.school, 'Department', 'Computer Science & Engineering'),
                  infoCard(Icons.calendar_today, 'Batch', '2022 - 2026'),
                  infoCard(Icons.location_on, 'College', 'IPS Academy IES, Indore'),
                  infoCard(Icons.email, 'Email', '$computerCode@ipsacademy.org'),

                  SizedBox(height: 16),

                  Text(
                    'Academic Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  SizedBox(height: 12),
                  infoCard(Icons.grade, 'Current Semester', '6th Semester'),
                  infoCard(Icons.book, 'Total Subjects', '6 Subjects'),
                  infoCard(Icons.assignment_turned_in, 'Backlogs', 'None'),

                  SizedBox(height: 24),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF1A237E), size: 20),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}