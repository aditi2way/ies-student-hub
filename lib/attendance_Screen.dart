import 'package:flutter/material.dart';
import 'scraper_service.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() =>
    _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String percentage = '0';
  String message = '';
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  void loadAttendance() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    Map<String, dynamic> data =
      await ScraperService.fetchAttendance();

    setState(() {
      isLoading = false;
      percentage = data['percentage'] ?? '0';
      message = data['message'] ?? '';
    });
  }

  Color getColor(int percent) {
    if (percent >= 85) return Colors.green;
    if (percent >= 75) return Colors.orange;
    return Colors.red;
  }

  String getStatus(int percent) {
    if (percent >= 85) return 'Good ✅';
    if (percent >= 75) return 'Safe ⚠️';
    return 'Low ❌ Need to attend more classes!';
  }

  @override
  Widget build(BuildContext context) {
    int percent = int.tryParse(percentage) ?? 0;
    Color color = getColor(percent);

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text('Attendance',
          style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: loadAttendance,
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
                Text('Loading attendance...'),
              ],
            ),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [

                // Main Attendance Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1A237E),
                        Color(0xFF3949AB)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Cumulative Attendance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '$percentage%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          getStatus(percent),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Progress Bar Card
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                      CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Your Attendance',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                          Text('$percentage%',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        ],
                      ),
                      SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: percent / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor:
                            AlwaysStoppedAnimation<Color>(color),
                          minHeight: 16,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Minimum required line
                      Row(
                        children: [
                          Icon(Icons.info_outline,
                            size: 16, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            'Minimum required: 75%',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Status Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: color.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        percent >= 75
                          ? Icons.check_circle
                          : Icons.warning,
                        color: color,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        percent >= 85
                          ? 'Excellent! Keep it up!'
                          : percent >= 75
                            ? 'Safe but try to improve!'
                            : 'Danger! Attend more classes!',
                        style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
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