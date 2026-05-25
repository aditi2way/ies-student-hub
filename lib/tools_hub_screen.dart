import 'package:flutter/material.dart';

import 'sgpa_calculator_screen1.dart';
import 'cgpa_calculator_screen.dart';
import 'gpa_goal_predictor_screen.dart';

class ToolsHubScreen extends StatelessWidget {
  const ToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student Tools"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "SGPA"),
              Tab(text: "CGPA"),
              Tab(text: "Goal"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SGPACalculator(),
            CGPACalculator(),
            GPAGoalPredictor(),
          ],
        ),
      ),
    );
  }
}