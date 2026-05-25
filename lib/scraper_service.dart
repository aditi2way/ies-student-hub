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
      static Future<List<Map<String, dynamic>>>
    fetchCollegeNotices() async {
  try {
    String html = await AuthService.fetchPage(
      'https://ies.ipsacademy.org/'
    );

    var document = parser.parse(html);
    List<Map<String, dynamic>> notices = [];

    // Get notice board items
    var noticeItems = document
      .querySelectorAll('.category-notice-board a, ul li a');

    for (var item in noticeItems) {
      String title = item.text.trim();
      String link = item.attributes['href'] ?? '';

      if (title.isNotEmpty && link.isNotEmpty &&
          link.contains('ipsacademy')) {
        notices.add({
          'title': title,
          'link': link,
          'date': '',
          'type': 'Notice',
        });
      }
    }
    return notices;

  } catch (e) {
    print('Notice error: $e');
    return [];
  }
}

static Future<List<Map<String, dynamic>>>
    fetchCollegeEvents() async {
  try {
    String html = await AuthService.fetchPage(
      'https://ies.ipsacademy.org/'
    );

    var document = parser.parse(html);
    List<Map<String, dynamic>> events = [];

    var eventItems = document
      .querySelectorAll('.category-upcoming a');

    for (var item in eventItems) {
      String title = item.text.trim();
      String link = item.attributes['href'] ?? '';

      if (title.isNotEmpty) {
        events.add({
          'title': title,
          'link': link,
          'type': 'Event',
        });
      }
    }
    return events;

  } catch (e) {
    print('Events error: $e');
    return [];
  }
}

static Future<List<Map<String, dynamic>>>
    fetchCollegeNews() async {
  try {
    String html = await AuthService.fetchPage(
      'https://ies.ipsacademy.org/'
    );

    var document = parser.parse(html);
    List<Map<String, dynamic>> news = [];

    var newsItems = document
      .querySelectorAll('.category-recent a');

    for (var item in newsItems) {
      String title = item.text.trim();
      String link = item.attributes['href'] ?? '';

      if (title.isNotEmpty) {
        news.add({
          'title': title,
          'link': link,
          'type': 'News',
        });
      }
    }
    return news;

  } catch (e) {
    print('News error: $e');
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
  static Future<Map<String, dynamic>> 
    fetchProfile() async {
  try {
    String html = await AuthService.fetchPage(
      'https://cms2.ipsacademy.net/StudentND/IdentityCard'
    );

    var document = parser.parse(html);
    Map<String, dynamic> profile = {};

    // Get all text from page
    String fullText = document.body?.text ?? '';
    print('Profile text: $fullText');

    // Extract each field
    // Name
    RegExp nameReg = RegExp(r'Name\s*:\s*([^\n]+)');
    Match? nameMatch = nameReg.firstMatch(fullText);
    profile['name'] = nameMatch?.group(1)?.trim() ?? '';

    // Enrollment
    RegExp enrollReg = RegExp(r'Enrollment\s*:\s*([^\n]+)');
    Match? enrollMatch = enrollReg.firstMatch(fullText);
    profile['enrollment'] = 
      enrollMatch?.group(1)?.trim() ?? '';

    // Course
    RegExp courseReg = RegExp(r'Course\s*:\s*([^\n]+)');
    Match? courseMatch = courseReg.firstMatch(fullText);
    profile['course'] = courseMatch?.group(1)?.trim() ?? '';

    // Session
    RegExp sessionReg = RegExp(r'Session\s*:\s*([^\n]+)');
    Match? sessionMatch = sessionReg.firstMatch(fullText);
    profile['session'] = 
      sessionMatch?.group(1)?.trim() ?? '';

    // Phone
    RegExp phoneReg = RegExp(r'Phone\s*:\s*([^\n]+)');
    Match? phoneMatch = phoneReg.firstMatch(fullText);
    profile['phone'] = phoneMatch?.group(1)?.trim() ?? '';

    // Blood Group
    RegExp bloodReg = RegExp(r'Blood group\s*:\s*([^\n]+)');
    Match? bloodMatch = bloodReg.firstMatch(fullText);
    profile['blood_group'] = 
      bloodMatch?.group(1)?.trim() ?? '';

    // Computer Code
    RegExp codeReg = RegExp(r'Computer Code\s*:\s*([^\n]+)');
    Match? codeMatch = codeReg.firstMatch(fullText);
    profile['computer_code'] = 
      codeMatch?.group(1)?.trim() ?? '';

    // Photo URL
    var imgs = document.querySelectorAll('img');
for (var img in imgs) {
  String src = img.attributes['src'] ?? '';
  // Student photos are in Student_Photograph folder
  if (src.contains('Student_Photograph') ||
      src.contains('uploads')) {
    profile['photo'] = src.startsWith('http')
      ? src
      : 'https://cms2.ipsacademy.net/$src';
    print('Photo found: ${profile['photo']}');
    break;
  }
}

    return profile;

  } catch (e) {
    print('Profile error: $e');
    return {};
  }
}
}