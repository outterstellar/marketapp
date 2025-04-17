import 'package:flutter/material.dart';
import 'package:marketapp/data/campaignmodel.dart';

class CampaignScreen extends StatefulWidget {
  final Campaign campaign;
  const CampaignScreen({super.key, required this.campaign});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
