import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatefulWidget {
  final String hazardStatusMn;
  final String hazardCode;
  final String email;
  const InfoPanel({
    super.key,
    required this.hazardStatusMn,
    required this.hazardCode,
    required this.email,
  });

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel> {
  late List<InlineSpan> textSpans;
  Color backgroundColor = Colors.white;
  Color borderColor = Colors.white;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateContent();
  }

  @override
  void didUpdateWidget(covariant InfoPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hazardStatusMn != widget.hazardStatusMn ||
        oldWidget.email != widget.email ||
        oldWidget.hazardCode != widget.hazardCode) {
      _updateContent();
    }
  }

  void _updateContent() {
    final loc = AppLocalizations.of(context)!;

    final contentOfStatusSent = loc.yourRequestWasSent;
    final contentStartOfStatusWorking = loc.startOfStatusWorking;
    final contentEndOfStatusWorking = loc.endOfStatusWorking;
    final contentStartOfStatusSolved = loc.startOfStatusSolved;
    final contentEndOfStatusSolved = loc.endOfStatusSolved;
    final contentStartOfStatusRejected = loc.startOfStatusRejected;
    final contentEndOfStatusRejected = loc.endOfStatusRejected;

    final baseStyle = TextStyle(fontSize: 14, color: black);
    final boldStyle = baseStyle.copyWith(fontWeight: FontWeight.bold);

    switch (widget.hazardStatusMn) {
      case "Шийдэгдсэн":
        backgroundColor = Colors.green.withOpacity(0.15);
        borderColor = Colors.green;
        textSpans = [
          TextSpan(text: contentStartOfStatusSolved, style: baseStyle),
          TextSpan(text: widget.email, style: boldStyle),
          TextSpan(text: contentEndOfStatusSolved, style: baseStyle),
        ];
        break;

      case "Ажиллаж байна":
        backgroundColor = Colors.orange.withOpacity(0.15);
        borderColor = Colors.orange;
        textSpans = [
          TextSpan(text: contentStartOfStatusWorking, style: baseStyle),
          TextSpan(text: widget.hazardCode, style: boldStyle),
          TextSpan(text: contentEndOfStatusWorking, style: baseStyle),
        ];
        break;

      case "Татгалзсан":
        backgroundColor = Colors.red.withOpacity(0.15);
        borderColor = Colors.red;
        textSpans = [
          TextSpan(text: contentStartOfStatusRejected, style: baseStyle),
          TextSpan(text: widget.email, style: boldStyle),
          TextSpan(text: contentEndOfStatusRejected, style: baseStyle),
        ];
        break;

      default:
        backgroundColor = primaryColor.withOpacity(0.15);
        borderColor = primaryColor;
        textSpans = [
          TextSpan(text: contentOfStatusSent, style: baseStyle),
        ];
        break;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: RichText(
        text: TextSpan(children: textSpans),
      ),
    );
  }
}
