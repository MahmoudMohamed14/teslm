import 'package:delivery/common/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../../common/colors/theme_model.dart';
class NumberStepper extends StatefulWidget {
  const NumberStepper({super.key,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineHeight,});
  final int totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineHeight;
  @override
  State<NumberStepper> createState() => _NumberStepperState();
}
class _NumberStepperState extends State<NumberStepper> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController
      ..duration =const  Duration(milliseconds: 1000)
      ..repeat(reverse: true);
    _animationController.addListener(() {
      setState(() {});
    });
    _startAnimation();
  }
  void _startAnimation() {
    _sizeAnimation = Tween<double>(begin: 28.0, end: 32.0).animate(_animationController);
    _colorAnimation = ColorTween(begin: Colors.grey, end: ThemeModel.mainColor).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 24.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _steps(),
          ),
        ),
      ],
    );
  }
  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < widget.totalSteps; i++) {
      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      list.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width/4.5,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: circleColor,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: borderColor,
                      width: 1.0,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
              ],
            ),
          ],
        ),
      );
    }
    return list;
  }
  getCircleColor(i) {
    Color color;
    if (i + 1 < widget.curStep) {
      color = widget.stepCompleteColor;
    } else if (i + 1 == widget.curStep) {
      _animationController.forward();
      return _colorAnimation.value;
    } else {
      color = Colors.white;
    }
    return color;
  }

  getBorderColor(i) {
    Color color;
    if (i + 1 < widget.curStep) {
      color = widget.stepCompleteColor;
    } else if (i + 1 == widget.curStep) {
      return _colorAnimation.value;
    } else {
      color = widget.inactiveColor;
    }
    return color;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < widget.curStep) {
      return const Icon(
        Icons.check,
        color: Colors.white,
        size: 16.0,
      );
    } else if (index + 1 == widget.curStep) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _sizeAnimation.value,
        height: _sizeAnimation.value,
        child: Center(
          child: Text(
            '${widget.curStep}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }}

  getLineColor(i) {
    var color =
    widget.curStep > i + 1 ? ThemeModel.mainColor.withOpacity(0.4) : Colors.grey[200];
    return color;
  }
}