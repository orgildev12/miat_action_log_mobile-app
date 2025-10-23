import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_cache_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazards_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
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

  Future<void> _fetchHazards() async {
    try {
      await clearHazardCacheUseCase.call();
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
    return 
    hazards.isEmpty ?
    Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.myReports, style: TextStyle(fontSize:24, fontWeight: FontWeight.w600, color: black)),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Image.asset(
                        'lib/presentation/assets/images/empty_box.png',
                        fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      AppLocalizations.of(context)!.youDontHaveReport,
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize:20, 
                        fontWeight: FontWeight.w500, 
                        color: hintText
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      )
    :
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.myReports, style: TextStyle(fontSize:24, fontWeight: FontWeight.w600, color: black)),
            SizedBox(height: 12),
            ...hazards.map((hazard) => HazardListItem(hazard: hazard)),
          ],
        )
      ),
    );
  }
}