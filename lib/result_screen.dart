import 'package:flutter/material.dart';
import 'scraper_service.dart';
import 'auth_service.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedSession = '30';
  bool sessionChanging = false;
  final Map<String, String> sessions = {
    '30': '2025-2026 (Jan-June)',
    '29': '2025-2026 (July-Dec)',
    '28': '2024-2025 (Jan-June)',
    '27': '2024-2025 (July-Dec)',
  };

  List<Map<String, dynamic>> mstData = [];
  bool mstLoading = true;
  String mstError = '';

  List<Map<String, dynamic>> resultsData = [];
  bool resultsLoading = true;
  String resultsError = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadMST();
    loadResults();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void loadMST() async {
    setState(() {
      mstLoading = true;
      mstError = '';
    });
    List<Map<String, dynamic>> data = await ScraperService.fetchMST();
    setState(() {
      mstLoading = false;
      if (data.isEmpty) {
        mstError = 'Could not load MST data';
      } else {
        mstData = data;
      }
    });
  }

  void loadResults() async {
    setState(() {
      resultsLoading = true;
      resultsError = '';
    });
    List<Map<String, dynamic>> data = await ScraperService.fetchResults();
    setState(() {
      resultsLoading = false;
      if (data.isEmpty) {
        resultsError = 'Could not load results';
      } else {
        resultsData = data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text('Results & MST', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              loadMST();
              loadResults();
            },
          ),
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: Column(
            children: [
              // SESSION DROPDOWN
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: sessionChanging
                    ? Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Changing session...',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : DropdownButton<String>(
                        value: selectedSession,
                        dropdownColor: Color(0xFF1A237E),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                        underline: SizedBox(),
                        isExpanded: true,
                        items: sessions.entries.map((entry) {
                          return DropdownMenuItem(
                            value: entry.key,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) async {
                          if (value != null && value != selectedSession) {
                            setState(() {
                              sessionChanging = true;
                              selectedSession = value;
                            });

                            bool success = await AuthService.changeSession(
                              value,
                            );

                            if (success) {
                              loadMST();
                              loadResults();
                            }

                            setState(() {
                              sessionChanging = false;
                            });
                          }
                        },
                      ),
              ),

              // TAB BAR
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                tabs: [
                  Tab(icon: Icon(Icons.assignment), text: 'MST Marks'),
                  Tab(icon: Icon(Icons.grade), text: 'Exam Results'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ── Tab 1: MST Marks ──
          mstLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF1A237E)),
                      SizedBox(height: 16),
                      Text('Loading MST marks...'),
                    ],
                  ),
                )
              : mstError.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60, color: Colors.red),
                      SizedBox(height: 12),
                      Text(mstError),
                      SizedBox(height: 12),
                      ElevatedButton(onPressed: loadMST, child: Text('Retry')),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Header
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
                              'MST Marks',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${mstData.length} Subjects',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '2025-2026 (Jan-June)',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      // MST Cards
                      ...mstData.map((mst) {
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
                              Text(
                                mst['subject'] ?? '-',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  // MST 1
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.blue.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'MST - 1',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            mst['mst1'] == '-' ||
                                                    mst['mst1']
                                                        .toString()
                                                        .isEmpty
                                                ? 'N/A'
                                                : '${mst['mst1']}/10',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  // MST 2
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.green.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'MST - 2',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            mst['mst2'] == '-' ||
                                                    mst['mst2']
                                                        .toString()
                                                        .isEmpty
                                                ? 'N/A'
                                                : '${mst['mst2']}/15',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

          // ── Tab 2: Exam Results ──
          resultsLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF1A237E)),
                      SizedBox(height: 16),
                      Text('Loading results...'),
                    ],
                  ),
                )
              : resultsError.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60, color: Colors.red),
                      SizedBox(height: 12),
                      Text(resultsError),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: loadResults,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Header
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
                              'Exam Results',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${resultsData.length} Subjects',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '2025-2026 (Jan-June)',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      // Results Cards
                      ...resultsData.map((result) {
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
                              Text(
                                result['subject'] ?? '-',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  markBox(
                                    'Internal',
                                    result['internal'] ?? '-',
                                    Colors.purple,
                                  ),
                                  markBox(
                                    'External',
                                    result['external'] ?? '-',
                                    Colors.blue,
                                  ),
                                  markBox(
                                    'Total',
                                    result['total'] ?? '-',
                                    Colors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget markBox(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
