import 'package:flutter/material.dart';

class CGPACalculator extends StatefulWidget {
  const CGPACalculator({super.key});

  @override
  State<CGPACalculator> createState() => _CGPACalculatorState();
}

class _CGPACalculatorState extends State<CGPACalculator> {

  final List<TextEditingController> sgpaControllers = [];

  double cgpa = 0.0;

  @override
  void initState() {
    super.initState();
    addSemester();
  }

  void addSemester() {
    setState(() {
      sgpaControllers.add(TextEditingController());
    });
  }

  void calculateCGPA() {

    double total = 0;

    for (var controller in sgpaControllers) {
      total += double.tryParse(controller.text) ?? 0;
    }

    setState(() {

      cgpa = sgpaControllers.isEmpty
          ? 0
          : total / sgpaControllers.length;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: sgpaControllers.length,

              itemBuilder: (context, index) {

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),

                    child: TextField(
                      controller: sgpaControllers[index],

                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: "Semester ${index + 1} SGPA",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: addSemester,
            child: const Text("+ Add Semester"),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: calculateCGPA,
            child: const Text("Calculate CGPA"),
          ),

          const SizedBox(height: 20),

          Text(
            "CGPA: ${cgpa.toStringAsFixed(2)}",

            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}