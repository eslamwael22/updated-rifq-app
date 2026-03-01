import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [

          /// 🔹 الهيدر ثابت
          const CustomAppBar(
            isShow: false,
            subTitle: 'احترام خصوصيتك هو أولويتنا',
            title: 'سياسة الخصوصية',
          ),

          /// 🔹 المحتوى القابل للتمرير
          Expanded(
            child: CustomScrollView(
              slivers: [

                SliverToBoxAdapter(
                  child: SizedBox(height: 20.h),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 20.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// العنوان الرئيسي
                        Text(
                          'سياسة الخصوصية – تطبيق رِفْق',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 24.h),

                        _buildSection(
                          context,
                          'احترام الخصوصية',
                          'يحرص تطبيق رِفْق على احترام خصوصية مستخدميه وتوفير تجربة استخدام آمنة ومريحة. '
                          'لا يقوم التطبيق بجمع أو تخزين أي بيانات شخصية، كما لا يتطلب إنشاء حسابات أو تسجيل دخول.',
                        ),

                        SizedBox(height: 16.h),

                        _buildSection(
                          context,
                          'البيانات المحلية',
                          'لا يطلب التطبيق الوصول إلى أي معلومات حساسة إلا في حدود تشغيل الوظائف الأساسية. '
                          'أي بيانات يتم التعامل معها تظل محفوظة محليًا على جهاز المستخدم فقط، '
                          'ولا يتم نقلها أو مشاركتها مع أي أطراف خارجية.',
                        ),

                        SizedBox(height: 16.h),

                        _buildSection(
                          context,
                          'الحماية والأمان',
                          'يلتزم التطبيق بعدم استخدام أي بيانات لأغراض تجارية أو إعلانية، '
                          'ويهدف إلى توفير بيئة استخدام آمنة تحترم خصوصية جميع المستخدمين.',
                        ),

                        SizedBox(height: 24.h),

                        /// الفوتر
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.security,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                size: 20.w,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'نحن ملتزمون بحماية بياناتك وخصوصيتك',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
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

  Widget _buildSection(
      BuildContext context, String title, String content) {
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