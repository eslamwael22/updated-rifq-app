import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/prayer_times/presentation/widgets/city_card.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/DotsLoader.dart';
import '../manager/qibla_cubit.dart';
import '../widgets/qibla_compass.dart';
import '../../domain/models/qiblah_direction.dart';

class QiblaDirectionView extends StatefulWidget {
  const QiblaDirectionView({super.key});

  @override
  State<QiblaDirectionView> createState() => _QiblaDirectionViewState();
}

class _QiblaDirectionViewState extends State<QiblaDirectionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QiblaCubit>().getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            isShow: false,
            subTitle: 'استخدم بوصلة الهاتف لتحديد القبلة',
            title: 'اتجاه القبلة',
          ),
          Expanded(
            child: BlocBuilder<QiblaCubit, QiblaState>(
              builder: (context, state) {
                if (state.status == QiblaStatus.loading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DotsLoader(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text('جاري تحديد الموقع واتجاه القبلة...'),
                      ],
                    ),
                  );
                }

                if (state.status == QiblaStatus.error) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            state.errorMessage ?? 'حدث خطأ غير متوقع',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(height: 16),
                          if (state.errorMessage?.contains('المعايرة') ==
                              true) ...[
                            ElevatedButton.icon(
                              onPressed: () => context
                                  .read<QiblaCubit>()
                                  .getCurrentLocation(),
                              icon: Icon(Icons.refresh),
                              label: Text('إعادة المحاولة بعد المعايرة'),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'حرك الهاتف على شكل رقم 8 عدة مرات',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ] else
                            ElevatedButton(
                              onPressed: () => context
                                  .read<QiblaCubit>()
                                  .getCurrentLocation(),
                              child: Text('إعادة المحاولة'),
                            ),
                        ],
                      ),
                    ),
                  );
                }

                if (state.status == QiblaStatus.success) {
                  final qiblahDirection = QiblahDirection(
                    direction: state.deviceDirection ?? 0,
                    qiblah: state.qiblaDirection ?? 0,
                  );

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      children: [
                        if (state.address != null)
                          CityCard(
                            cityName: state.address!,

                            color: LightAppColors.primaryColor,
                          ),
                        SizedBox(height: 40.h),
                        QiblaCompassWidget(qiblahDirection: qiblahDirection),
                      ],
                    ),
                  );
                }

                return Center(
                  child: Text('جاري التحميل...'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
