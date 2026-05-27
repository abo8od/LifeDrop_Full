// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get life_drop => 'قطرة حياة';

  @override
  String get app_first_name => 'قطرة ';

  @override
  String get app_last_name => 'حياة';

  @override
  String get app_tagline => 'الحياة تنبض في دمك';

  @override
  String get splash_loading_text => 'جار الآن المزامنة...';

  @override
  String get app_version => 'الإصدار';

  @override
  String get app_build => 'صمم من أجل الإيثار';

  @override
  String get pulse => 'نبض';

  @override
  String get onboarding_title_1 => 'أنقِذ حياة مع كل قطرة';

  @override
  String get onboarding_title_2 => 'تبرعات مُعتمدة';

  @override
  String get onboarding_title_3_part_1 => 'إشعارات ';

  @override
  String get onboarding_title_3_part_2 => 'ذكية';

  @override
  String get onboarding_subtitle_1 => 'انضم إلى شبكة عالمية من الأبطال المتطوعين لتقديم تبرعات دم تنقذ الحياة';

  @override
  String get onboarding_subtitle_2 => 'كل تبرع يتم التحقق منه طبيًا ويتم تتبعه من لحظة التبرع حتى وصوله للمريض المحتاج';

  @override
  String get onboarding_subtitle_3 => 'استقبل إشعارات فورية عند الحاجة العاجلة لفصيلة دمك في المستشفيات القريبة';

  @override
  String get next => 'التالي';

  @override
  String get get_started => 'ابدأ';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get welcome_back => 'مرحبًا بعودتك، جاهز لإنقاذ حياة؟';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get register_now => 'سجل الآن';

  @override
  String get forgot_password => 'نسيت كلمة المرور؟';

  @override
  String get new_donor => 'متبرع جديد؟';

  @override
  String get register => 'تسجيل';

  @override
  String get become_donor => 'كن متبرعًا ينقذ الحياة';

  @override
  String get first_name => 'الاسم الأول';

  @override
  String get last_name => 'الاسم الأخير';

  @override
  String get confirm_password => 'تأكيد كلمة المرور';

  @override
  String get new_password => 'كلمة السر الجديدة';

  @override
  String get phone_number => 'رقم الهاتف';

  @override
  String get select_blood_type => 'اختر فصيلة الدم';

  @override
  String get already_have_an_account => 'هل لديك حساب بالفعل؟';

  @override
  String get forgot_password_subtitle => 'أدخل بريدك الإلكتروني أو رقم هاتفك المسجّل وسنرسل لك رمز تحقق.';

  @override
  String get back_to_login => 'العودة إلى تسجيل الدخول';

  @override
  String get send_otp => 'إرسال رمز التحقق';

  @override
  String get otp_verification => 'تأكيد رمز التحقق';

  @override
  String get otp_from_forgot_password_subtitle => 'تم إرسال رمز مكوّن من 6 أرقام إلى بريدك الألكتروني. أدخله للمتابعة.';

  @override
  String get otp_from_register_subtitle => 'تم إرسال رمز مكوّن من 6 أرقام إلى بريدك الألكتروني. أدخله لإنشاء الحساب.';

  @override
  String get verify_continue => 'تحقق وتابع';

  @override
  String get reset_password => 'تغيير كلمة السر';

  @override
  String get reset_subtitle => 'تأكد من أن كلمة المرور الجديدة تتكون من 8 أحرف على الأقل وتحتوي على أحرف كبيرة وصغيرة وأرقام ورموز.';

  @override
  String get update_password => 'تحديث كلمة المرور';

  @override
  String get didnt_receive_code => 'لم تستلم الرمز؟';

  @override
  String get resend_timer => 'إعادة الإرسال بعد';

  @override
  String get resend_again => 'إعادة الإرسال';

  @override
  String get required => 'مطلوب';

  @override
  String get quick_login => 'تسجيل دخول سريع';

  @override
  String get enable_biometric_login_message => 'استخدم بصمتك لتسجيل دخول أسرع وأكثر أمانًا في المرة القادمة';

  @override
  String get accounts => 'الحسابات';

  @override
  String get authenticate_to_login => 'المصادقة لتسجيل الدخول';

  @override
  String get use_fingerprint_for_quick_secure_login => 'استخدم بصمتك لتسجيل الدخول بسرعة وأمان';

  @override
  String get enable => 'تفعيل';

  @override
  String get skip => 'تخطي';

  @override
  String get welcome_back_home => 'مرحبا بعودتك،';

  @override
  String donation_impact_message(Object hospital) {
    return 'آخر تبرع لك أنقذ 3 أشخاص في $hospital';
  }

  @override
  String next_donation_availability(Object days) {
    return 'يمكنك التبرع مرة أخرى بعد $days يومًا';
  }

  @override
  String get total_contributions => 'إجمالي التبرعات';

  @override
  String get donations => 'تبرع';

  @override
  String get tens_donation => 'تبرعات';

  @override
  String get active_requests => 'الطلبات النشطة';

  @override
  String get view_all_requests => 'عرض كل الطلبات';

  @override
  String get no_active_requests_found => 'لا توجد طلبات تبرع نشطة حالياً.';

  @override
  String get search_requests_hint => 'ابحث في الطلبات';

  @override
  String get all_filter => 'الكل';

  @override
  String get normal_filter => 'عادي';

  @override
  String get urgent_filter => 'عاجل';

  @override
  String get critical_filter => 'حرج';

  @override
  String all_requests_count(Object count) {
    return '$count طلب';
  }

  @override
  String get urgent_priority => 'حالة طارئة';

  @override
  String get donation_progress => 'تقدم التبرع';

  @override
  String donors_confirmed_progress(Object confirmed, Object total) {
    return 'تم تأكيد $confirmed/$total متبرعين';
  }

  @override
  String urgent_Donors_needed_message(Object count) {
    return 'نحتاج إلى $count متبرعين إضافيين لتلبية هذا الطلب الطارئ. تبرعك يمكن أن ينقذ حياة اليوم.';
  }

  @override
  String get got_to_map => 'Go to Map';

  @override
  String get accept_request => 'قبول الطلب';

  @override
  String get request_details => 'تفاصيل الطلب';

  @override
  String get you_are_a_lifesaver => 'أنت تنقذ الأرواح!';

  @override
  String get request_accepted_hospital_waiting => 'تم تأكيد قبول طلبك.\nوحدة المستشفى بانتظار وصولك.';

  @override
  String get hospital_location => 'موقع المستشفى';

  @override
  String get bring_digital_id => 'أحضر هويتك الشخصية';

  @override
  String get start_navigation => 'ابدأ التنقل';

  @override
  String get birth_date => 'تاريخ الميلاد';

  @override
  String get governorate => 'المحافظة';

  @override
  String get district => 'المنطقة';

  @override
  String get more_info => 'معلومات إضافية';

  @override
  String get first_name_required => 'الاسم الأول مطلوب.';

  @override
  String get last_name_required => 'اسم العائلة مطلوب.';

  @override
  String get email_required => 'يرجى إدخال بريد إلكتروني صحيح.';

  @override
  String get phone_required => 'رقم هاتف غير صالح.\nيجب أن يبدأ بـ 77 أو 78 أو 79.';

  @override
  String get phone_number_digits_only => 'يجب أن يحتوي رقم الهاتف على أرقام فقط.';

  @override
  String get password_required => 'يجب أن تكون كلمة المرور أكثر من 8 أحرف، وتحتوي على أحرف كبيرة وصغيرة، رقم، رمز، وبدون مسافات.';

  @override
  String get passwords_do_not_match => 'كلمة المرور غير متطابقة.';

  @override
  String get birth_date_required => 'يرجى إدخال تاريخ الميلاد.';

  @override
  String get governorate_required => 'يرجى اختيار المحافظة.';

  @override
  String get district_required => 'يرجى اختيار المنطقة.';

  @override
  String get blood_type_required => 'يرجى اختيار فصيلة الدم.';

  @override
  String get response_now_button => 'استجابة الآن';

  @override
  String get schedule_appointment_button => 'جدولة موعد';

  @override
  String get send_code_message => 'تم إرسال رمز التحقق.';

  @override
  String get resend_code_message => 'تم إرسال رمز التحقق مرة أخرى.';

  @override
  String get account_acreated_message => 'Account has been created successfully.';

  @override
  String get verification_code_sent => 'تم إرسال رمز التحقق بنجاح.\nيرجى التحقق من بريدك الإلكتروني للمتابعة.';

  @override
  String get password_updated_message => 'تم تحديث كلمة المرور بنجاح.';

  @override
  String get donation_cancelled_success => 'تم إلغاء التبرع بنجاح.';

  @override
  String get no_active_donation_found => 'لا توجد طلبات تبرع نشطة حالياً.';

  @override
  String get go_back_label => 'العودة';

  @override
  String get select_cancellation_reason_title => 'اختر سبب الإلغاء';

  @override
  String get select_reason_hint => 'اختر السبب';

  @override
  String get reason_required_error => 'يجب اختيار سبب لإلغاء التبرع';

  @override
  String get cancellation_health_warning => '* ملاحظة: بالنسبة للإلغاءات المتعلقة بالصحة، قد يتم تأجيل التبرع مؤقتاً لضمان سلامتك الصحية.';

  @override
  String get optional_note_label => 'ملاحظة (اختياري)';

  @override
  String get confirm_cancellation_button => 'تأكيد الإلغاء';

  @override
  String get go_back_button => 'العودة';

  @override
  String get review_heading => 'مراجعة ';

  @override
  String get cancellation_heading => 'الإلغاء';

  @override
  String get cancellation_description => 'نفهم أن الخطط قد تتغير. يرجى إخبارنا بسبب الحاجة لإلغاء طلب التبرع هذا.';

  @override
  String get blood_type_label => 'فصيلة الدم';

  @override
  String get units_requested_label => 'الوحدات المطلوبة';

  @override
  String get priority_label => 'الأولوية';

  @override
  String get impact_label => 'التأثير';

  @override
  String get saves_lives_value => 'ينقذ 3 أرواح';

  @override
  String get hours_abbreviation => 'ساعات';

  @override
  String get minutes_abbreviation => 'دقائق';

  @override
  String get seconds_abbreviation => 'ثوان';

  @override
  String get request_expired_heading => 'انتهت صلاحية الطلب';

  @override
  String get request_expires_in_heading => 'ينتهي الطلب بعد';

  @override
  String get request_expired_message => 'لقد انتهت صلاحية الطلب.\nيرجى البحث عن طلبات جديدة.';

  @override
  String get arrive_before_timer_message => 'يرجى الحضور قبل انتهاء الوقت\nللتأكد من معالجة تبرعك.';

  @override
  String get help_support_text => 'هل تحتاج إلى مساعدة؟ استخدم زر الاتصال\nأعلاه أو ';

  @override
  String get view_guidelines_link => 'اعرض إرشادات التبرع';

  @override
  String get destination_label => 'الوجهة';

  @override
  String get contact_hospital_button => 'اتصل بالمستشفى';

  @override
  String get cancel_donation_button => 'إلغاء التبرع';

  @override
  String get emergency_blood_needed_headline => 'الدم المستعجل مطلوب';

  @override
  String get critical_tag => 'حرج';

  @override
  String get km_away_suffix => 'كم بعيد';

  @override
  String get select_governorate_hint => 'اختر المحافظة';

  @override
  String get select_district_hint => 'اختر المنطقة';

  @override
  String get date_of_birth_placeholder => 'اختر تاريخ الميلاد';

  @override
  String get cancellation_impact_message => 'قد يؤثر إلغاء هذا الطلب على درجة موثوقيتك كمتبرع.\nيساعد الالتزام بالتبرع المستمر المستشفيات على التخطيط للإجراءات المنقذة للحياة بشكل أكثر فعالية.';

  @override
  String get impact_on_reliability => 'التأثير على الموثوقية';

  @override
  String units(Object value) {
    return '$value وحدات دم';
  }

  @override
  String get language_settings => ' إعدادات اللغة';

  @override
  String get language_settings_subtitle => 'اختر لغتك المفضلة';

  @override
  String get language_english => 'English';

  @override
  String get language_arabic => 'العربية';

  @override
  String get current_language_label => 'اللغة الحالية';

  @override
  String get available_languages_label => 'اللغات المتاحة';

  @override
  String get language_changed_message => 'تم تغيير اللغة بنجاح';

  @override
  String get account_settings_title => 'إعدادات الحساب';

  @override
  String get personal_information_label => 'المعلومات الشخصية';

  @override
  String get edit_profile => 'تعديل الملف الشخصي';

  @override
  String get verification_status => 'حالة التحقق';

  @override
  String get verified_badge => 'موثق';

  @override
  String get unverified_badge => 'غير موثق';

  @override
  String get verified_donor => 'متبرع موثق';

  @override
  String get unverified_donor => 'متبرع غير موثق';

  @override
  String get security_access_label => 'الأمان والوصول';

  @override
  String get change_password => 'تغيير كلمة المرور';

  @override
  String get enable_fingerprint => 'تفعيل بصمة الإصبع';

  @override
  String get notifications_label => 'الإشعارات';

  @override
  String get push_notifications => 'الإشعارات الفورية';

  @override
  String get email_alerts => 'تنبيهات البريد الإلكتروني';

  @override
  String get sms_alerts => 'تنبيهات الرسائل النصية';

  @override
  String get preferences_label => 'التفضيلات';

  @override
  String get language_label => 'اللغة';

  @override
  String get theme_label => 'المظهر';

  @override
  String get theme_dark => 'داكن';

  @override
  String get theme_light => 'فاتح';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get next_eligible_donation => 'التبرع المؤهل التالي';

  @override
  String get days_label => 'يوم';

  @override
  String get cooldown_recovery_message => 'بروتوكول التعافي نشط. استمر في شرب الماء.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get donations_label => 'التبرعات';

  @override
  String get theme_settings_title => 'إعدادات المظهر';

  @override
  String get theme_system_default => 'الافتراضي للنظام';

  @override
  String get theme_system_description => 'تزامن تلقائيًا مع إعدادات جهازك.';

  @override
  String get theme_light_mode => 'الوضع الفاتح';

  @override
  String get theme_light_description => 'مثالي للبيئات السريرية عالية الوضوح.';

  @override
  String get theme_dark_mode => 'الوضع الداكن';

  @override
  String get theme_dark_description => 'وهج منخفض لاستخدام مريح أثناء الليل.';

  @override
  String get edit_profile_title => 'تعديل الملف الشخصي';

  @override
  String get save_changes => 'حفظ التغييرات';

  @override
  String get critical_notifications => 'الإشعارات الحرجة';

  @override
  String get urgent_notifications => 'الإشعارات العاجلة';

  @override
  String get normal_notifications => 'الإشعارات العادية';

  @override
  String get profile_updated_message => 'تم تحديث الملف الشخصي بنجاح.';

  @override
  String get no_internet_connection_title => 'لا يوجد اتصال بالإنترنت';

  @override
  String get no_internet_connection_message => 'يرجى التحقق من اتصالك والمحاولة مرة أخرى.';

  @override
  String get available_for_donation => 'متاح للتبرع';

  @override
  String get gamification_points => 'نقاط التبرع';
}
