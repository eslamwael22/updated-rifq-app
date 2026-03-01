import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [

          /// 🔹 الهيدر (مش ضمن الاسكرول)
          const CustomAppBar(
            isShow: false,
            subTitle: 'تطبيق ديني إسلامي شامل',
            title: 'حول التطبيق',
          ),

          /// 🔹 المحتوى القابل للتمرير
          Expanded(
            child: CustomScrollView(
              slivers: [

                SliverToBoxAdapter(
                  child: SizedBox(height: 20.h),
                ),

                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// 🔹 اللوجو واسم التطبيق
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/updated logo.png',
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'رِفْق',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'تطبيق ديني إسلامي شامل',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40.h),

                        /// 🔹 عنوان عن التطبيق
                        Text(
                          'عن التطبيق',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          'تطبيق رِفْق هو تطبيق ديني إسلامي مصمم لتقديم تجربة سهلة ومريحة للمستخدم للوصول إلى أهم المحتوى الإسلامي اليومي.\n\n'
                          'يوفر التطبيق مجموعة من المميزات مثل عرض القرآن الكريم، الأذكار، واتجاه القبلة، مع واجهة بسيطة وسريعة تناسب الاستخدام اليومي بدون تعقيد.\n\n'
                          'يهدف التطبيق إلى مساعدة المسلم على تنظيم عباداته والتقرب إلى الله من خلال أدوات دينية موثوقة وسهلة الاستخدام.\n\n'
                          'نسعى دائمًا لتطوير التطبيق وإضافة المزيد من المميزات في التحديثات القادمة لتحسين تجربة المستخدم.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            height: 1.6,
                            color:
                                Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.right,
                        ),

                        SizedBox(height: 24.h),

                        /// 🔹 المميزات
                        Text(
                          'المميزات الرئيسية',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        _buildFeatureItem(
                          context,
                          Icons.menu_book,
                          'القرآن الكريم',
                          'عرض المصحف الشامل',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.mosque,
                          'مواقيت الصلاة',
                          'مواقيت الصلاة الدقيقة لموقعك',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.explore,
                          'اتجاه القبلة',
                          'تحديد اتجاه القبلة بدقة',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.favorite,
                          'الأذكار',
                          'مجموعة متنوعة من الأذكار اليومية',
                        ),

                        SizedBox(height: 30.h),

                        /// 🔹 الإصدار
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius:
                                  BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'الإصدار 1.0.0',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}