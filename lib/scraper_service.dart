import 'package:html/parser.dart' as parser;
import 'auth_service.dart';

class ScraperService {

  // Fetch Real Attendance
  static Future<Map<String, dynamic>> fetchAttendance() async {
  try {
    String html = await AuthService.fetchPage(
      'https://cms2.ipsacademy.net/StudentND/view_attendence'
    );

    // Parse the simple text response
    String percentage = '0';
    
    if (html.contains('cumulative_attendance:')) {
      // Extract percentage number
      RegExp regExp = RegExp(r'cumulative_attendance:\s*(\d+)%');
      Match? match = regExp.firstMatch(html);
      if (match != null) {
        percentage = match.group(1) ?? '0';
      }
    }

    return {
      'percentage': percentage,
      'message': 'Your till date cumulative attendance: $percentage%',
    };

  } catch (e) {
    print('Attendance error: $e');
    return {
      'percentage': '0',
      'message': 'Could not load attendance',
    };
  }
}

      
  // Fetch Real Results
  static Future<List<Map<String, dynamic>>> 
      fetchResults() async {
    try {
      String html = await AuthService.fetchPage(
        'https://cms2.ipsacademy.net/Student/View_report'
      );

      var document = parser.parse(html);
      List<Map<String, dynamic>> results = [];

      var rows = document.querySelectorAll('table tr');
      for (var row in rows) {
        var cells = row.querySelectorAll('td');
        if (cells.length >= 3) {
          String subject = cells[0].text.trim();
          if (subject.isNotEmpty) {
            results.add({
              'subject': subject,
              'internal': cells[1].text.trim(),
              'external': cells[2].text.trim(),
              'total': cells.length > 3 
                ? cells[3].text.trim() : '-',
            });
          }
        }
      }
      return results;

    } catch (e) {
      print('Results error: $e');
      return [];
    }
      }
    static Future<List<Map<String, dynamic>>>
    fetchMST() async {
  try {
    String html = await AuthService.fetchPage(
      'https://cms2.ipsacademy.net/Student/CombineMST'
    );

    var document = parser.parse(html);
    List<Map<String, dynamic>> mstList = [];

    var rows = document.querySelectorAll('table tr');
    
    for (var row in rows) {
      var cells = row.querySelectorAll('td');
      
      // Need at least 4 columns
      // S.No | Subject | MST1 | MST2
      if (cells.length >= 3) {
        String subject = cells[1].text.trim();
        
        // Skip header row
        if (subject.isEmpty ||
            subject == 'Subject Name' ||
            subject == 'Subject') continue;

        String mst1 = cells.length > 2
          ? cells[2].text.trim() : '-';
        String mst2 = cells.length > 3
          ? cells[3].text.trim() : '-';

        mstList.add({
          'subject': subject,
          'mst1': mst1,
          'mst1_total': '10',
          'mst2': mst2,
          'mst2_total': '15',
        });
      }
    }
    return mstList;

  } catch (e) {
    print('MST error: $e');
    return [];
  }
}
  

  // Fetch Student Name
  static Future<String> fetchStudentName() async {
    try {
      String html = await AuthService.fetchPage(
        'https://cms2.ipsacademy.net/Student'
      );

      var document = parser.parse(html);
      
      var nameEl = 
        document.querySelector('.student-name') ??
        document.querySelector('.profile-info h4') ??
        document.querySelector('h4');

      return nameEl?.text.trim() ?? 'Student';

    } catch (e) {
      return 'Student';
    }
  }

  // Fetch Notices
  static Future<List<Map<String, dynamic>>> 
      fetchNotices() async {
    try {
      String html = await AuthService.fetchPage(
        'https://cms2.ipsacademy.net/Student'
      );

      var document = parser.parse(html);
      List<Map<String, dynamic>> notices = [];

      var items = document.querySelectorAll(
        '.notice-item, .announcement, .alert');
      
      for (var item in items) {
        notices.add({
          'title': item.text.trim(),
          'date': '',
        });
      }
      return notices;

    } catch (e) {
      return [];
    }
  }
}