import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  static final List<Map<String, dynamic>> courses = [
    {
      'name': 'Computer Science & Engineering',
      'short': 'CSE',
      'color': Colors.blue,
      'icon': Icons.computer,
      'syllabus': {
        'Semester 3': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-III-Sem-Scheme-and-Syllabus.pdf',
        'Semester 4': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-IV-Sem-Scheme-and-Syllabus.pdf',
        'Semester 5': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-V-Sem-Scheme-and-Syllabus.pdf',
        'Semester 6': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERC-VI-Sem-Syllabus-and-Scheme-w.e.f-2022.pdf',
        'Semester 7': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-VII-SEM-Scheme-Syllbus.pdf',
        'Semester 8': 'https://ies.ipsacademy.org/wp-content/uploads/2016/12/CSERL-VIII-SEM-Scheme-Syllabus.pdf',
      },
    },
    {
      'name': 'CS - Information Technology',
      'short': 'CS-IT',
      'color': Colors.green,
      'icon': Icons.info,
      'syllabus': <String, String>{},
    },
    {
      'name': 'CS - Artificial Intelligence & ML',
      'short': 'AI/ML',
      'color': Colors.purple,
      'icon': Icons.psychology,
      'syllabus': <String, String>{},
    },
    {
      'name': 'CS - Data Science',
      'short': 'DS',
      'color': Colors.orange,
      'icon': Icons.bar_chart,
      'syllabus': <String, String>{},
    },
    {
      'name': 'CS - IoT & Cyber Security',
      'short': 'IoT',
      'color': Colors.red,
      'icon': Icons.security,
      'syllabus': <String, String>{},
    },
    {
      'name': 'Mechanical Engineering',
      'short': 'ME',
      'color': Colors.grey,
      'icon': Icons.settings,
      'syllabus': <String, String>{},
    },
    {
      'name': 'Civil Engineering',
      'short': 'CE',
      'color': Colors.brown,
      'icon': Icons.domain,
      'syllabus': <String, String>{},
    },
    {
      'name': 'Electrical & Electronics',
      'short': 'EE',
      'color': Colors.amber,
      'icon': Icons.flash_on,
      'syllabus': <String, String>{},
    },
    {
      'name': 'Electronics & Communication',
      'short': 'EC',
      'color': Colors.teal,
      'icon': Icons.settings_input_antenna,
      'syllabus': <String, String>{},
    },
    {
      'name': 'Chemical Engineering',
      'short': 'CHE',
      'color': Colors.cyan,
      'icon': Icons.science,
      'syllabus': <String, String>{},
    },
    {
      'name': 'Fire Tech & Safety',
      'short': 'FTS',
      'color': Colors.deepOrange,
      'icon': Icons.local_fire_department,
      'syllabus': <String, String>{},
    },
  ];

  static Future<void> openPDF(String url) async {
    try {
      Uri uri = Uri.parse(url);
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print('Error opening URL: $e');
    }
  }

  static void showSyllabus(
    BuildContext context,
    Map<String, dynamic> course,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
          _SyllabusPage(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          'Courses & Syllabus',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          Color color = course['color'] as Color;

          return InkWell(
            onTap: () => showSyllabus(context, course),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius:
                        BorderRadius.circular(10),
                    ),
                    child: Icon(
                      course['icon'] as IconData,
                      color: color,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                        CrossAxisAlignment.start,
                      children: [
                        Text(
                          course['name'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius:
                              BorderRadius.circular(4),
                          ),
                          child: Text(
                            course['short'] as String,
                            style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Separate full page for syllabus
class _SyllabusPage extends StatelessWidget {
  final Map<String, dynamic> course;
  const _SyllabusPage({required this.course});

  @override
  Widget build(BuildContext context) {
    Map<String, String> syllabus =
      Map<String, String>.from(
        course['syllabus'] as Map);
    Color color = course['color'] as Color;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          '${course['short']} Syllabus',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: syllabus.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment:
                MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hourglass_empty,
                  color: Colors.orange,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  'Coming Soon!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Syllabus for ${course['name']}\nwill be added soon',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1A237E),
                      Color(0xFF3949AB),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius:
                          BorderRadius.circular(10),
                      ),
                      child: Icon(
                        course['icon'] as IconData,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                          CrossAxisAlignment.start,
                        children: [
                          Text(
                            course['name'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${syllabus.length} Semesters Available',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // PDF List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: syllabus.length,
                  itemBuilder: (context, index) {
                    String sem =
                      syllabus.keys.elementAt(index);
                    String url =
                      syllabus.values.elementAt(index);

                    return InkWell(
                      onTap: () async {
                        try {
                          Uri uri = Uri.parse(url);
                          await launchUrl(
                            uri,
                            mode: LaunchMode
                              .externalApplication,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Could not open PDF'),
                                backgroundColor:
                                  Colors.red,
                              ),
                            );
                        }
                      },
                      borderRadius:
                        BorderRadius.circular(12),
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 12),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                            BorderRadius.circular(12),
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
                            Container(
                              padding:
                                EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red
                                  .withOpacity(0.1),
                                borderRadius:
                                  BorderRadius
                                    .circular(8),
                              ),
                              child: Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                  CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    sem,
                                    style: TextStyle(
                                      fontWeight:
                                        FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(
                                        0xFF1A237E),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Tap to open PDF',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.open_in_new,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
    );
  }
}