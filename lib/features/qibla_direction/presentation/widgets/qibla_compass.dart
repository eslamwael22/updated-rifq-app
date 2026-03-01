import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import '../../domain/models/qiblah_direction.dart';

class QiblaCompassWidget extends StatefulWidget {
  const QiblaCompassWidget({required this.qiblahDirection, super.key});
  final QiblahDirection qiblahDirection;

  @override
  State<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends State<QiblaCompassWidget> {
  double smoothNeedleAngle = 0;
  double angleDifference = 0;
  bool isAligned = false;

  @override
  void initState() {
    super.initState();
    final initialNeedle = widget.qiblahDirection.qiblah * (math.pi / 180);
    smoothNeedleAngle = initialNeedle;
    angleDifference = _calculateAngleDifference(
      widget.qiblahDirection.direction,
      widget.qiblahDirection.qiblah,
    );
    isAligned = angleDifference.abs() < 2; // دقة ±2 درجة
  }

  @override
  void didUpdateWidget(covariant QiblaCompassWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final targetAngle = widget.qiblahDirection.qiblah * (math.pi / 180);
    smoothNeedleAngle =
        smoothNeedleAngle + (targetAngle - smoothNeedleAngle) * 0.2;

    angleDifference = _calculateAngleDifference(
      widget.qiblahDirection.direction,
      widget.qiblahDirection.qiblah,
    );

    final newAligned = angleDifference.abs() < 2;
    if (newAligned && !isAligned) {
      HapticFeedback.selectionClick();
    }
    isAligned = newAligned;
  }

  double _calculateAngleDifference(double phoneDir, double qiblahDir) {
    double diff = qiblahDir - phoneDir;
    while (diff > 180) {
      diff -= 360;
    }
    while (diff < -180) {
      diff += 360;
    }
    return diff;
  }

  @override
  Widget build(BuildContext context) {
    final dialAngle = -widget.qiblahDirection.direction * (math.pi / 180);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final alignedColor = scheme.secondary;
    final idleColor = scheme.outline.withValues(alpha: 0.85);
    final panelColor = scheme.surface;
    final badgeColor = scheme.primaryContainer;
    final badgeOnColor = scheme.onPrimaryContainer;
    final indicatorColor = scheme.onSurface;
    final subTextColor = scheme.onSurfaceVariant;
    final shadowColor = scheme.shadow;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isAligned ? 1.0 : 0.0,
              child: Container(
                margin: EdgeInsets.only(bottom: 20.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: LightAppColors.blackColor190,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: badgeColor.withValues(alpha: 0.48),
                      blurRadius: 12.r,
                      spreadRadius: 2.r,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: badgeOnColor, size: 25.h),
                    SizedBox(width: 10.w),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'ممتاز!   لقد ثبّتت هاتفك باتجاه القبلة',
                        style: AppStyles.textBold17(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            SizedBox(
              width: 320.w,
              height: 320.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // الخلفية
                  AnimatedRotation(
                    turns: dialAngle / (2 * math.pi),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 300.w,
                          height: 300.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: panelColor,
                            border: Border.all(
                              color: isAligned ? alignedColor : idleColor,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isAligned
                                    ? alignedColor.withValues(alpha: 0.30)
                                    : shadowColor.withValues(alpha: 0.35),
                                blurRadius: isAligned ? 20 : 10,
                                spreadRadius: isAligned ? 2 : 1,
                              ),
                            ],
                          ),
                        ),
                        CustomPaint(
                          size: Size(280.w, 280.h),
                          painter: CompassDialPainter(
                            mainTickColor: indicatorColor,
                            subTickColor: indicatorColor.withValues(
                              alpha: 0.38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // السهم
                  AnimatedRotation(
                    turns: smoothNeedleAngle / (2 * math.pi),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: Image.asset(
                      'assets/images/qibla.png',
                      width: 240.w,
                      height: 240.h,
                    ),
                  ),

                  // مؤشر الهاتف العلوي أكبر وأكثر وضوح
                  Positioned(
                    top: 0,
                    child: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: isAligned ? alignedColor : indicatorColor,
                      size: 50.h, // حجم أكبر
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            // معلومات دقيقة للزاوية
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'زاوية الهاتف: ${widget.qiblahDirection.direction.toStringAsFixed(0)}°',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0D7E5E),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'اتجاه القبلة: ${widget.qiblahDirection.qiblah.toStringAsFixed(0)}°',

                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: indicatorColor,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'فرق زاوية الهاتف عن القبلة: ${angleDifference.toStringAsFixed(1)}°',

                  style: TextStyle(
                    color: angleDifference.abs() < 2
                        ? alignedColor
                        : subTextColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  isAligned
                      ? 'ثبّت الهاتف تمامًا، أنت الآن باتجاه القبلة'
                      : 'حرّك الهاتف لتقلل فرق زاويه الهاتف عن القبله الي الصفر ...',

                  style: textTheme.bodyMedium?.copyWith(
                    color: isAligned ? alignedColor : Color(0xFF0D7E5E),
                    fontSize: 17.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

// رسام التدريجات
class CompassDialPainter extends CustomPainter {
  CompassDialPainter({required this.mainTickColor, required this.subTickColor});

  final Color mainTickColor;
  final Color subTickColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintMain = Paint()
      ..color = mainTickColor
      ..strokeWidth = 3.r
      ..strokeCap = StrokeCap.round;
    final paintMedium = Paint()
      ..color = mainTickColor.withValues(alpha: 0.7)
      ..strokeWidth = 2.r
      ..strokeCap = StrokeCap.round;
    final paintSub = Paint()
      ..color = subTickColor
      ..strokeWidth = 1.5.r
      ..strokeCap = StrokeCap.round;

    // تدريجات رئيسية كل 30 درجة (0, 30, 60, 90, إلخ)
    for (int i = 0; i < 360; i += 30) {
      final double angle = (i * math.pi / 180);
      final double startRadius = radius - 25.r;
      final double endRadius = radius - 5.r;

      final p1 = Offset(
        center.dx + startRadius * math.sin(angle),
        center.dy - startRadius * math.cos(angle),
      );
      final p2 = Offset(
        center.dx + endRadius * math.sin(angle),
        center.dy - endRadius * math.cos(angle),
      );

      canvas.drawLine(p1, p2, paintMain);

      // إضافة دائرة صغيرة عند التدريجات الرئيسية
      final circleCenter = Offset(
        center.dx + (radius - 35.r) * math.sin(angle),
        center.dy - (radius - 35.r) * math.cos(angle),
      );
      canvas.drawCircle(circleCenter, 3.r, paintMain);
    }

    // تدريجات متوسطة كل 10 درجات
    for (int i = 10; i < 360; i += 30) {
      for (int j = 0; j < 2; j++) {
        final int angle = i + j * 10;
        if (angle % 30 != 0) {
          final double rad = (angle * math.pi / 180);
          final double startRadius = radius - 12.r;
          final double endRadius = radius - 5.r;

          final p1 = Offset(
            center.dx + startRadius * math.sin(rad),
            center.dy - startRadius * math.cos(rad),
          );
          final p2 = Offset(
            center.dx + endRadius * math.sin(rad),
            center.dy - endRadius * math.cos(rad),
          );

          canvas.drawLine(p1, p2, paintMedium);
        }
      }
    }

    // تدريجات صغيرة كل 5 درجات
    for (int i = 5; i < 360; i += 10) {
      if (i % 10 != 0) {
        final double angle = (i * math.pi / 180);
        final double startRadius = radius - 12;
        final double endRadius = radius - 5;

        final p1 = Offset(
          center.dx + startRadius * math.sin(angle),
          center.dy - startRadius * math.cos(angle),
        );
        final p2 = Offset(
          center.dx + endRadius * math.sin(angle),
          center.dy - endRadius * math.cos(angle),
        );

        canvas.drawLine(p1, p2, paintSub);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
