import 'package:flutter/material.dart';
import 'package:my_internet_speed_meter/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../shared files/constants/constants.dart';
import '../viewmodels/internet_speed_view_model.dart';
import '../widgets/custom_circular_indicator.dart';
import '../widgets/custom_loading_animation_widgets.dart';
import '../widgets/speed_card_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Consumer<InternetSpeedProvider>(
      builder: (context, internetSpeedProvider, child) {
        return Scaffold(
          appBar: const CustomAppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                const PlanCardComponent(),
                const SizedBox(height: 25),
                Visibility(
                    visible: internetSpeedProvider.loading,
                    child: const CustomLoadingAnimation()),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    internetSpeedProvider.startButtonPressed();
                  },
                  style: Constants.elevatedButtonStyle,
                  child: const Text(Constants.checkSpeedText),
                ),
                const SizedBox(height: 80),
                const SpeedTestCard(),
              ],
            ),
          ),
        );
      },
    );
  }
}
