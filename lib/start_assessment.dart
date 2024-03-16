import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StartAssessment extends StatefulWidget {
  const StartAssessment({super.key});

  @override
  State<StartAssessment> createState() => _StartAssessmentState();
}

class _StartAssessmentState extends State<StartAssessment> {
  final TextEditingController filename = TextEditingController();

  Future<void> startRecording() async {
    final uri = Uri.parse('http://localhost:8080/');
    await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'command': 'start'}),
    );
  }

  Future<void> stopRecording() async {
    final uri = Uri.parse('http://localhost:8080/');
    await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'command': 'stop'}),
    );
  }

  Future<void> disposeRecording() async {
    final uri = Uri.parse('http://localhost:8080/');
    await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'command': 'discard'}),
    );
  }

  Future<void> saveRecording() async {
    final uri = Uri.parse('http://localhost:8080/');
    await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'command': 'save'}),
    );
  }

  final List<FlSpot> data = [
    const FlSpot(0, 1),
    const FlSpot(1, 3),
    const FlSpot(2, 10),
    // Add as many points as you need
  ];

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to save the session'),
          content: TextField(controller: filename,),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                disposeRecording();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Save'),
              onPressed: () {
                saveRecording();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfcfcfb),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Row(
                  children: [
                    const Text("Assessment", style: TextStyle(fontSize: 30),),
                    const SizedBox(width: 1070,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius here
                      ),
                      color: Colors.grey,
                      elevation: 5.0,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){if (kDebugMode) {
                            print("start recording");
                          }
                          startRecording();

                          }, icon: const Icon(Icons.play_arrow_sharp, color: Colors.white,)),
                          IconButton(onPressed: (){if (kDebugMode) {
                            print("stop recording");
                          }
                          stopRecording();
                          _dialogBuilder(context);
                            }, icon: const Icon(Icons.pause, color: Colors.white,)),

                        ],
                      ),
                    )

                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Adjust the radius here
                  ),
                  color: Colors.grey,
                  elevation: 5.0,
                  child: Container(
                    width: 1325, // Specify your custom width
                    height: 500, // Specify your custom height
                    padding: const EdgeInsets.all(16.0), // Add some padding if needed
                    child: const Text('Animation will come here', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius here
                      ),
                      elevation: 5.0,
                      color: Colors.grey,
                      child: Container(
                        width: 430, // Specify your custom width
                        height: 300, // Specify your custom height
                        padding: const EdgeInsets.all(8.0), // Add some padding if needed
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: data,
                                isCurved: true,
                                barWidth:3,
                                color: Colors.black,
                                belowBarData: BarAreaData(show: false),
                                dotData: const FlDotData(show: false),
                              )
                            ]
                          )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust the radius here
                    ),
                    elevation: 5.0,
                    color: Colors.grey,
                    child: Container(
                      width: 430, // Specify your custom width
                      height: 300, // Specify your custom height
                      padding: const EdgeInsets.all(16.0), // Add some padding if needed
                      child: LineChart(
                          LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots: data,
                                  isCurved: true,
                                  barWidth:3,
                                  color: Colors.black,
                                  belowBarData: BarAreaData(show: false),
                                  dotData: const FlDotData(show: false),
                                )
                              ]
                          )
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius here
                      ),
                      elevation: 5.0,
                      color: Colors.grey,
                      child: Container(
                        width: 430, // Specify your custom width
                        height: 300, // Specify your custom height
                        padding: const EdgeInsets.all(16.0), // Add some padding if needed
                        child: LineChart(
                            LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: data,
                                    isCurved: true,
                                    barWidth:3,
                                    color: Colors.black,
                                    belowBarData: BarAreaData(show: false),
                                    dotData: const FlDotData(show: false),
                                  )
                                ]
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
