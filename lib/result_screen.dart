import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final List<Map<String, dynamic>> results = [
    {
      'subject': 'Mathematics',
      'internal': 38,
      'external': 72,
      'total': 110,
      'max': 150,
      'grade': 'B+',
    },
    {
      'subject': 'Physics',
      'internal': 35,
      'external': 68,
      'total': 103,
      'max': 150,
      'grade': 'B',
    },
    {
      'subject': 'Computer Science',
      'internal': 45,
      'external': 85,
      'total': 130,
      'max': 150,
      'grade': 'A+',
    },
    {
      'subject': 'English',
      'internal': 30,
      'external': 65,
      'total': 95,
      'max': 150,
      'grade': 'B',
    },
    {
      'subject': 'Chemistry',
      'internal': 32,
      'external': 60,
      'total': 92,
      'max': 150,
      'grade': 'C+',
    },
  ];

  Color getGradeColor(String grade) {
    if (grade.contains('A')) return Colors.green;
    if (grade.contains('B')) return Colors.blue;
    if (grade.contains('C')) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    double totalMarks = results.fold(
        0, (sum, item) => sum + item['total']);
    double maxMarks = results.fold(
        0, (sum, item) => sum + item['max']);
    double percentage = (totalMarks / maxMarks) * 100;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          'Results',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // Overall Result Card
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
                children: [
                  Text(
                    'Overall Performance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${totalMarks.toInt()} / ${maxMarks.toInt()} marks',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Subject wise results
            ...results.map((result) {
              return Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          result['subject'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Grade Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: getGradeColor(result['grade'])
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: getGradeColor(result['grade']),
                            ),
                          ),
                          child: Text(
                            result['grade'],
                            style: TextStyle(
                              color: getGradeColor(result['grade']),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Marks Row
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        markBox('Internal',
                            '${result['internal']}', Colors.purple),
                        markBox('External',
                            '${result['external']}', Colors.blue),
                        markBox('Total',
                            '${result['total']}/${result['max']}',
                            Colors.green),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget markBox(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}