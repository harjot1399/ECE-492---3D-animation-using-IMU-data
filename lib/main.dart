import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:convert';
void main() {
  runApp(const MyApp());
  runfiles();
}

void runfiles() async {
  try {
    Directory current = Directory.current;
    var scriptPath = p.join(current.path, 'backend/data_export_new.py');
    var unityPath = p.join(current.path, 'unity_project/My project.exe');
    Process process = await Process.start('python3', [scriptPath]);
    Process unityProcess = await Process.start('"$unityPath"', []);

    // Listen to the output from the Python script and print each line
    process.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      print('Python stdout: $line');
    });

    // Listen to the error output from the Python script and print each line
    process.stderr.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      print('Python stderr: $line');
    });

    // Listen to the output from the Unity process and print each line
    unityProcess.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      print('Unity stdout: $line');
    });

    // Listen to the error output from the Unity process and print each line
    unityProcess.stderr.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      print('Unity stderr: $line');
    });

    // Wait for the script to finish running
    int pythonExitCode = await process.exitCode;
    int unityExitCode = await unityProcess.exitCode;
    print('Python process exited with code $pythonExitCode');
    print('Unity process exited with code $unityExitCode');
  } catch (e) {
    print("Path Error");
    print(e);
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage()
    );
  }
}


