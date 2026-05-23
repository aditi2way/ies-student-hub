import 'package:flutter/material.dart';

class NoticesScreen extends StatefulWidget {
  @override
  _NoticesScreenState createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  final List<Map<String, String>> notices = [
    {
      'title': 'End Semester Exam Schedule',
      'description': 'End semester examinations will begin from 15th June 2026. Students are advised to check their hall tickets.',
      'date': '22 May 2026',
      'category': 'Exam',
    },
    {
      'title': 'Annual Sports Day',
      'description': 'Annual Sports Day will be held on 1st June 2026. All students are encouraged to participate.',
      'date': '20 May 2026',
      'category': 'Event',
    },
    {
      'title': 'Library Fine Notice',
      'description': 'Students with pending library books must return them before 30th May to avoid fine.',
      'date': '18 May 2026',
      'category': 'General',
    },
    {
      'title': 'Scholarship Form Deadline',
      'description': 'Last date to submit scholarship forms is 25th May 2026. Submit to the admin office.',
      'date': '15 May 2026',
      'category': 'Important',
    },
    {
      'title': 'Industrial Visit',
      'description': 'Industrial visit to Tech Park scheduled for 5th June. Register with your department coordinator.',
      'date': '12 May 2026',
      'category': 'Event',
    },
    {
      'title': 'Fee Payment Reminder',
      'description': 'Last date for fee payment is 31st May 2026. Pay online through college portal.',
      'date': '10 May 2026',
      'category': 'Important',
    },
  ];

  String selectedCategory = 'All';
  final List<String> categories = [
    'All', 'Exam', 'Event', 'Important', 'General'
  ];

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Exam': return Colors.red;
      case 'Event': return Colors.blue;
      case 'Important': return Colors.orange;
      case 'General': return Colors.green;
      default: return Colors.grey;
    }
  }

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Exam': return Icons.assignment;
      case 'Event': return Icons.event;
      case 'Important': return Icons.priority_high;
      case 'General': return Icons.info;
      default: return Icons.notifications;
    }
  }

  List<Map<String, String>> get filteredNotices {
    if (selectedCategory == 'All') return notices;
    return notices
      .where((n) => n['category'] == selectedCategory)
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          'Notices',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [

          // Category Filter
          Container(
            color: Color(0xFF1A237E),
            padding: EdgeInsets.only(bottom: 16, left: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  bool isSelected = selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                          ? Colors.white
                          : Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                            ? Color(0xFF1A237E)
                            : Colors.white,
                          fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Notices Count
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '${filteredNotices.length} Notices',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Notices List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredNotices.length,
              itemBuilder: (context, index) {
                final notice = filteredNotices[index];
                Color color = getCategoryColor(
                  notice['category']!);

                return Container(
                  margin: EdgeInsets.only(bottom: 12),
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
                      // Notice Header
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              getCategoryIcon(notice['category']!),
                              color: color,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius:
                                  BorderRadius.circular(4),
                              ),
                              child: Text(
                                notice['category']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              notice['date']!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Notice Content
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment:
                            CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF1A237E),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              notice['description']!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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