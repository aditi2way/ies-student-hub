import 'package:flutter/material.dart';
import 'scraper_service.dart';

class MSTScreen extends StatefulWidget {
  @override
  _MSTScreenState createState() => _MSTScreenState();
}

class _MSTScreenState extends State<MSTScreen> {
  List<Map<String, dynamic>> mstData = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    loadMST();
  }

  void loadMST() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    List<Map<String, dynamic>> data =
      await ScraperService.fetchMST();

    setState(() {
      isLoading = false;
      if (data.isEmpty) {
        error = 'Could not load MST data';
      } else {
        mstData = data;
      }
    });
  }

  Color getMarksColor(int marks, int total) {
    double percent = (marks / total) * 100;
    if (percent >= 70) return Colors.green;
    if (percent >= 50) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text('MST Marks',
          style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: loadMST,
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
                Text('Loading MST marks...'),
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
                    onPressed: loadMST,
                    child: Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [

                  // Header Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
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
                        Text('MST Marks',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14)),
                        SizedBox(height: 8),
                        Text('${mstData.length} Subjects',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold)),
                        Text('2025-2026 (Jan-June)',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13)),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // MST List
                  ...mstData.map((mst) {
                    int marks = int.tryParse(
                      mst['marks'].toString()) ?? 0;
                    int total = int.tryParse(
                      mst['total'].toString()) ?? 30;
                    Color color = getMarksColor(marks, total);

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
                            offset: Offset(0, 2)),
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
                              Expanded(
                                child: Text(
                                  mst['subject'] ?? '-',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF1A237E)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius:
                                    BorderRadius.circular(8),
                                  border: Border.all(
                                    color: color)),
                                child: Text(
                                  '$marks/$total',
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          ClipRRect(
                            borderRadius:
                              BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: total > 0
                                ? marks / total : 0,
                              backgroundColor: Colors.grey[200],
                              valueColor:
                                AlwaysStoppedAnimation<Color>(
                                  color),
                              minHeight: 8,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '${total > 0 ? ((marks/total)*100).toStringAsFixed(1) : 0}%',
                            style: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
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
}