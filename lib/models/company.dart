
import 'package:taskfive/models/job.dart';

class Company {
  Company({
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.jobType,
    required this.jobs,
  });
  final String title;
  final String description;
  final JobCategory category;
  final String location;
  final JobType jobType;
  List<Job> jobs;

  void addJob(Job job) {
    jobs.add(job);
  }
}
