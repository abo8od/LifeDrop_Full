// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get life_drop => 'Life Drop';

  @override
  String get app_first_name => 'Life';

  @override
  String get app_last_name => ' Drop';

  @override
  String get app_tagline => 'LIFE IS IN YOUR BLOOD';

  @override
  String get splash_loading_text => 'INITIALIZING SYNC...';

  @override
  String get app_version => 'Version';

  @override
  String get app_build => 'Built for Altruism';

  @override
  String get pulse => 'Pulse';

  @override
  String get onboarding_title_1 => 'Save life with\nevery drop';

  @override
  String get onboarding_title_2 => 'Approved Donations';

  @override
  String get onboarding_title_3_part_1 => 'Smart';

  @override
  String get onboarding_title_3_part_2 => '\nNotifications';

  @override
  String get onboarding_subtitle_1 => 'Join a global network of altruistic heroes dedicated `to providing life-saving blood donations.';

  @override
  String get onboarding_subtitle_2 => 'Every donation is clinically verified and tracked from your arm to the patient in need.';

  @override
  String get onboarding_subtitle_3 => 'Receive instant alerts when your specific blood type is needed urgently in nearby hospitals.';

  @override
  String get next => 'Next';

  @override
  String get get_started => 'Get Started';

  @override
  String get login => 'Login';

  @override
  String get welcome_back => 'WELCOME BACK, READY TO SAVE LIFE?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get register_now => 'Register Now';

  @override
  String get forgot_password => 'Forgot Password?';

  @override
  String get new_donor => 'New Donor?';

  @override
  String get register => 'Register';

  @override
  String get become_donor => 'BECOME A LIFE-SAVING DONOR';

  @override
  String get first_name => 'First Name';

  @override
  String get last_name => 'Last Name';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get new_password => 'New Password';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get select_blood_type => 'SELECT BLOOD TYPE';

  @override
  String get already_have_an_account => 'Already have an account?';

  @override
  String get forgot_password_subtitle => 'Enter your registered email or phone number toreceive a verification code.';

  @override
  String get back_to_login => 'Back to Login';

  @override
  String get send_otp => 'Send OTP';

  @override
  String get otp_verification => 'OTP Verification';

  @override
  String get otp_from_forgot_password_subtitle => 'We\'ve sent a 6-digit code to your email. Enter it below to continue.';

  @override
  String get otp_from_register_subtitle => 'We\'ve sent a 6-digit code to your email. Enter it below to create an account.';

  @override
  String get verify_continue => 'Verify & Continue';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get reset_subtitle => 'Ensure your new password is at least 8 characters long with Uppercase, Lowercase, Digits and symbols.';

  @override
  String get update_password => 'Update Password';

  @override
  String get didnt_receive_code => 'Didn\'t receive code?';

  @override
  String get resend_timer => 'Resend in';

  @override
  String get resend_again => 'Resend again';

  @override
  String get required => 'REQUIRED';

  @override
  String get quick_login => 'Quick Login';

  @override
  String get enable_biometric_login_message => 'Use your fingerprint for faster and secure login next time';

  @override
  String get accounts => 'Accounts';

  @override
  String get authenticate_to_login => 'Authenticate to Login';

  @override
  String get use_fingerprint_for_quick_secure_login => 'Use your fingerprint to login quickly and securely';

  @override
  String get enable => 'Enable';

  @override
  String get skip => 'Skip';

  @override
  String get welcome_back_home => 'Welcome Back,';

  @override
  String donation_impact_message(Object hospital) {
    return 'Your last donation helped save 3 lives at $hospital.';
  }

  @override
  String next_donation_availability(Object days) {
    return ' You\'re eligible to donate again in $days days.';
  }

  @override
  String get total_contributions => 'Total Contributions';

  @override
  String get donations => 'Donations';

  @override
  String get tens_donation => 'Donations';

  @override
  String get active_requests => 'Active Requests';

  @override
  String get view_all_requests => 'View All Requests';

  @override
  String get no_active_requests_found => 'No active donation requests right now.';

  @override
  String get search_requests_hint => 'Search requests';

  @override
  String get all_filter => 'All';

  @override
  String get normal_filter => 'Normal';

  @override
  String get urgent_filter => 'Urgent';

  @override
  String get critical_filter => 'Critical';

  @override
  String all_requests_count(Object count) {
    return '$count requests';
  }

  @override
  String get urgent_priority => 'URGENT PRIORITY';

  @override
  String get donation_progress => 'Donation\nProgress';

  @override
  String donors_confirmed_progress(Object confirmed, Object total) {
    return '$confirmed/$total donors\nconfirmed';
  }

  @override
  String urgent_Donors_needed_message(Object count) {
    return '$count more donors are required to fulfill this emergency request. Your contribution can save a life today.';
  }

  @override
  String get got_to_map => 'Go to Map';

  @override
  String get accept_request => 'Accept Request';

  @override
  String get request_details => 'Request Details';

  @override
  String get you_are_a_lifesaver => 'You\'re a lifesaver!';

  @override
  String get request_accepted_hospital_waiting => 'Your request acceptance is confirmed.\nA hospital unit is expecting your arrival.';

  @override
  String get hospital_location => 'Hospital Location';

  @override
  String get bring_digital_id => 'Bring your digital ID';

  @override
  String get start_navigation => 'Start Navigation';

  @override
  String get birth_date => 'Birth Date';

  @override
  String get governorate => 'Governorate';

  @override
  String get district => 'District';

  @override
  String get more_info => 'MORE INFO';

  @override
  String get first_name_required => 'First name is required.';

  @override
  String get last_name_required => 'Last name is required.';

  @override
  String get email_required => 'Please enter a valid email address.';

  @override
  String get phone_required => 'Invalid phone number.\nMust start with 77, 78 and 79.';

  @override
  String get phone_number_digits_only => 'Phone number must contain digits only.';

  @override
  String get password_required => 'Password must be more than 8 chars, include uppercase and lowercase letters, number, symbol, no spaces.';

  @override
  String get passwords_do_not_match => 'Passwords do not match.';

  @override
  String get birth_date_required => 'Please enter birth date.';

  @override
  String get governorate_required => 'Please select governorate.';

  @override
  String get district_required => 'Please select district.';

  @override
  String get blood_type_required => 'Please select blood type.';

  @override
  String get response_now_button => 'Response Now';

  @override
  String get schedule_appointment_button => 'Schedule Appointment';

  @override
  String get send_code_message => 'Verification code has been sent.';

  @override
  String get resend_code_message => 'Verification code has been sent again.';

  @override
  String get account_acreated_message => 'Account has been created successfully.';

  @override
  String get verification_code_sent => 'Verification code sent successfully.\nPlease check your email to continue.';

  @override
  String get password_updated_message => 'Password updated successfully.';

  @override
  String get donation_cancelled_success => 'The donation was successfully cancelled.';

  @override
  String get no_active_donation_found => 'Not Found Active Donation Now.';

  @override
  String get go_back_label => 'Go Back';

  @override
  String get select_cancellation_reason_title => 'Select Reason for Cancellation';

  @override
  String get select_reason_hint => 'Select a reason';

  @override
  String get reason_required_error => 'Must select reason to cancel donation';

  @override
  String get cancellation_health_warning => '* Note: For health-related cancellations, you may be temporarily deferred from donating to ensure your own safety.';

  @override
  String get optional_note_label => 'Note (optionally)';

  @override
  String get confirm_cancellation_button => 'Confirm Cancellation';

  @override
  String get go_back_button => 'Go Back';

  @override
  String get review_heading => 'Review\n';

  @override
  String get cancellation_heading => 'Cancellation';

  @override
  String get cancellation_description => 'We understand that plans change. Please let us know why you need to cancel this donation request.';

  @override
  String get blood_type_label => 'BLOOD TYPE';

  @override
  String get units_requested_label => 'UNITS REQUESTED';

  @override
  String get priority_label => 'PRIORITY';

  @override
  String get impact_label => 'IMPACT';

  @override
  String get saves_lives_value => 'Saves 3 Lives';

  @override
  String get hours_abbreviation => 'HRS';

  @override
  String get minutes_abbreviation => 'MINS';

  @override
  String get seconds_abbreviation => 'SECS';

  @override
  String get request_expired_heading => 'REQUEST EXPIRED';

  @override
  String get request_expires_in_heading => 'REQUEST EXPIRES IN';

  @override
  String get request_expired_message => 'The request has expired.\nPlease check for new requests.';

  @override
  String get arrive_before_timer_message => 'Please arrive before the timer reaches zero to\nensure your donation is processed.';

  @override
  String get help_support_text => 'Need assistance? Use the contact button\nabove or ';

  @override
  String get view_guidelines_link => 'view donation guidelines';

  @override
  String get destination_label => 'DESTINATION';

  @override
  String get contact_hospital_button => 'Contact Hospital';

  @override
  String get cancel_donation_button => 'Cancel Donation';

  @override
  String get emergency_blood_needed_headline => 'Emergency Blood Needed';

  @override
  String get critical_tag => 'CRITICAL';

  @override
  String get km_away_suffix => 'Km away';

  @override
  String get select_governorate_hint => 'Select Governorate';

  @override
  String get select_district_hint => 'Select District';

  @override
  String get date_of_birth_placeholder => 'Select Date of Birth';

  @override
  String get cancellation_impact_message => 'Canceling this request may affect your donor reliability score.\nConsistent donations help hospitals plan life-saving procedures more effectively.';

  @override
  String get impact_on_reliability => 'Impact on Reliability';

  @override
  String units(Object value) {
    return '$value Units';
  }

  @override
  String get language_settings => 'Language Settings';

  @override
  String get language_settings_subtitle => 'Select your preferred language';

  @override
  String get language_english => 'English';

  @override
  String get language_arabic => 'العربية';

  @override
  String get current_language_label => 'CURRENT LANGUAGE';

  @override
  String get available_languages_label => 'AVAILABLE LANGUAGES';

  @override
  String get language_changed_message => 'Language changed successfully';

  @override
  String get account_settings_title => 'Account Settings';

  @override
  String get personal_information_label => 'PERSONAL INFORMATION';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get verification_status => 'Verification Status';

  @override
  String get verified_badge => 'VERIFIED';

  @override
  String get unverified_badge => 'UNVERIFIED';

  @override
  String get verified_donor => 'VERIFIED DONOR';

  @override
  String get unverified_donor => 'UNVERIFIED DONOR';

  @override
  String get security_access_label => 'SECURITY & ACCESS';

  @override
  String get change_password => 'Change Password';

  @override
  String get enable_fingerprint => 'Enable Fingerprint';

  @override
  String get notifications_label => 'NOTIFICATIONS';

  @override
  String get push_notifications => 'Push Notifications';

  @override
  String get email_alerts => 'Email Alerts';

  @override
  String get sms_alerts => 'SMS Alerts';

  @override
  String get preferences_label => 'PREFERENCES';

  @override
  String get language_label => 'LANGUAGE';

  @override
  String get theme_label => 'THEME';

  @override
  String get theme_dark => 'Dark';

  @override
  String get theme_light => 'Light';

  @override
  String get logout => 'Logout';

  @override
  String get next_eligible_donation => 'NEXT ELIGIBLE DONATION';

  @override
  String get days_label => 'Days';

  @override
  String get cooldown_recovery_message => 'Recovery protocol active. Keep staying hydrated.';

  @override
  String get retry => 'Retry';

  @override
  String get donations_label => 'DONATIONS';

  @override
  String get theme_settings_title => 'Theme Settings';

  @override
  String get theme_system_default => 'System Default';

  @override
  String get theme_system_description => 'Automatically sync with your device settings.';

  @override
  String get theme_light_mode => 'Light Mode';

  @override
  String get theme_light_description => 'Optimal for high-clarity clinical environments.';

  @override
  String get theme_dark_mode => 'Dark Mode';

  @override
  String get theme_dark_description => 'Reduced glare for comfortable nighttime use.';

  @override
  String get edit_profile_title => 'Edit Profile';

  @override
  String get save_changes => 'Save Changes';

  @override
  String get critical_notifications => 'Critical Notifications';

  @override
  String get urgent_notifications => 'Urgent Notifications';

  @override
  String get normal_notifications => 'Normal Notifications';

  @override
  String get profile_updated_message => 'Profile updated successfully.';

  @override
  String get no_internet_connection_title => 'No Internet Connection';

  @override
  String get no_internet_connection_message => 'Please check your connection and try again.';

  @override
  String get available_for_donation => 'Available for Donation';

  @override
  String get gamification_points => 'Gamification Points';
}
