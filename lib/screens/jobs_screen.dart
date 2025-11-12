import 'package:flutter/material.dart';
import 'package:taskfive/widgets/job_post.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: Center(child: Text('TODO: Show jobs list here.')),
    );
  }
}
