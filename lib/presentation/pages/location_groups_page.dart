import 'package:flutter/material.dart';
import 'package:action_log_app/domain/entities/location_group.dart';
import 'package:action_log_app/application/use_cases/location_use_cases/fetch_location_groups_use_case.dart';

class LocationGroupsPage extends StatefulWidget {
  final FetchLocationGroupsUseCase fetchLocationGroupsUseCase;

  const LocationGroupsPage({
    super.key,
    required this.fetchLocationGroupsUseCase,
  });

  @override
  State<LocationGroupsPage> createState() => _LocationGroupsPageState();
}

class _LocationGroupsPageState extends State<LocationGroupsPage> {
  List<LocationGroup> locationGroups = [];
  bool isLoading = false;
  String? errorMessage;
  bool includeEmpty = false;

  @override
  void initState() {
    super.initState();
    _fetchLocationGroups();
  }

  Future<void> _fetchLocationGroups() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Use the injected use case (from constructor)
      final result = await widget.fetchLocationGroupsUseCase.call(
        includeEmpty: includeEmpty,
      );
      setState(() {
        locationGroups = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load location groups: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Groups'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchLocationGroups,
          ),
        ],
      ),
      body: Column(
        children: [
          // Toggle for including empty groups
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(
                  value: includeEmpty,
                  onChanged: (value) {
                    setState(() {
                      includeEmpty = value ?? false;
                    });
                    _fetchLocationGroups();
                  },
                ),
                const Text('Include empty groups'),
              ],
            ),
          ),
          
          // Content area
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
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchLocationGroups,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (locationGroups.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No location groups found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: locationGroups.length,
      itemBuilder: (context, index) {
        final group = locationGroups[index];
        return _buildLocationGroupCard(group);
      },
    );
  }

  Widget _buildLocationGroupCard(LocationGroup group) {
    final totalLocations = group.locations.values
        .fold<int>(0, (sum, locations) => sum + locations.length);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          group.nameEn,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group.nameMn),
            const SizedBox(height: 4),
            Text(
              '$totalLocations locations',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        children: [
          if (group.locations.isNotEmpty)
            ...group.locations.entries.map((entry) {
              final locations = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Group ID: ${entry.key}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...locations.map((location) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(location.nameEn),
                                Text(
                                  location.nameMn,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    const Divider(),
                  ],
                ),
              );
            })
          else
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No locations in this group',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}