import 'package:flutter/material.dart';

class GPAGoalPredictor extends StatefulWidget {
  const GPAGoalPredictor({super.key});

  @override
  State<GPAGoalPredictor> createState() =>
      _GPAGoalPredictorState();
}

class _GPAGoalPredictorState
    extends State<GPAGoalPredictor> {

  final currentCgpaController = TextEditingController();
  final targetCgpaController = TextEditingController();
  final completedSemController = TextEditingController();

  String result = "";

  void calculateGoal() {

    double current =
        double.tryParse(currentCgpaController.text) ?? 0;

    double target =
        double.tryParse(targetCgpaController.text) ?? 0;

    int completed =
        int.tryParse(completedSemController.text) ?? 0;

    int totalSemesters = 8;

    int remaining = totalSemesters - completed;

    // Validation
    if (remaining <= 0) {

      setState(() {
        result = "Invalid semester input";
      });

      return;
    }

    double needed =
        ((target * totalSemesters) -
                (current * completed)) /
            remaining;

    setState(() {

      result =
          "You need average SGPA "
          "${needed.toStringAsFixed(2)} "
          "in remaining semesters";

    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [

          TextField(
            controller: currentCgpaController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Current CGPA",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: targetCgpaController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Target CGPA",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: completedSemController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Completed Semesters",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: calculateGoal,
            child: const Text("Predict"),
          ),

          const SizedBox(height: 30),

          Text(
            result,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}