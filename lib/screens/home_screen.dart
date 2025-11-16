import 'package:flutter/material.dart';
import 'package:taskfive/models/job.dart';
import 'package:taskfive/widgets/job_list_view.dart';
import 'package:taskfive/data/sample_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Job>? _jobs;
  List<Job> _filteredJobs = [];
  final TextEditingController _searchController = TextEditingController();
  int _selectedChipIndex = 0;
  final List<String> _chipLabels = [
    'All',
    'Remote',
    'Full-time',
    'Part-time',
    'Finance',
  ];

  @override
  void initState() {
    super.initState();
    _jobs = List<Job>.from(sampleJobs);
    _filteredJobs = List<Job>.from(sampleJobs);
    _searchController.addListener(() {
      _applyFilters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _applyFilters(),
              decoration: InputDecoration(
                hintText: 'Search jobs, companies, keywords',
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _filteredJobs = List<Job>.from(_jobs ?? []);
                          });
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _applyFilters,
                    ),
                  ],
                ),
              ),
            ),
          ),
    
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              scrollDirection: Axis.horizontal,
              itemCount: _chipLabels.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, idx) {
                final label = _chipLabels[idx];
                return ChoiceChip(
                  label: Text(label),
                  selected: _selectedChipIndex == idx,
                  onSelected: (sel) {
                    setState(() {
                      _selectedChipIndex = sel ? idx : 0;
                      _applyFilters();
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          
          Expanded(child: JobListView(jobs: _filteredJobs)),
        ],
      ),
    );
  }

  void _applyFilters() {
    final base = List<Job>.from(_jobs ?? []);
    if (base.isEmpty) return;

    final query = _searchController.text.trim().toLowerCase();

    var results = base.where((job) {
      if (query.isEmpty) return true;
      final title = job.title.toLowerCase();
      final company = job.company.title.toLowerCase();
      final tags = job.tags.join(' ').toLowerCase();
      return title.contains(query) ||
          company.contains(query) ||
          tags.contains(query);
    }).toList();

    
    switch (_selectedChipIndex) {
      case 1: 
        results = results
            .where((j) => j.location.toLowerCase().contains('remote'))
            .toList();
        break;
      case 2: 
        results = results.where((j) => j.jobtype == JobType.fullTime).toList();
        break;
      case 3: 
        results = results.where((j) => j.jobtype == JobType.partTime).toList();
        break;
      case 4: 
        results = results
            .where((j) => j.category == JobCategory.financialServices)
            .toList();
        break;
      case 0:
      default:
        
        break;
    }

    setState(() {
      _filteredJobs = results;
    });
  }
}
