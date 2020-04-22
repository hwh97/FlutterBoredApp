import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final Size size;
  final BorderRadius borderRadius;
  final double value;
  final double maxValue;
  final Color backgroundColor;
  final Color progressColor;

  const ProgressBar(
      {Key key,
      this.size,
      this.borderRadius = BorderRadius.zero,
      this.value,
      this.maxValue = 1.0,
      this.backgroundColor,
      this.progressColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProgressBarState();
  }
}

class ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> animation;
  double fraction = 0.0;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: CustomPaint(
        size: widget.size,
        painter: ProgressPainter(
          progress: fraction,
          maxProgress: widget.maxValue,
          backgroundColor: widget.backgroundColor ?? Color(0xFFD8D8D8),
          progressColor: widget.progressColor ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 500), vsync: this);
    _playAnimation(0.0, widget.value);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    animation?.removeListener(_animationListener);
    controller?.reset();
    if (oldWidget.value != widget.value) {
      _playAnimation(fraction, widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }
  
  _playAnimation(double oldValue, double newValue) {
    animation = Tween(begin: oldValue, end: newValue).animate(controller)
      ..addListener(_animationListener);
    controller.forward();
  }

  _animationListener() {
    setState(() {
      fraction = animation.value;
    });
  }

  @override
  bool get wantKeepAlive => true;
}

// 进度条绘画
class ProgressPainter extends CustomPainter {
  final double progress;
  final double maxProgress;
  final Color backgroundColor;
  final Color progressColor;
  Paint bgPaint;
  Paint progressPaint;

  ProgressPainter(
      {this.progress,
      this.maxProgress,
      this.backgroundColor,
      this.progressColor}) {
    bgPaint = new Paint()
      ..color = backgroundColor //画笔颜色
      ..isAntiAlias = true //是否启动抗锯齿
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.0; //画笔的宽度

    progressPaint = new Paint()
      ..color = progressColor //画笔颜色
      ..isAntiAlias = true //是否启动抗锯齿
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.0; //画笔的宽度
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, bgPaint);
    Rect proRect =
        Rect.fromLTWH(0, 0, size.width * (progress / maxProgress), size.height);
    canvas.drawRect(proRect, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
