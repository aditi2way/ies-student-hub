import 'package:flutter/material.dart';

class SGPACalculator extends StatefulWidget {
  const SGPACalculator({super.key});

  @override
  State<SGPACalculator> createState() => _SGPACalculatorState();
}

class _SGPACalculatorState extends State<SGPACalculator> {

  final List<TextEditingController> creditControllers = [];
  final List<String> grades = [];

  double sgpa = 0.0;

  final Map<String, double> gradePoints = {
    'O': 10,
    'A+': 9,
    'A': 8,
    'B+': 7,
    'B': 6,
    'C': 5,
    'F': 0,
  };

  @override
  void initState() {
    super.initState();
    addSubject();
  }

  void addSubject() {
    setState(() {
      creditControllers.add(TextEditingController());
      grades.add('O');
    });
  }

  void calculateSGPA() {
    double totalCredits = 0;
    double totalPoints = 0;

    for (int i = 0; i < creditControllers.length; i++) {

      double credit =
          double.tryParse(creditControllers[i].text) ?? 0;

      double gradePoint = gradePoints[grades[i]]!;

      totalCredits += credit;
      totalPoints += credit * gradePoint;
    }

    setState(() {
      sgpa = totalCredits == 0
          ? 0
          : totalPoints / totalCredits;
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
              itemCount: creditControllers.length,
              itemBuilder: (context, index) {

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),

                    child: Column(
                      children: [

                        Text(
                          "Subject ${index + 1}",
                          style: const TextStyle(fontSize: 18),
                        ),

                        const SizedBox(height: 10),

                        TextField(
                          controller: creditControllers[index],
                          keyboardType: TextInputType.number,

                          decoration: const InputDecoration(
                            labelText: "Credits",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          value: grades[index],

                          decoration: const InputDecoration(
                            labelText: "Grade",
                            border: OutlineInputBorder(),
                          ),

                          items: gradePoints.keys.map((grade) {
                            return DropdownMenuItem(
                              value: grade,
                              child: Text(grade),
                            );
                          }).toList(),

                          onChanged: (value) {
                            setState(() {
                              grades[index] = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: addSubject,
            child: const Text("+ Add Subject"),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: calculateSGPA,
            child: const Text("Calculate SGPA"),
          ),

          const SizedBox(height: 20),

          Text(
            "SGPA: ${sgpa.toStringAsFixed(2)}",
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