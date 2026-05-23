import 'package:flutter/material.dart';

class AssignmentScreen extends StatefulWidget {
  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Pending', 'Submitted', 'Overdue'];

  final List<Map<String, dynamic>> assignments = [
    {
      'title': 'Data Structures Assignment',
      'subject': 'Computer Science',
      'dueDate': '25 May 2026',
      'status': 'Pending',
      'description': 'Implement Binary Search Tree with all operations.',
    },
    {
      'title': 'Integration Problems',
      'subject': 'Mathematics',
      'dueDate': '23 May 2026',
      'status': 'Overdue',
      'description': 'Solve problems from chapter 5, exercises 1-20.',
    },
    {
      'title': 'Lab Report — Pendulum',
      'subject': 'Physics',
      'dueDate': '20 May 2026',
      'status': 'Submitted',
      'description': 'Write lab report for simple pendulum experiment.',
    },
    {
      'title': 'Essay — My College Life',
      'subject': 'English',
      'dueDate': '28 May 2026',
      'status': 'Pending',
      'description': 'Write a 500 word essay about your college experience.',
    },
    {
      'title': 'Titration Experiment',
      'subject': 'Chemistry',
      'dueDate': '18 May 2026',
      'status': 'Submitted',
      'description': 'Submit observations and calculations for titration.',
    },
    {
      'title': 'Flutter App Project',
      'subject': 'Computer Science',
      'dueDate': '30 May 2026',
      'status': 'Pending',
      'description': 'Build a mobile app using Flutter framework.',
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending': return Colors.orange;
      case 'Submitted': return Colors.green;
      case 'Overdue': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Pending': return Icons.pending;
      case 'Submitted': return Icons.check_circle;
      case 'Overdue': return Icons.warning;
      default: return Icons.assignment;
    }
  }

  List<Map<String, dynamic>> get filteredAssignments {
    if (selectedFilter == 'All') return assignments;
    return assignments
      .where((a) => a['status'] == selectedFilter)
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    int pending = assignments
      .where((a) => a['status'] == 'Pending').length;
    int submitted = assignments
      .where((a) => a['status'] == 'Submitted').length;
    int overdue = assignments
      .where((a) => a['status'] == 'Overdue').length;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          'Assignments',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [

          // Stats Header
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFF1A237E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                assignmentStat(
                  '$pending', 'Pending', Colors.orange),
                assignmentStat(
                  '$submitted', 'Submitted', Colors.green),
                assignmentStat(
                  '$overdue', 'Overdue', Colors.red),
              ],
            ),
          ),

          // Filter Tabs
          Container(
            color: Color(0xFF1A237E),
            padding: EdgeInsets.only(bottom: 16, left: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((filter) {
                  bool isSelected = selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
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
                        filter,
                        style: TextStyle(
                          color: isSelected
                            ? Color(0xFF1A237E)
                            : Colors.white,
                          fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Assignment List
          Expanded(
            child: filteredAssignments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.assignment_turned_in,
                        size: 60, color: Colors.grey[300]),
                      SizedBox(height: 12),
                      Text(
                        'No $selectedFilter Assignments',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: filteredAssignments.length,
                  itemBuilder: (context, index) {
                    final assignment = filteredAssignments[index];
                    Color statusColor =
                      getStatusColor(assignment['status']);

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
                        crossAxisAlignment:
                          CrossAxisAlignment.start,
                        children: [

                          // Assignment Header
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      getStatusIcon(
                                        assignment['status']),
                                      color: statusColor,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      assignment['subject'],
                                      style: TextStyle(
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius:
                                      BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    assignment['status'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Assignment Content
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment:
                                CrossAxisAlignment.start,
                              children: [
                                Text(
                                  assignment['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF1A237E),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  assignment['description'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                      size: 14, color: Colors.grey),
                                    SizedBox(width: 4),
                                    Text(
                                      'Due: ${assignment['dueDate']}',
                                      style: TextStyle(
                                        color: assignment['status'] == 'Overdue'
                                          ? Colors.red
                                          : Colors.grey,
                                        fontSize: 13,
                                        fontWeight: assignment['status'] == 'Overdue'
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      ),
                                    ),
                                  ],
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

  Widget assignmentStat(
      String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}