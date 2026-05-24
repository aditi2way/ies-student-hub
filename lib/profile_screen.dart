import 'package:flutter/material.dart';
import 'scraper_service.dart';
import 'auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final String computerCode;
  const ProfileScreen({required this.computerCode});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> profile = {};
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    Map<String, dynamic> data =
      await ScraperService.fetchProfile();

    setState(() {
      isLoading = false;
      if (data.isEmpty) {
        error = 'Could not load profile';
      } else {
        profile = data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text('My Profile',
          style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: loadProfile,
          )
        ],
      ),
      body: isLoading
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF1A237E)),
                SizedBox(height: 16),
                Text('Loading profile...'),
              ],
            ),
          )
        : error.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                    size: 60, color: Colors.red),
                  SizedBox(height: 12),
                  Text(error),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: loadProfile,
                    child: Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [

                  // Profile Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1A237E),
                          Color(0xFF3949AB)
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Photo or Avatar
                        profile['photo'] != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                profile['photo']),
                              onBackgroundImageError: (e, s) {},
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Text(
                                (profile['name'] ?? 'S')
                                  .substring(0, 1)
                                  .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A237E)),
                              ),
                            ),
                        SizedBox(height: 12),

                        // Name
                        Text(
                          profile['name'] ?? 
                            widget.computerCode,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),

                        // Course
                        Text(
                          profile['course'] ?? 'B.Tech',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14),
                        ),
                        SizedBox(height: 4),

                        // Blood Group Badge
                        if (profile['blood_group'] != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius:
                                BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.5)),
                            ),
                            child: Text(
                              '🩸 ${profile['blood_group']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                        CrossAxisAlignment.start,
                      children: [

                        // Academic Info
                        Text('Academic Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E))),
                        SizedBox(height: 12),

                        infoCard(Icons.badge,
                          'Computer Code',
                          profile['computer_code'] ??
                            widget.computerCode),
                        infoCard(Icons.numbers,
                          'Enrollment No',
                          profile['enrollment'] ?? '-'),
                        infoCard(Icons.school,
                          'Course',
                          profile['course'] ?? 'B.Tech'),
                        infoCard(Icons.calendar_today,
                          'Session',
                          profile['session'] ?? '-'),
                        infoCard(Icons.location_on,
                          'College',
                          'IPS Academy IES, Indore'),

                        SizedBox(height: 16),

                        // Personal Info
                        Text('Personal Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E))),
                        SizedBox(height: 12),

                        infoCard(Icons.phone,
                          'Phone',
                          profile['phone'] ?? '-'),
                        infoCard(Icons.bloodtype,
                          'Blood Group',
                          profile['blood_group'] ?? '-'),

                        SizedBox(height: 24),

                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await AuthService.logout();
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            },
                            icon: Icon(Icons.logout,
                              color: Colors.white),
                            label: Text('Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                  BorderRadius.circular(8)),
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
            offset: Offset(0, 2)),
        ],
      ),
      child: Row(
  children: [
    Icon(icon, color: Color(0xFF1A237E), size: 20),
    SizedBox(width: 12),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12)),
          Text(value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    ),
  ],
),
    );
  }
}