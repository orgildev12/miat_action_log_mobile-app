import 'package:flutter/material.dart';
import 'package:action_log_app/domain/entities/hazard_type.dart';
import 'package:action_log_app/application/use_cases/hazard_type_use_cases/fetch_hazard_types_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_type_use_cases/clear_hazard_type_cache_use_case.dart';

class HazardTypesPage extends StatefulWidget {
  final FetchHazardTypesUseCase fetchHazardTypesUseCase;
  final ClearHazardTypeCacheUseCase clearHazardTypeCacheUseCase;

  const HazardTypesPage({
    super.key,
    required this.fetchHazardTypesUseCase,
    required this.clearHazardTypeCacheUseCase,
  });

  @override
  State<HazardTypesPage> createState() => _HazardTypesPageState();
}

class _HazardTypesPageState extends State<HazardTypesPage> {
  List<HazardType> hazardTypes = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchHazardTypes();
  }

  Future<void> _fetchHazardTypes() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await widget.fetchHazardTypesUseCase.call();
      setState(() {
        hazardTypes = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load hazard types: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _clearCache() async {
    try {
      await widget.clearHazardTypeCacheUseCase.call();
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
      await _fetchHazardTypes();
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
        title: const Text('Hazard Types'),
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
                  'Total Hazard Types: ${hazardTypes.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton.icon(
                  onPressed: _fetchHazardTypes,
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
              onPressed: _fetchHazardTypes,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (hazardTypes.isEmpty) {
      return const Center(
        child: Text('No hazard types found'),
      );
    }

    // Simple raw data display for testing
    return RefreshIndicator(
      onRefresh: _fetchHazardTypes,
      child: ListView.builder(
        itemCount: hazardTypes.length,
        itemBuilder: (context, index) {
          final hazardType = hazardTypes[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RAW HAZARD TYPE DATA #${index + 1}:', 
                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('ID: ${hazardType.id}'),
                  Text('Short Code: ${hazardType.shortCode}'),
                  Text('Name EN: ${hazardType.nameEn}'),
                  Text('Name MN: ${hazardType.nameMn}'),
                  const SizedBox(height: 8),
                  Text('JSON STRING: ${hazardType.toString()}', 
                       style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}