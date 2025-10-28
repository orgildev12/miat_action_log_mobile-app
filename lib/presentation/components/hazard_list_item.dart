import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/presentation/pages/hazard_details_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HazardListItem extends StatefulWidget {
  final Hazard hazard;

  const HazardListItem({
    super.key,
    required this.hazard,
  });

  @override
  State<HazardListItem> createState() => _HazardListItemState();
}

class _HazardListItemState extends State<HazardListItem> {
  void _pushToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HazardDetailsPage(hazard: widget.hazard),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => _pushToDetails(context),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- HEADER ROW ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Left side: icon + divider + hazard type
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.hazard.isPrivate == 0
                                ? const Icon(IconsaxPlusLinear.message,
                                    color: black, size: 24)
                                : const Icon(IconsaxPlusLinear.security_user,
                                    color: black, size: 24),
                            const SizedBox(width: 8),
                            Container(
                              width: 2,
                              height: 24,
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            /// Type name (max 2 lines, no overflow)
                            Expanded(
                              child: Text(
                                Localizations.localeOf(context).languageCode ==
                                        'mn'
                                    ? widget.hazard.typeNameMn.toString()
                                    : widget.hazard.typeNameEn.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Right side: status + color dot
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Localizations.localeOf(context).languageCode == 'mn'
                                ? widget.hazard.statusMn
                                : widget.hazard.statusEn,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: widget.hazard.statusMn == "Шийдэгдсэн"
                                  ? Colors.green
                                  : widget.hazard.statusMn == "Ажиллаж байна"
                                      ? Colors.orange
                                      : widget.hazard.statusMn == "Татгалзсан"
                                          ? Colors.red
                                          : Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// --- DESCRIPTION ---
                  Text(
                    widget.hazard.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
