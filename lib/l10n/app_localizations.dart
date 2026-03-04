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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to EventHub'**
  String get welcomeMessage;

  /// No description provided for @discoverEventsDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover amazing events around you, book tickets, and create unforgettable memories.'**
  String get discoverEventsDescription;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @connectCommunityTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect with your community'**
  String get connectCommunityTitle;

  /// No description provided for @connectCommunityDescription.
  ///
  /// In en, this message translates to:
  /// **'Meet like-minded people, share interests, and grow your professional network at the best events.'**
  String get connectCommunityDescription;

  /// No description provided for @personalPlannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Personal Event Planner'**
  String get personalPlannerTitle;

  /// No description provided for @personalPlannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Sync events to your device and get real-time reminders. We help you manage your time so you can focus on the experience.'**
  String get personalPlannerDescription;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'WELCOME!'**
  String get welcome;

  /// No description provided for @helloHome.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get helloHome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Log in Now'**
  String get loginNow;

  /// No description provided for @signInToAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get signInToAccount;

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

  /// No description provided for @emailExample.
  ///
  /// In en, this message translates to:
  /// **'example@gmail.com'**
  String get emailExample;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or log in with'**
  String get orLoginWith;

  /// No description provided for @enterEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we will send you a code to reset your password.'**
  String get enterEmailDescription;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @checkEmail.
  ///
  /// In en, this message translates to:
  /// **'Please check your email'**
  String get checkEmail;

  /// No description provided for @codeSentTo.
  ///
  /// In en, this message translates to:
  /// **'We have sent code to'**
  String get codeSentTo;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive a code?'**
  String get didNotReceiveCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get createNewPassword;

  /// No description provided for @createStrongPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a strong password to secure your account.'**
  String get createStrongPasswordDescription;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @signupNow.
  ///
  /// In en, this message translates to:
  /// **'Sign up Now'**
  String get signupNow;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @agreePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'I agree with privacy & policy'**
  String get agreePrivacyPolicy;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @orSignupWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get orSignupWith;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @eventReminder.
  ///
  /// In en, this message translates to:
  /// **'Event Reminder'**
  String get eventReminder;

  /// No description provided for @concertStartsSoon.
  ///
  /// In en, this message translates to:
  /// **'Your concert starts in 2 hours at City Stadium! Get your tickets ready.'**
  String get concertStartsSoon;

  /// No description provided for @minutesAgo7.
  ///
  /// In en, this message translates to:
  /// **'7 m ago'**
  String get minutesAgo7;

  /// No description provided for @bookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed'**
  String get bookingConfirmed;

  /// No description provided for @bookingConfirmedDescription.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed! You can now find your tickets in the Tickets section'**
  String get bookingConfirmedDescription;

  /// No description provided for @oneHourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 h ago'**
  String get oneHourAgo;

  /// No description provided for @specialOffer.
  ///
  /// In en, this message translates to:
  /// **'Special Offer'**
  String get specialOffer;

  /// No description provided for @exclusiveOfferDescription.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Offer! Get 20% off on your next booking using code: EVENT20'**
  String get exclusiveOfferDescription;

  /// No description provided for @sevenHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'7 h ago'**
  String get sevenHoursAgo;

  /// No description provided for @locationUpdate.
  ///
  /// In en, this message translates to:
  /// **'Location Update'**
  String get locationUpdate;

  /// No description provided for @artWorkshopLocationUpdate.
  ///
  /// In en, this message translates to:
  /// **'Important Update: the Art Workshop has been moved to Hall B'**
  String get artWorkshopLocationUpdate;

  /// No description provided for @twelveHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'12 h ago'**
  String get twelveHoursAgo;

  /// No description provided for @eventCancellation.
  ///
  /// In en, this message translates to:
  /// **'Event Cancellation'**
  String get eventCancellation;

  /// No description provided for @eventCancellationDescription.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, the Tech Meetup scheduled for tomorrow has been cancelled. Stay tuned for updates.'**
  String get eventCancellationDescription;

  /// No description provided for @oneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get oneDayAgo;

  /// No description provided for @newEventAvailable.
  ///
  /// In en, this message translates to:
  /// **'New Event Available'**
  String get newEventAvailable;

  /// No description provided for @newEventAvailableDescription.
  ///
  /// In en, this message translates to:
  /// **'A new Music Festival event has been added. Check it out and reserve your spot now!'**
  String get newEventAvailableDescription;

  /// No description provided for @twoDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get twoDaysAgo;

  /// No description provided for @photoWorkshopReminder.
  ///
  /// In en, this message translates to:
  /// **'Event Reminder'**
  String get photoWorkshopReminder;

  /// No description provided for @photoWorkshopReminderDescription.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget the Photography Workshop happening this weekend. Limited seats available.'**
  String get photoWorkshopReminderDescription;

  /// No description provided for @threeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'3 days ago'**
  String get threeDaysAgo;

  /// No description provided for @ticketExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Ticket Expiring Soon'**
  String get ticketExpiringSoon;

  /// No description provided for @ticketExpiringSoonDescription.
  ///
  /// In en, this message translates to:
  /// **'Reminder: Your reserved ticket will expire soon. Complete your booking before it becomes unavailable.'**
  String get ticketExpiringSoonDescription;

  /// No description provided for @fourDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'4 days ago'**
  String get fourDaysAgo;

  /// No description provided for @findEvent.
  ///
  /// In en, this message translates to:
  /// **'Find Event'**
  String get findEvent;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @upcomingEvents.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Events'**
  String get upcomingEvents;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @eventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get eventTitle;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateTime;

  /// No description provided for @nearbyEvents.
  ///
  /// In en, this message translates to:
  /// **'Nearby Events'**
  String get nearbyEvents;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'\$ price'**
  String get priceLabel;

  /// No description provided for @chooseLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Location'**
  String get chooseLocation;

  /// No description provided for @locationDescription.
  ///
  /// In en, this message translates to:
  /// **'Find events near you or in a specific city'**
  String get locationDescription;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get useCurrentLocation;

  /// No description provided for @gpsDescription.
  ///
  /// In en, this message translates to:
  /// **'Uses your device’s GPS'**
  String get gpsDescription;

  /// No description provided for @enterLocationManually.
  ///
  /// In en, this message translates to:
  /// **'Or Enter Manually'**
  String get enterLocationManually;

  /// No description provided for @searchCityHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a city...'**
  String get searchCityHint;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @eventReminderDescription.
  ///
  /// In en, this message translates to:
  /// **'Your concert starts in 2 hours at City Stadium! Get your tickets ready.'**
  String get eventReminderDescription;

  /// No description provided for @bookingConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed'**
  String get bookingConfirmedTitle;

  /// No description provided for @specialOfferTitle.
  ///
  /// In en, this message translates to:
  /// **'Special Offer'**
  String get specialOfferTitle;

  /// No description provided for @specialOfferDescription.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Offer! Get 20% off on your next booking using code : EVENT20'**
  String get specialOfferDescription;

  /// No description provided for @locationUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Update'**
  String get locationUpdateTitle;

  /// No description provided for @locationUpdateDescription.
  ///
  /// In en, this message translates to:
  /// **'Important Update: the Art Workshop has been moved to Hall B'**
  String get locationUpdateDescription;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @bookingCode.
  ///
  /// In en, this message translates to:
  /// **'Booking Code'**
  String get bookingCode;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @tickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get tickets;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @downloadTicket.
  ///
  /// In en, this message translates to:
  /// **'Download Ticket'**
  String get downloadTicket;

  /// No description provided for @bookingId.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingId;

  /// No description provided for @numberOfTickets.
  ///
  /// In en, this message translates to:
  /// **'Number of tickets:'**
  String get numberOfTickets;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time:'**
  String get timeLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get dateLabel;

  /// No description provided for @rowLabel.
  ///
  /// In en, this message translates to:
  /// **'Row:'**
  String get rowLabel;

  /// No description provided for @venueLabel.
  ///
  /// In en, this message translates to:
  /// **'Venue:'**
  String get venueLabel;

  /// No description provided for @sectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Section:'**
  String get sectionLabel;

  /// No description provided for @newCairo.
  ///
  /// In en, this message translates to:
  /// **'New Cairo'**
  String get newCairo;

  /// No description provided for @favoriteEvents.
  ///
  /// In en, this message translates to:
  /// **'Favorite Events'**
  String get favoriteEvents;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @termsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Terms & Privacy'**
  String get termsPrivacy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @changePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Picture'**
  String get changePicture;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @retypePassword.
  ///
  /// In en, this message translates to:
  /// **'Retype Password'**
  String get retypePassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @aboutEvent.
  ///
  /// In en, this message translates to:
  /// **'About Event'**
  String get aboutEvent;

  /// No description provided for @eventDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Everything you need to know about this event'**
  String get eventDetailsDescription;

  /// No description provided for @speakers.
  ///
  /// In en, this message translates to:
  /// **'Speakers'**
  String get speakers;

  /// No description provided for @speakerName.
  ///
  /// In en, this message translates to:
  /// **'Speaker Name:'**
  String get speakerName;

  /// No description provided for @omarTarek.
  ///
  /// In en, this message translates to:
  /// **'Omar Tarek'**
  String get omarTarek;

  /// No description provided for @topic.
  ///
  /// In en, this message translates to:
  /// **'Topic:'**
  String get topic;

  /// No description provided for @science.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get science;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @arts.
  ///
  /// In en, this message translates to:
  /// **'Arts'**
  String get arts;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @tech.
  ///
  /// In en, this message translates to:
  /// **'Tech'**
  String get tech;

  /// No description provided for @fashion.
  ///
  /// In en, this message translates to:
  /// **'Fashion'**
  String get fashion;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @helpSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'We are here to help you at any time. If you experience any issues while using the EventHub app or have any questions or suggestions, please feel free to contact us. Our support team is committed to responding to all inquiries as quickly as possible to ensure the best experience for you.\nYou can reach us via email at:\n\neventhubsupport@eventhub.com'**
  String get helpSupportDescription;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsDescription.
  ///
  /// In en, this message translates to:
  /// **'This is the settings page. Here you can customize your EventHub experience by adjusting various preferences and options. You can enable or disable notifications, and configure other app features to suit your needs.'**
  String get settingsDescription;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable app notifications'**
  String get enableNotifications;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyText.
  ///
  /// In en, this message translates to:
  /// **'This is the privacy policy of EventHub. We value your privacy and are committed to protecting your personal information. We collect and use your data in accordance with this policy. By using our app, you agree to the terms outlined in this privacy policy.\n\nTerms and Conditions\n\nBy using this application, you agree to the following terms and conditions:\n\n1. Use of the Application\nYou agree to use the application only for lawful purposes and not to misuse any of its services or content.\n\n2. Privacy Policy\nWe respect users\' privacy and may collect certain information such as name, email address, or phone number to improve user experience.\n\n3. Data Protection\nWe are committed to protecting user data and will not share personal information with third parties without user consent.\n\n4. User Responsibility\nUsers are responsible for the accuracy of the information they provide within the application.\n\n5. Modifications\nWe reserve the right to modify these terms and conditions at any time. Continued use of the application indicates acceptance of any changes.\n\nIf you have any questions, please contact us via email.'**
  String get privacyPolicyText;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'This is the language settings page. Here you can select your preferred language for the EventHub app. We currently support English and Arabic.\nPlease select your language from the options below.'**
  String get languageDescription;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullName;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enterEmail;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @phoneMustBe11Digits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be exactly 11 digits'**
  String get phoneMustBe11Digits;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordNumbersOnly.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be numbers only'**
  String get passwordNumbersOnly;

  /// No description provided for @retypePasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Retype Password'**
  String get retypePasswordHint;

  /// No description provided for @retypePasswordError.
  ///
  /// In en, this message translates to:
  /// **'Retype password'**
  String get retypePasswordError;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @goToResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Go to reset password'**
  String get goToResetPassword;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAccount;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'sports'**
  String get sports;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'education'**
  String get education;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
