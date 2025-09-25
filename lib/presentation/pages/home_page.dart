import 'package:flutter/material.dart';
import 'package:action_log_app/presentation/pages/locations_page.dart';
import 'package:action_log_app/presentation/pages/hazard_types_page.dart';
import 'package:action_log_app/presentation/pages/hazards_page.dart';
import 'package:action_log_app/core/di/features/location_di.dart';
import 'package:action_log_app/core/di/features/hazard_type_di.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Action Log App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNavigationItem(
              context,
              title: 'Locations',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationsPage(
                    fetchLocationsUseCase: LocationDI.fetchLocationsUseCase,
                    clearLocationCacheUseCase: LocationDI.clearLocationCacheUseCase,
                  ),
                ),
              ),
            ),
            _buildNavigationItem(
              context,
              title: 'Hazard Types',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HazardTypesPage(
                    fetchHazardTypesUseCase: HazardTypeDI.fetchHazardTypesUseCase,
                    clearHazardTypeCacheUseCase: HazardTypeDI.clearHazardTypeCacheUseCase,
                  ),
                ),
              ),
            ),
            _buildNavigationItem(
              context,
              title: 'Hazards',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HazardsPage(
                    fetchHazardsUseCase: HazardDI.fetchHazardsUseCase,
                    clearHazardCacheUseCase: HazardDI.clearHazardCacheUseCase,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}