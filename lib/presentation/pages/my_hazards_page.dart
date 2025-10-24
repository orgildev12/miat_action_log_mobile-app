import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_cache_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazards_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/hazard_list_item.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHazardsPage extends StatefulWidget {
  const MyHazardsPage({super.key});

  @override
  State<MyHazardsPage> createState() => _MyHazardsPageState();
}

class _MyHazardsPageState extends State<MyHazardsPage> {
  final FetchHazardsUseCase fetchHazardsUseCase = HazardDI.fetchHazardsUseCase;
  final ClearHazardCacheUseCase clearHazardCacheUseCase = HazardDI.clearHazardCacheUseCase;
  final List<Hazard> hazards = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchHazards();
  }

  Future<void> _fetchHazards({bool clearCache = false}) async {
    setState(() => _isLoading = true);
    try {
      if (clearCache) await clearHazardCacheUseCase.call();
      // await clearHazardCacheUseCase.call();
      final result = await fetchHazardsUseCase.call();
      setState(() {
        hazards
          ..clear()
          ..addAll(result);
      });
    } catch (e) {
      print('Error fetching hazards: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                await _fetchHazards(clearCache: true);
                await Future.delayed(const Duration(milliseconds: 800));
              },
              builder: (
                BuildContext context,
                RefreshIndicatorMode refreshState,
                double pulledExtent,
                double refreshTriggerPullDistance,
                double refreshIndicatorExtent,
              ) {
                final progress = (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0);
                final isRefreshing = refreshState == RefreshIndicatorMode.refresh ||
                    refreshState == RefreshIndicatorMode.armed;
                final isDisappearing = refreshState == RefreshIndicatorMode.done;

                final indicator = isRefreshing
                    ? const CupertinoActivityIndicator(radius: 14)
                    : CupertinoActivityIndicator.partiallyRevealed(
                        radius: 14,
                        progress: progress,
                      );

                return SizedBox(
                  height: pulledExtent,
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(isDisappearing ? -1.0 : 1.0, 1.0, 1.0),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                        child: indicator,
                      ),
                    ),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.myReports,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                ),
              ),
            ),
            if (_isLoading && hazards.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
              )
            else if (hazards.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 250,
                          child: Text(
                            AppLocalizations.of(context)!.youDontHaveReport,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: hintText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final hazard = hazards[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HazardListItem(hazard: hazard),
                    );
                  },
                  childCount: hazards.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
