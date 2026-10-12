import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final sectionController = TextEditingController();
  final courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: sectionController,
              decoration: const InputDecoration(
                labelText: 'Section',
              ),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectEnrollmentPage(
                      name: nameController.text,
                      section: sectionController.text,
                      course: courseController.text,
                    ),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectEnrollmentPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;

  const SubjectEnrollmentPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
  });

  @override
  State<SubjectEnrollmentPage> createState() =>
      _SubjectEnrollmentPageState();
}

class _SubjectEnrollmentPageState
    extends State<SubjectEnrollmentPage> {
  final subject1Controller = TextEditingController();
  final time1Controller = TextEditingController();
  final subject2Controller = TextEditingController();
  final time2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Enrollment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: subject1Controller,
              decoration: const InputDecoration(
                labelText: 'Subject',
              ),
            ),
            TextField(
              controller: time1Controller,
              decoration: const InputDecoration(
                labelText: 'Time',
              ),
            ),
            TextField(
              controller: subject2Controller,
              decoration: const InputDecoration(
                labelText: 'Subject',
              ),
            ),
            TextField(
              controller: time2Controller,
              decoration: const InputDecoration(
                labelText: 'Time',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectVerificationPage(
                      name: widget.name,
                      section: widget.section,
                      course: widget.course,
                      subject1: subject1Controller.text,
                      time1: time1Controller.text,
                      subject2: subject2Controller.text,
                      time2: time2Controller.text,
                    ),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectVerificationPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;
  final String subject1;
  final String time1;
  final String subject2;
  final String time2;

  const SubjectVerificationPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
    required this.subject1,
    required this.time1,
    required this.subject2,
    required this.time2,
  });

  @override
  State<SubjectVerificationPage> createState() =>
      _SubjectVerificationPageState();
}

class _SubjectVerificationPageState
    extends State<SubjectVerificationPage> {
  Future<void> saveData() async {
    await FirebaseFirestore.instance.collection('students').add({
      'name': widget.name,
      'section': widget.section,
      'course': widget.course,
      'subjects': [
        {
          'subject': widget.subject1,
          'time': widget.time1,
        },
        {
          'subject': widget.subject2,
          'time': widget.time2,
        },
      ],
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saved successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.name}'),
            Text('Section: ${widget.section}'),
            Text('Course: ${widget.course}'),
            const SizedBox(height: 20),
            Text('1. ${widget.subject1}'),
            Text('Time: ${widget.time1}'),
            const SizedBox(height: 10),
            Text('2. ${widget.subject2}'),
            Text('Time: ${widget.time2}'),
            ElevatedButton(
              onPressed: saveData,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}