import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared files/utility.dart';
import '../viewmodels/internet_speed_view_model.dart';

class PlanCardComponent extends StatefulWidget {
  const PlanCardComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanCardComponent> createState() => _PlanCardComponentState();
}

class _PlanCardComponentState extends State<PlanCardComponent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _radialProgressAnimationController;
  late Animation<double> _progressAnimation;
  final Duration fadeInDuration = const Duration(milliseconds: 500);
  final Duration fillDuration = const Duration(seconds: 2);
  double progressDegrees = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn));
    _radialProgressAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<InternetSpeedProvider>(
      builder: (context, internetSpeedProvider, child) {
        return CustomPaint(
          painter: RadialPainter((internetSpeedProvider.transferRate / 100) *
              _progressAnimation.value),
          child: Container(
              height: 250,
              width: 250,
              alignment: Alignment.center,
              child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: fadeInDuration,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ${internetSpeedProvider.transferRate}'),
                        const TextSpan(
                            text: ' MBps\n',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(
                            text:
                                '${internetSpeedProvider.downloadProgressPercent}'),
                        const TextSpan(
                            text: ' %', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ))),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.purple, Colors.blue, Colors.greenAccent],
      ).createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      Utility().radians(-90),
      Utility().radians(progressInDegrees),
      false,
      progressPaint,
    );

    // Add a shadow effect
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      Utility().radians(-90),
      Utility().radians(progressInDegrees),
      false,
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
