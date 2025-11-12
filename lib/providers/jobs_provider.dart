import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskfive/models/job.dart';
import 'package:taskfive/data/sample_data.dart';

final jobsProvider = AsyncNotifierProvider<JobsNotifier, List<Job>>(
  JobsNotifier.new,
);

class JobsNotifier extends AsyncNotifier<List<Job>> {
  @override
  Future<List<Job>> build() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List<Job>.from(sampleJobs);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(await build());
  }
}
