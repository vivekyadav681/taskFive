import 'package:flutter/material.dart';
import 'package:taskfive/models/job.dart';
import 'package:taskfive/widgets/job_post.dart';

class JobListView extends StatelessWidget {
  const JobListView({super.key, required this.jobs, this.padding});

  final List<Job> jobs;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      itemCount: jobs.length,
      itemBuilder: (ctx, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: JobPost(jobs[index]),
      ),
    );
  }
}
