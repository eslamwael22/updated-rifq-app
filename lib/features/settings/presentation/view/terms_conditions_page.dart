import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          /// 🔹 الهيدر ثابت
          const CustomAppBar(
            isShow: false,
            subTitle: 'الاستخدام الصحيح للتطبيق',
            title: 'الشروط والأحكام',
          ),

          /// 🔹 المحتوى القابل للتمرير
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: 20.h),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// العنوان الرئيسي
                        Text(
                          'الشروط والأحكام – تطبيق رِفْق',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 24.h),

                        /// المقدمة
                        Text(
                          'باستخدامك لتطبيق رِفْق، فإنك توافق على الشروط التالية:',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15.sp,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                        ),

                        SizedBox(height: 24.h),

                        /// 1. الاستخدام
                        _buildSection(
                          context,
                          '1. الاستخدام',
                          'التطبيق مخصص للاستخدام الشخصي وغير التجاري، ويهدف إلى تقديم محتوى ديني مثل القرآن الكريم، الأذكار، ومواقيت الصلاة.',
                        ),

                        SizedBox(height: 20.h),

                        /// 2. المحتوى
                        _buildSection(
                          context,
                          '2. المحتوى',
                          'نسعى لتقديم معلومات دقيقة وموثوقة، إلا أننا لا نتحمل مسؤولية أي استخدام غير صحيح للمحتوى المعروض داخل التطبيق.',
                        ),

                        SizedBox(height: 20.h),

                        /// 3. الملكية
                        _buildSection(
                          context,
                          '3. الملكية',
                          'جميع حقوق التصميم والبرمجيات داخل التطبيق محفوظة، ولا يجوز نسخ أو إعادة استخدام أي جزء منه دون إذن.',
                        ),

                        SizedBox(height: 20.h),

                       

                        SizedBox(height: 20.h),

                        /// 5. التحديثات
                        _buildSection(
                          context,
                          '5. التحديثات',
                          'قد يتم تحديث هذه الشروط من وقت لآخر، ويُعتبر استمرار استخدامك للتطبيق موافقة على أي تعديلات.',
                        ),

                        SizedBox(height: 24.h),

                        /// الفوتر
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.gavel,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20.w,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'استمرار الاستخدام يعتبر موافقة على الشروط',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 32.h),
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

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
