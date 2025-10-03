import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_cache_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazards_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/presentation/components/hazard_list_item.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class MyHazardsPage extends StatefulWidget {
  const MyHazardsPage({super.key});

  @override
  State<MyHazardsPage> createState() => _MyHazardsPageState();
}

class _MyHazardsPageState extends State<MyHazardsPage> {
  FetchHazardsUseCase fetchHazardsUseCase = HazardDI.fetchHazardsUseCase;
  ClearHazardCacheUseCase clearHazardCacheUseCase = HazardDI.clearHazardCacheUseCase;
  final List<Hazard> hazards = [];

  @override
  void initState() {
    super.initState();
    _fetchHazards();
  }

  // Future<void> _clearHazards() async {
  //   try {
  //     await clearHazardCacheUseCase.call();
  //   } catch (e) {
  //     print('Error clearing hazards: $e');
  //   }
  // }

  Future<void> _fetchHazards() async {
    try {
      // _clearHazards();
      final result = await fetchHazardsUseCase.call();
      setState(() {
       
        hazards.addAll(result);
      });
    } catch (e) {
      print('Error fetching hazards: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Миний илгээсэн хүсэлтүүд', style: TextStyle(fontSize:24, fontWeight: FontWeight.w600, color: black)),
            SizedBox(height: 12),
            ...hazards.map((hazard) => HazardListItem(hazard: hazard)).toList(),
          ],
        )
      ),
    );
  }
}