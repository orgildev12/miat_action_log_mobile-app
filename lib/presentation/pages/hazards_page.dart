import 'package:flutter/material.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazards_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_cache_use_case.dart';

class HazardsPage extends StatefulWidget {
  final FetchHazardsUseCase fetchHazardsUseCase;
  final ClearHazardCacheUseCase clearHazardCacheUseCase;

  const HazardsPage({
    super.key,
    required this.fetchHazardsUseCase,
    required this.clearHazardCacheUseCase,
  });

  @override
  State<HazardsPage> createState() => _HazardsPageState();
}

class _HazardsPageState extends State<HazardsPage> {
  List<Hazard> hazards = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchHazards();
  }

  Future<void> _fetchHazards() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await widget.fetchHazardsUseCase.call();
      setState(() {
        hazards = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load hazards: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _clearCache() async {
    try {
      await widget.clearHazardCacheUseCase.call();
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cache cleared successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
      // Refresh the data
      await _fetchHazards();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to clear cache: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hazards'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearCache,
            icon: const Icon(Icons.refresh),
            tooltip: 'Clear Cache & Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with count and refresh button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Hazards: ${hazards.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton.icon(
                  onPressed: _fetchHazards,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Refresh'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create hazard page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create hazard functionality coming soon'),
            ),
          );
        },
        tooltip: 'Create New Hazard',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchHazards,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (hazards.isEmpty) {
      return const Center(
        child: Text('No hazards found'),
      );
    }

    // Simple raw data display for testing
    return RefreshIndicator(
      onRefresh: _fetchHazards,
      child: ListView.builder(
        itemCount: hazards.length,
        itemBuilder: (context, index) {
          final hazard = hazards[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RAW HAZARD DATA #${index + 1}:', 
                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('code: ${hazard.code}'),
                  Text('statusEn: ${hazard.statusEn}'),
                  Text('statusMn: ${hazard.statusMn}'),
                  Text('typeNameEn: ${hazard.typeNameEn}'),
                  Text('typeNameMn: ${hazard.typeNameMn}'),
                  Text('locationNameEn: ${hazard.locationNameEn}'),
                  Text('locationNameMn: ${hazard.locationNameMn}'),
                  Text('description: ${hazard.description}'),
                  Text('solution: ${hazard.solution}'),
                  Text('dateCreated: ${hazard.dateCreated}'),
                  Text('isResponseConfirmed: ${hazard.isResponseConfirmed}'),
                  if (hazard.isResponseConfirmed != 0) ...[
                    Text('response_body: ${hazard.responseBody}'),
                  ] else ...[
                    Text('no response body, because is_response_confirmed is 0') 
                  ],
                  Text('isPrivate: ${hazard.isPrivate}'),
                  Text('dateUpdated: ${hazard.dateUpdated}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}