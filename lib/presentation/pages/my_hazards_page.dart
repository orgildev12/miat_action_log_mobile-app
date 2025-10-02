import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_cache_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazards_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:flutter/material.dart';

class MyHazardsPage extends StatefulWidget {
  const MyHazardsPage({super.key});

  @override
  State<MyHazardsPage> createState() => _MyHazardsPageState();
}

class _MyHazardsPageState extends State<MyHazardsPage> {
  FetchHazardsUseCase fetchHazardsUseCase = HazardDI.fetchHazardsUseCase;
  ClearHazardCacheUseCase clearHazardCacheUseCase = HazardDI.clearHazardCacheUseCase;
  final List<dynamic> hazards = [];

  @override
  void initState() {
    super.initState();
    _fetchHazards();
  }

  Future<void> _clearHazards() async {
    try {
      await clearHazardCacheUseCase.call();
      await _fetchHazards();
    } catch (e) {
      print('Error clearing hazards: $e');
    }
  }

  Future<void> _fetchHazards() async {
    try {
      final result = await fetchHazardsUseCase.call();
      setState(() {
        hazards.clear();
        hazards.addAll(result);
      });
    } catch (e) {
      print('Error fetching hazards: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
      Text('My Hazards Page - Under Construction'),
    );
  }
}