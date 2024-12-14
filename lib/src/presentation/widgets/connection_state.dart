import 'package:flutter/material.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_internet_view_model.dart';

class ConnectionStateWidget extends StatelessWidget {
  final ConnectionStateEnum connectionState;

  const ConnectionStateWidget({super.key, required this.connectionState});

  @override
  Widget build(BuildContext context) {
    final Map<ConnectionStateEnum, Map<String, dynamic>> stateMap = {
      ConnectionStateEnum.online: {
        'color': Colors.green,
        'label': 'Online',
      },
      ConnectionStateEnum.offline: {
        'color': Colors.red,
        'label': 'Offline',
      },
      ConnectionStateEnum.synchronizing: {
        'color': Colors.yellow,
        'label': 'Synchronizing',
      },
    };

    final color = stateMap[connectionState]?['color'] as Color;
    final label = stateMap[connectionState]?['label'] as String;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8), // Spacing between the circle and text
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
