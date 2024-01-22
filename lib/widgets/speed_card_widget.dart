import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/internet_speed_view_model.dart';

class SpeedTestCard extends StatelessWidget {
  const SpeedTestCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<InternetSpeedProvider>(
      builder: (context, internetSpeedProvider, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withAlpha(150),
                Colors.purpleAccent.withAlpha(150)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Download Speed: ${internetSpeedProvider.downloadTransferRate} Mbps',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Upload Speed: ${internetSpeedProvider.uploadTransferRate} Mbps',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
