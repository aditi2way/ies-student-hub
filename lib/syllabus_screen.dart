import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SyllabusScreen extends StatelessWidget {
  final Map<String, dynamic> course;
  const SyllabusScreen({required this.course});

  void openPDF(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
        mode: LaunchMode.externalApplication);
    }
  }

  // Get syllabus based on course short name
  Map<String, String> getSyllabus() {
    String short = course['short'] as String;

    switch (short) {
      case 'CSE':
        return {
          'Semester 3': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-III-Sem-Scheme-and-Syllabus.pdf',
          'Semester 4': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-IV-Sem-Scheme-and-Syllabus.pdf',
          'Semester 5': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-V-Sem-Scheme-and-Syllabus.pdf',
          'Semester 6': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERC-VI-Sem-Syllabus-and-Scheme-w.e.f-2022.pdf',
          'Semester 7': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-VII-SEM-Scheme-Syllbus.pdf',
          'Semester 8': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-VIII-SEM-Scheme-Syllabus.pdf',
        };

      case 'CE':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'ME':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'EC':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'EE':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'CHE':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'AI/ML':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'DS':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'IoT':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'CS-IT':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      case 'FTS':
        return {
          'Semester 3': '',  // Add URL
          'Semester 4': '',
          'Semester 5': '',
          'Semester 6': '',
          'Semester 7': '',
          'Semester 8': '',
        };

      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> syllabus = getSyllabus();

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text('Scheme & Syllabus',
          style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF3949AB)
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    course['icon'] as IconData,
                    color: Colors.white,
                    size: 36),
                  SizedBox(height: 8),
                  Text(
                    course['name'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '2022 Onwards Admitted Students',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text('Semester Wise Syllabus',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E))),
            SizedBox(height: 12),

            // Check if syllabus available
            if (syllabus.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.hourglass_empty,
                      color: Colors.orange, size: 48),
                    SizedBox(height: 12),
                    Text('Syllabus Coming Soon!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A237E))),
                    SizedBox(height: 4),
                    Text(
                      'Will be added soon',
                      style: TextStyle(
                        color: Colors.grey)),
                  ],
                ),
              )
            else
              // Semester Cards
              ...syllabus.entries.map((entry) {
                bool hasUrl = entry.value.isNotEmpty;
                return GestureDetector(
                  onTap: hasUrl
                    ? () => openPDF(entry.value)
                    : null,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                        BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: hasUrl
                              ? Colors.red.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                            borderRadius:
                              BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: hasUrl
                              ? Colors.red
                              : Colors.grey,
                            size: 28),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                              CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: TextStyle(
                                  fontWeight:
                                    FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF1A237E)),
                              ),
                              Text(
                                hasUrl
                                  ? 'Tap to open PDF'
                                  : 'Coming Soon',
                                style: TextStyle(
                                  color: hasUrl
                                    ? Colors.grey
                                    : Colors.orange,
                                  fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          hasUrl
                            ? Icons.arrow_forward_ios
                            : Icons.lock_outline,
                          size: 16,
                          color: hasUrl
                            ? Colors.grey
                            : Colors.orange),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}