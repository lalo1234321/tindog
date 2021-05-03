import 'package:tindog/widgets/clipper_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class WaveWidget extends StatefulWidget {

  final Size size;
  final double yOffset;
  final Color color;

  const WaveWidget({
    Key key, 
    this.size, 
    this.yOffset, 
    this.color
  }) : super(key: key);

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 40000)
    )
    ..addListener(() {
      wavePoints.clear();
      final double waveSpeed = animationController.value * 7000;
      final double fullSphere = animationController.value * Math.pi * 2;
      final double normalizer = Math.cos(fullSphere);
      final double waveWidth = Math.pi /270;
      final double waveHeight = 20.0;

      for( int i = 0; i <= widget.size.width.toInt(); i++ ) {
        double calc = Math.sin((waveSpeed -i) * waveWidth);

        wavePoints.add(
          Offset(
            i.toDouble(),
            calc * waveHeight * normalizer + widget.yOffset
          )
        );


      }

    });
    animationController.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,_) {
        return ClipPath(
          clipper: ClipperWidget(
            waveList: wavePoints
          ),
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}