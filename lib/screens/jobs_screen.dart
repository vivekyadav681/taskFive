import 'package:flutter/material.dart';
import 'package:taskfive/widgets/job_list_view.dart';
import 'package:taskfive/data/sample_data.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: JobListView(jobs: sampleJobs),
      ),
    );
  }
}
