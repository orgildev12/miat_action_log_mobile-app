import 'package:action_log_app/application/use_cases/location_use_cases/fetch_locations_use_case.dart';
import 'package:action_log_app/application/use_cases/location_use_cases/clear_location_cache.dart';
import 'package:action_log_app/domain/entities/location.dart';
import 'package:flutter/material.dart';

class LocationsPage extends StatefulWidget {
  final FetchLocationsUseCase fetchLocationsUseCase;
  final ClearLocationCacheUseCase clearLocationCacheUseCase;

  const LocationsPage({
    super.key,
    required this.fetchLocationsUseCase,
    required this.clearLocationCacheUseCase,
  });

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<Location> locations = [];
  bool isLoading = false;
  String? errorMessage;
  bool includeGroupedLocations = false; // Toggle for including grouped locations

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await widget.fetchLocationsUseCase.call(
        includeLocationsWithLGroup: includeGroupedLocations,
      );
      setState(() {
        locations = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load locations: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _clearCache() async {
    try {
      await widget.clearLocationCacheUseCase.call();
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cache cleared successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
      // Refresh data after clearing cache
      _fetchLocations();
    } catch (e) {
      // Show error message
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
        title: const Text('Locations'),
        actions: [
          // Toggle switch for including grouped locations
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Include Grouped',
                style: TextStyle(fontSize: 12),
              ),
              Switch(
                value: includeGroupedLocations,
                onChanged: (value) {
                  setState(() {
                    includeGroupedLocations = value;
                  });
                  _fetchLocations(); // Refresh data when toggle changes
                },
              ),
              const SizedBox(width: 8),
              // Clear cache button
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Clear Cache',
                onPressed: _clearCache,
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchLocations,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (locations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              includeGroupedLocations 
                ? 'No locations found'
                : 'No ungrouped locations found',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              includeGroupedLocations
                ? 'Try creating some locations'
                : 'Try toggling "Include Grouped" to see all locations',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Header with count and refresh button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Locations: ${locations.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton.icon(
                onPressed: _fetchLocations,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Refresh'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
        ),
        // List
        Expanded(
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return ListTile(
                leading: Icon(
            location.locationGroupId == null 
              ? Icons.location_on_outlined  // Ungrouped
              : Icons.location_on,          // Grouped
            color: location.locationGroupId == null 
              ? Colors.orange 
              : Colors.blue,
          ),
          title: Text(location.nameEn),
          subtitle: Text(location.nameMn),
          trailing: location.locationGroupId != null 
            ? Chip(
                label: Text('Group ${location.locationGroupId}'),
                backgroundColor: Colors.blue.shade100,
              )
            : const Chip(
                label: Text('Ungrouped'),
                backgroundColor: Colors.orange,
              ),
        );
      },
    ),
        ),
      ],
    );
  }
}