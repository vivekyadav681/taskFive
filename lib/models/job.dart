import 'package:taskfive/models/company.dart';

enum JobCategory {
  commerce,
  telecommunications,
  hotelsAndTourism,
  education,
  financialServices,
}

enum JobType { fullTime, partTime, freelance, seasonal, fixedPrice }

enum ExperienceLevel { noExperience, fresher, intermediate, expert }

class Job {
  Job({
    required this.title,
    required this.location,
    required this.company,
    required this.category,
    required this.jobtype,
    required this.experience,
    required this.posted,
    required this.salary,
    required this.description,
    required this.tags,
  });
  final String title;
  final String location;
  final Company company;
  final JobCategory category;
  final JobType jobtype;
  final ExperienceLevel experience;
  final DateTime posted;
  final int salary;
  List<String> tags = [];
  final String description;
}
