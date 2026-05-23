import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int selectedDay = DateTime.now().weekday - 1;

  final List<String> days = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
  ];

  final Map<int, List<Map<String, String>>> timetable = {
    0: [ // Monday
      {'subject': 'Mathematics', 'time': '9:00 - 10:00', 'room': 'R101', 'teacher': 'Prof. Sharma'},
      {'subject': 'Physics', 'time': '10:00 - 11:00', 'room': 'R102', 'teacher': 'Prof. Verma'},
      {'subject': 'Break', 'time': '11:00 - 11:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Computer Science', 'time': '11:30 - 12:30', 'room': 'Lab 1', 'teacher': 'Prof. Gupta'},
      {'subject': 'Lunch', 'time': '12:30 - 1:30', 'room': '-', 'teacher': '-'},
      {'subject': 'English', 'time': '1:30 - 2:30', 'room': 'R103', 'teacher': 'Prof. Singh'},
    ],
    1: [ // Tuesday
      {'subject': 'Chemistry', 'time': '9:00 - 10:00', 'room': 'R104', 'teacher': 'Prof. Patel'},
      {'subject': 'Mathematics', 'time': '10:00 - 11:00', 'room': 'R101', 'teacher': 'Prof. Sharma'},
      {'subject': 'Break', 'time': '11:00 - 11:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Physics Lab', 'time': '11:30 - 1:30', 'room': 'Lab 2', 'teacher': 'Prof. Verma'},
      {'subject': 'Lunch', 'time': '1:30 - 2:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Computer Science', 'time': '2:30 - 3:30', 'room': 'Lab 1', 'teacher': 'Prof. Gupta'},
    ],
    2: [ // Wednesday
      {'subject': 'English', 'time': '9:00 - 10:00', 'room': 'R103', 'teacher': 'Prof. Singh'},
      {'subject': 'Chemistry', 'time': '10:00 - 11:00', 'room': 'R104', 'teacher': 'Prof. Patel'},
      {'subject': 'Break', 'time': '11:00 - 11:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Mathematics', 'time': '11:30 - 12:30', 'room': 'R101', 'teacher': 'Prof. Sharma'},
      {'subject': 'Lunch', 'time': '12:30 - 1:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Physics', 'time': '1:30 - 2:30', 'room': 'R102', 'teacher': 'Prof. Verma'},
    ],
    3: [ // Thursday
      {'subject': 'Computer Science', 'time': '9:00 - 10:00', 'room': 'Lab 1', 'teacher': 'Prof. Gupta'},
      {'subject': 'English', 'time': '10:00 - 11:00', 'room': 'R103', 'teacher': 'Prof. Singh'},
      {'subject': 'Break', 'time': '11:00 - 11:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Chemistry Lab', 'time': '11:30 - 1:30', 'room': 'Lab 3', 'teacher': 'Prof. Patel'},
      {'subject': 'Lunch', 'time': '1:30 - 2:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Mathematics', 'time': '2:30 - 3:30', 'room': 'R101', 'teacher': 'Prof. Sharma'},
    ],
    4: [ // Friday
      {'subject': 'Physics', 'time': '9:00 - 10:00', 'room': 'R102', 'teacher': 'Prof. Verma'},
      {'subject': 'Computer Science', 'time': '10:00 - 11:00', 'room': 'Lab 1', 'teacher': 'Prof. Gupta'},
      {'subject': 'Break', 'time': '11:00 - 11:30', 'room': '-', 'teacher': '-'},
      {'subject': 'English', 'time': '11:30 - 12:30', 'room': 'R103', 'teacher': 'Prof. Singh'},
      {'subject': 'Lunch', 'time': '12:30 - 1:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Chemistry', 'time': '1:30 - 2:30', 'room': 'R104', 'teacher': 'Prof. Patel'},
    ],
    5: [ // Saturday
      {'subject': 'Mathematics', 'time': '9:00 - 10:00', 'room': 'R101', 'teacher': 'Prof. Sharma'},
      {'subject': 'Physics', 'time': '10:00 - 11:00', 'room': 'R102', 'teacher': 'Prof. Verma'},
      {'subject': 'Break', 'time': '11:00 - 11:30', 'room': '-', 'teacher': '-'},
      {'subject': 'Computer Science', 'time': '11:30 - 12:30', 'room': 'Lab 1', 'teacher': 'Prof. Gupta'},
    ],
  };

  Color getSubjectColor(String subject) {
    if (subject == 'Break' || subject == 'Lunch') 
      return Colors.grey;
    if (subject.contains('Lab')) return Colors.purple;
    if (subject == 'Mathematics') return Colors.blue;
    if (subject == 'Physics') return Colors.green;
    if (subject == 'Computer Science') return Colors.orange;
    if (subject == 'English') return Colors.red;
    if (subject == 'Chemistry') return Colors.teal;
    return Colors.indigo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text(
          'Timetable',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [

          // Day Selector
          Container(
            color: Color(0xFF1A237E),
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(days.length, (index) {
                bool isSelected = selectedDay == index;
                bool isToday = DateTime.now().weekday - 1 == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                        ? Colors.white
                        : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isToday && !isSelected
                        ? Border.all(color: Colors.white54)
                        : null,
                    ),
                    child: Text(
                      days[index],
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
              }),
            ),
          ),

          // Classes List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: timetable[selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                final cls = timetable[selectedDay]![index];
                bool isBreak = cls['subject'] == 'Break' ||
                               cls['subject'] == 'Lunch';
                Color color = getSubjectColor(cls['subject']!);

                if (isBreak) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cls['subject']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          cls['time']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }

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
                  child: Row(
                    children: [
                      // Color Bar
                      Container(
                        width: 6,
                        height: 80,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      // Class Info
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment:
                              CrossAxisAlignment.start,
                            children: [
                              Text(
                                cls['subject']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                    size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    cls['time']!,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.room,
                                    size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    cls['room']!,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(Icons.person,
                                    size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    cls['teacher']!,
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