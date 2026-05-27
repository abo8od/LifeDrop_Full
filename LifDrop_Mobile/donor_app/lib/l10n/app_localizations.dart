import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @life_drop.
  ///
  /// In en, this message translates to:
  /// **'Life Drop'**
  String get life_drop;

  /// No description provided for @app_first_name.
  ///
  /// In en, this message translates to:
  /// **'Life'**
  String get app_first_name;

  /// No description provided for @app_last_name.
  ///
  /// In en, this message translates to:
  /// **' Drop'**
  String get app_last_name;

  /// No description provided for @app_tagline.
  ///
  /// In en, this message translates to:
  /// **'LIFE IS IN YOUR BLOOD'**
  String get app_tagline;

  /// No description provided for @splash_loading_text.
  ///
  /// In en, this message translates to:
  /// **'INITIALIZING SYNC...'**
  String get splash_loading_text;

  /// No description provided for @app_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get app_version;

  /// No description provided for @app_build.
  ///
  /// In en, this message translates to:
  /// **'Built for Altruism'**
  String get app_build;

  /// No description provided for @pulse.
  ///
  /// In en, this message translates to:
  /// **'Pulse'**
  String get pulse;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Save life with\nevery drop'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Approved Donations'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_title_3_part_1.
  ///
  /// In en, this message translates to:
  /// **'Smart'**
  String get onboarding_title_3_part_1;

  /// No description provided for @onboarding_title_3_part_2.
  ///
  /// In en, this message translates to:
  /// **'\nNotifications'**
  String get onboarding_title_3_part_2;

  /// No description provided for @onboarding_subtitle_1.
  ///
  /// In en, this message translates to:
  /// **'Join a global network of altruistic heroes dedicated `to providing life-saving blood donations.'**
  String get onboarding_subtitle_1;

  /// No description provided for @onboarding_subtitle_2.
  ///
  /// In en, this message translates to:
  /// **'Every donation is clinically verified and tracked from your arm to the patient in need.'**
  String get onboarding_subtitle_2;

  /// No description provided for @onboarding_subtitle_3.
  ///
  /// In en, this message translates to:
  /// **'Receive instant alerts when your specific blood type is needed urgently in nearby hospitals.'**
  String get onboarding_subtitle_3;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK, READY TO SAVE LIFE?'**
  String get welcome_back;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @register_now.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get register_now;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @new_donor.
  ///
  /// In en, this message translates to:
  /// **'New Donor?'**
  String get new_donor;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @become_donor.
  ///
  /// In en, this message translates to:
  /// **'BECOME A LIFE-SAVING DONOR'**
  String get become_donor;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @select_blood_type.
  ///
  /// In en, this message translates to:
  /// **'SELECT BLOOD TYPE'**
  String get select_blood_type;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// No description provided for @forgot_password_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email or phone number toreceive a verification code.'**
  String get forgot_password_subtitle;

  /// No description provided for @back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get back_to_login;

  /// No description provided for @send_otp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get send_otp;

  /// No description provided for @otp_verification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otp_verification;

  /// No description provided for @otp_from_forgot_password_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to your email. Enter it below to continue.'**
  String get otp_from_forgot_password_subtitle;

  /// No description provided for @otp_from_register_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to your email. Enter it below to create an account.'**
  String get otp_from_register_subtitle;

  /// No description provided for @verify_continue.
  ///
  /// In en, this message translates to:
  /// **'Verify & Continue'**
  String get verify_continue;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @reset_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Ensure your new password is at least 8 characters long with Uppercase, Lowercase, Digits and symbols.'**
  String get reset_subtitle;

  /// No description provided for @update_password.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password;

  /// No description provided for @didnt_receive_code.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get didnt_receive_code;

  /// No description provided for @resend_timer.
  ///
  /// In en, this message translates to:
  /// **'Resend in'**
  String get resend_timer;

  /// No description provided for @resend_again.
  ///
  /// In en, this message translates to:
  /// **'Resend again'**
  String get resend_again;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'REQUIRED'**
  String get required;

  /// No description provided for @quick_login.
  ///
  /// In en, this message translates to:
  /// **'Quick Login'**
  String get quick_login;

  /// No description provided for @enable_biometric_login_message.
  ///
  /// In en, this message translates to:
  /// **'Use your fingerprint for faster and secure login next time'**
  String get enable_biometric_login_message;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @authenticate_to_login.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to Login'**
  String get authenticate_to_login;

  /// No description provided for @use_fingerprint_for_quick_secure_login.
  ///
  /// In en, this message translates to:
  /// **'Use your fingerprint to login quickly and securely'**
  String get use_fingerprint_for_quick_secure_login;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @welcome_back_home.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back,'**
  String get welcome_back_home;

  /// No description provided for @donation_impact_message.
  ///
  /// In en, this message translates to:
  /// **'Your last donation helped save 3 lives at {hospital}.'**
  String donation_impact_message(Object hospital);

  /// No description provided for @next_donation_availability.
  ///
  /// In en, this message translates to:
  /// **' You\'re eligible to donate again in {days} days.'**
  String next_donation_availability(Object days);

  /// No description provided for @total_contributions.
  ///
  /// In en, this message translates to:
  /// **'Total Contributions'**
  String get total_contributions;

  /// No description provided for @donations.
  ///
  /// In en, this message translates to:
  /// **'Donations'**
  String get donations;

  /// No description provided for @tens_donation.
  ///
  /// In en, this message translates to:
  /// **'Donations'**
  String get tens_donation;

  /// No description provided for @active_requests.
  ///
  /// In en, this message translates to:
  /// **'Active Requests'**
  String get active_requests;

  /// No description provided for @view_all_requests.
  ///
  /// In en, this message translates to:
  /// **'View All Requests'**
  String get view_all_requests;

  /// No description provided for @no_active_requests_found.
  ///
  /// In en, this message translates to:
  /// **'No active donation requests right now.'**
  String get no_active_requests_found;

  /// No description provided for @search_requests_hint.
  ///
  /// In en, this message translates to:
  /// **'Search requests'**
  String get search_requests_hint;

  /// No description provided for @all_filter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_filter;

  /// No description provided for @normal_filter.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal_filter;

  /// No description provided for @urgent_filter.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent_filter;

  /// No description provided for @critical_filter.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get critical_filter;

  /// No description provided for @all_requests_count.
  ///
  /// In en, this message translates to:
  /// **'{count} requests'**
  String all_requests_count(Object count);

  /// No description provided for @urgent_priority.
  ///
  /// In en, this message translates to:
  /// **'URGENT PRIORITY'**
  String get urgent_priority;

  /// No description provided for @donation_progress.
  ///
  /// In en, this message translates to:
  /// **'Donation\nProgress'**
  String get donation_progress;

  /// No description provided for @donors_confirmed_progress.
  ///
  /// In en, this message translates to:
  /// **'{confirmed}/{total} donors\nconfirmed'**
  String donors_confirmed_progress(Object confirmed, Object total);

  /// No description provided for @urgent_Donors_needed_message.
  ///
  /// In en, this message translates to:
  /// **'{count} more donors are required to fulfill this emergency request. Your contribution can save a life today.'**
  String urgent_Donors_needed_message(Object count);

  /// No description provided for @got_to_map.
  ///
  /// In en, this message translates to:
  /// **'Go to Map'**
  String get got_to_map;

  /// No description provided for @accept_request.
  ///
  /// In en, this message translates to:
  /// **'Accept Request'**
  String get accept_request;

  /// No description provided for @request_details.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get request_details;

  /// No description provided for @you_are_a_lifesaver.
  ///
  /// In en, this message translates to:
  /// **'You\'re a lifesaver!'**
  String get you_are_a_lifesaver;

  /// No description provided for @request_accepted_hospital_waiting.
  ///
  /// In en, this message translates to:
  /// **'Your request acceptance is confirmed.\nA hospital unit is expecting your arrival.'**
  String get request_accepted_hospital_waiting;

  /// No description provided for @hospital_location.
  ///
  /// In en, this message translates to:
  /// **'Hospital Location'**
  String get hospital_location;

  /// No description provided for @bring_digital_id.
  ///
  /// In en, this message translates to:
  /// **'Bring your digital ID'**
  String get bring_digital_id;

  /// No description provided for @start_navigation.
  ///
  /// In en, this message translates to:
  /// **'Start Navigation'**
  String get start_navigation;

  /// No description provided for @birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birth_date;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @more_info.
  ///
  /// In en, this message translates to:
  /// **'MORE INFO'**
  String get more_info;

  /// No description provided for @first_name_required.
  ///
  /// In en, this message translates to:
  /// **'First name is required.'**
  String get first_name_required;

  /// No description provided for @last_name_required.
  ///
  /// In en, this message translates to:
  /// **'Last name is required.'**
  String get last_name_required;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get email_required;

  /// No description provided for @phone_required.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number.\nMust start with 77, 78 and 79.'**
  String get phone_required;

  /// No description provided for @phone_number_digits_only.
  ///
  /// In en, this message translates to:
  /// **'Phone number must contain digits only.'**
  String get phone_number_digits_only;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Password must be more than 8 chars, include uppercase and lowercase letters, number, symbol, no spaces.'**
  String get password_required;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwords_do_not_match;

  /// No description provided for @birth_date_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter birth date.'**
  String get birth_date_required;

  /// No description provided for @governorate_required.
  ///
  /// In en, this message translates to:
  /// **'Please select governorate.'**
  String get governorate_required;

  /// No description provided for @district_required.
  ///
  /// In en, this message translates to:
  /// **'Please select district.'**
  String get district_required;

  /// No description provided for @blood_type_required.
  ///
  /// In en, this message translates to:
  /// **'Please select blood type.'**
  String get blood_type_required;

  /// No description provided for @response_now_button.
  ///
  /// In en, this message translates to:
  /// **'Response Now'**
  String get response_now_button;

  /// No description provided for @schedule_appointment_button.
  ///
  /// In en, this message translates to:
  /// **'Schedule Appointment'**
  String get schedule_appointment_button;

  /// No description provided for @send_code_message.
  ///
  /// In en, this message translates to:
  /// **'Verification code has been sent.'**
  String get send_code_message;

  /// No description provided for @resend_code_message.
  ///
  /// In en, this message translates to:
  /// **'Verification code has been sent again.'**
  String get resend_code_message;

  /// No description provided for @account_acreated_message.
  ///
  /// In en, this message translates to:
  /// **'Account has been created successfully.'**
  String get account_acreated_message;

  /// No description provided for @verification_code_sent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully.\nPlease check your email to continue.'**
  String get verification_code_sent;

  /// No description provided for @password_updated_message.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully.'**
  String get password_updated_message;

  /// No description provided for @donation_cancelled_success.
  ///
  /// In en, this message translates to:
  /// **'The donation was successfully cancelled.'**
  String get donation_cancelled_success;

  /// No description provided for @no_active_donation_found.
  ///
  /// In en, this message translates to:
  /// **'Not Found Active Donation Now.'**
  String get no_active_donation_found;

  /// No description provided for @go_back_label.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get go_back_label;

  /// No description provided for @select_cancellation_reason_title.
  ///
  /// In en, this message translates to:
  /// **'Select Reason for Cancellation'**
  String get select_cancellation_reason_title;

  /// No description provided for @select_reason_hint.
  ///
  /// In en, this message translates to:
  /// **'Select a reason'**
  String get select_reason_hint;

  /// No description provided for @reason_required_error.
  ///
  /// In en, this message translates to:
  /// **'Must select reason to cancel donation'**
  String get reason_required_error;

  /// No description provided for @cancellation_health_warning.
  ///
  /// In en, this message translates to:
  /// **'* Note: For health-related cancellations, you may be temporarily deferred from donating to ensure your own safety.'**
  String get cancellation_health_warning;

  /// No description provided for @optional_note_label.
  ///
  /// In en, this message translates to:
  /// **'Note (optionally)'**
  String get optional_note_label;

  /// No description provided for @confirm_cancellation_button.
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancellation'**
  String get confirm_cancellation_button;

  /// No description provided for @go_back_button.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get go_back_button;

  /// No description provided for @review_heading.
  ///
  /// In en, this message translates to:
  /// **'Review\n'**
  String get review_heading;

  /// No description provided for @cancellation_heading.
  ///
  /// In en, this message translates to:
  /// **'Cancellation'**
  String get cancellation_heading;

  /// No description provided for @cancellation_description.
  ///
  /// In en, this message translates to:
  /// **'We understand that plans change. Please let us know why you need to cancel this donation request.'**
  String get cancellation_description;

  /// No description provided for @blood_type_label.
  ///
  /// In en, this message translates to:
  /// **'BLOOD TYPE'**
  String get blood_type_label;

  /// No description provided for @units_requested_label.
  ///
  /// In en, this message translates to:
  /// **'UNITS REQUESTED'**
  String get units_requested_label;

  /// No description provided for @priority_label.
  ///
  /// In en, this message translates to:
  /// **'PRIORITY'**
  String get priority_label;

  /// No description provided for @impact_label.
  ///
  /// In en, this message translates to:
  /// **'IMPACT'**
  String get impact_label;

  /// No description provided for @saves_lives_value.
  ///
  /// In en, this message translates to:
  /// **'Saves 3 Lives'**
  String get saves_lives_value;

  /// No description provided for @hours_abbreviation.
  ///
  /// In en, this message translates to:
  /// **'HRS'**
  String get hours_abbreviation;

  /// No description provided for @minutes_abbreviation.
  ///
  /// In en, this message translates to:
  /// **'MINS'**
  String get minutes_abbreviation;

  /// No description provided for @seconds_abbreviation.
  ///
  /// In en, this message translates to:
  /// **'SECS'**
  String get seconds_abbreviation;

  /// No description provided for @request_expired_heading.
  ///
  /// In en, this message translates to:
  /// **'REQUEST EXPIRED'**
  String get request_expired_heading;

  /// No description provided for @request_expires_in_heading.
  ///
  /// In en, this message translates to:
  /// **'REQUEST EXPIRES IN'**
  String get request_expires_in_heading;

  /// No description provided for @request_expired_message.
  ///
  /// In en, this message translates to:
  /// **'The request has expired.\nPlease check for new requests.'**
  String get request_expired_message;

  /// No description provided for @arrive_before_timer_message.
  ///
  /// In en, this message translates to:
  /// **'Please arrive before the timer reaches zero to\nensure your donation is processed.'**
  String get arrive_before_timer_message;

  /// No description provided for @help_support_text.
  ///
  /// In en, this message translates to:
  /// **'Need assistance? Use the contact button\nabove or '**
  String get help_support_text;

  /// No description provided for @view_guidelines_link.
  ///
  /// In en, this message translates to:
  /// **'view donation guidelines'**
  String get view_guidelines_link;

  /// No description provided for @destination_label.
  ///
  /// In en, this message translates to:
  /// **'DESTINATION'**
  String get destination_label;

  /// No description provided for @contact_hospital_button.
  ///
  /// In en, this message translates to:
  /// **'Contact Hospital'**
  String get contact_hospital_button;

  /// No description provided for @cancel_donation_button.
  ///
  /// In en, this message translates to:
  /// **'Cancel Donation'**
  String get cancel_donation_button;

  /// No description provided for @emergency_blood_needed_headline.
  ///
  /// In en, this message translates to:
  /// **'Emergency Blood Needed'**
  String get emergency_blood_needed_headline;

  /// No description provided for @critical_tag.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL'**
  String get critical_tag;

  /// No description provided for @km_away_suffix.
  ///
  /// In en, this message translates to:
  /// **'Km away'**
  String get km_away_suffix;

  /// No description provided for @select_governorate_hint.
  ///
  /// In en, this message translates to:
  /// **'Select Governorate'**
  String get select_governorate_hint;

  /// No description provided for @select_district_hint.
  ///
  /// In en, this message translates to:
  /// **'Select District'**
  String get select_district_hint;

  /// No description provided for @date_of_birth_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Select Date of Birth'**
  String get date_of_birth_placeholder;

  /// No description provided for @cancellation_impact_message.
  ///
  /// In en, this message translates to:
  /// **'Canceling this request may affect your donor reliability score.\nConsistent donations help hospitals plan life-saving procedures more effectively.'**
  String get cancellation_impact_message;

  /// No description provided for @impact_on_reliability.
  ///
  /// In en, this message translates to:
  /// **'Impact on Reliability'**
  String get impact_on_reliability;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'{value} Units'**
  String units(Object value);

  /// No description provided for @language_settings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get language_settings;

  /// No description provided for @language_settings_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get language_settings_subtitle;

  /// No description provided for @language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_english;

  /// No description provided for @language_arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get language_arabic;

  /// No description provided for @current_language_label.
  ///
  /// In en, this message translates to:
  /// **'CURRENT LANGUAGE'**
  String get current_language_label;

  /// No description provided for @available_languages_label.
  ///
  /// In en, this message translates to:
  /// **'AVAILABLE LANGUAGES'**
  String get available_languages_label;

  /// No description provided for @language_changed_message.
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully'**
  String get language_changed_message;

  /// No description provided for @account_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get account_settings_title;

  /// No description provided for @personal_information_label.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL INFORMATION'**
  String get personal_information_label;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @verification_status.
  ///
  /// In en, this message translates to:
  /// **'Verification Status'**
  String get verification_status;

  /// No description provided for @verified_badge.
  ///
  /// In en, this message translates to:
  /// **'VERIFIED'**
  String get verified_badge;

  /// No description provided for @unverified_badge.
  ///
  /// In en, this message translates to:
  /// **'UNVERIFIED'**
  String get unverified_badge;

  /// No description provided for @verified_donor.
  ///
  /// In en, this message translates to:
  /// **'VERIFIED DONOR'**
  String get verified_donor;

  /// No description provided for @unverified_donor.
  ///
  /// In en, this message translates to:
  /// **'UNVERIFIED DONOR'**
  String get unverified_donor;

  /// No description provided for @security_access_label.
  ///
  /// In en, this message translates to:
  /// **'SECURITY & ACCESS'**
  String get security_access_label;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @enable_fingerprint.
  ///
  /// In en, this message translates to:
  /// **'Enable Fingerprint'**
  String get enable_fingerprint;

  /// No description provided for @notifications_label.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get notifications_label;

  /// No description provided for @push_notifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get push_notifications;

  /// No description provided for @email_alerts.
  ///
  /// In en, this message translates to:
  /// **'Email Alerts'**
  String get email_alerts;

  /// No description provided for @sms_alerts.
  ///
  /// In en, this message translates to:
  /// **'SMS Alerts'**
  String get sms_alerts;

  /// No description provided for @preferences_label.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences_label;

  /// No description provided for @language_label.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get language_label;

  /// No description provided for @theme_label.
  ///
  /// In en, this message translates to:
  /// **'THEME'**
  String get theme_label;

  /// No description provided for @theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_dark;

  /// No description provided for @theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_light;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @next_eligible_donation.
  ///
  /// In en, this message translates to:
  /// **'NEXT ELIGIBLE DONATION'**
  String get next_eligible_donation;

  /// No description provided for @days_label.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days_label;

  /// No description provided for @cooldown_recovery_message.
  ///
  /// In en, this message translates to:
  /// **'Recovery protocol active. Keep staying hydrated.'**
  String get cooldown_recovery_message;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @donations_label.
  ///
  /// In en, this message translates to:
  /// **'DONATIONS'**
  String get donations_label;

  /// No description provided for @theme_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get theme_settings_title;

  /// No description provided for @theme_system_default.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get theme_system_default;

  /// No description provided for @theme_system_description.
  ///
  /// In en, this message translates to:
  /// **'Automatically sync with your device settings.'**
  String get theme_system_description;

  /// No description provided for @theme_light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get theme_light_mode;

  /// No description provided for @theme_light_description.
  ///
  /// In en, this message translates to:
  /// **'Optimal for high-clarity clinical environments.'**
  String get theme_light_description;

  /// No description provided for @theme_dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get theme_dark_mode;

  /// No description provided for @theme_dark_description.
  ///
  /// In en, this message translates to:
  /// **'Reduced glare for comfortable nighttime use.'**
  String get theme_dark_description;

  /// No description provided for @edit_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile_title;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @critical_notifications.
  ///
  /// In en, this message translates to:
  /// **'Critical Notifications'**
  String get critical_notifications;

  /// No description provided for @urgent_notifications.
  ///
  /// In en, this message translates to:
  /// **'Urgent Notifications'**
  String get urgent_notifications;

  /// No description provided for @normal_notifications.
  ///
  /// In en, this message translates to:
  /// **'Normal Notifications'**
  String get normal_notifications;

  /// No description provided for @profile_updated_message.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profile_updated_message;

  /// No description provided for @no_internet_connection_title.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get no_internet_connection_title;

  /// No description provided for @no_internet_connection_message.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection and try again.'**
  String get no_internet_connection_message;

  /// No description provided for @available_for_donation.
  ///
  /// In en, this message translates to:
  /// **'Available for Donation'**
  String get available_for_donation;

  /// No description provided for @gamification_points.
  ///
  /// In en, this message translates to:
  /// **'Gamification Points'**
  String get gamification_points;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
