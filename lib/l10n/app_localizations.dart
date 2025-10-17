import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_mn.dart';

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
    Locale('en'),
    Locale('mn')
  ];

  /// will be used in auth error dialog
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// will be used in dialog
  ///
  /// In en, this message translates to:
  /// **'We\'re sorry'**
  String get weAreSorry;

  /// will be used in dialog
  ///
  /// In en, this message translates to:
  /// **'Sorry'**
  String get sorry;

  /// will be used in auth error dialog
  ///
  /// In en, this message translates to:
  /// **'Username or password is incorrect'**
  String get description401;

  /// will be used in database error dialog
  ///
  /// In en, this message translates to:
  /// **'This action is currently not possible. Please try again later.'**
  String get description503;

  /// will be used in general error dialog
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get description500;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get loginSuccess;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection'**
  String get noInternet;

  /// No description provided for @incorrectUserPass.
  ///
  /// In en, this message translates to:
  /// **'Username or password is incorrect.'**
  String get incorrectUserPass;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @connectionRecovered.
  ///
  /// In en, this message translates to:
  /// **'Connection Recovered'**
  String get connectionRecovered;

  /// No description provided for @homeDescriptionLess.
  ///
  /// In en, this message translates to:
  /// **'MIAT operates a non-punitive reporting system to encourage timely and open reporting of hazards and risks related to flight safety, quality, and aviation security...'**
  String get homeDescriptionLess;

  /// No description provided for @homeDescriptionMore.
  ///
  /// In en, this message translates to:
  /// **'MIAT operates a non-punitive reporting system to encourage timely and open reporting of hazards and risks related to flight safety, quality, and aviation security. Based on the information, we analyze the violations, take measures to reduce the risk, correct it, and prevent future occurrences. In the event of confidential information being submitted, the confidentiality of the informant will be strictly maintained. Thank you for contributing to improving flight safety by submitting safety information.'**
  String get homeDescriptionMore;

  /// No description provided for @reportHazard.
  ///
  /// In en, this message translates to:
  /// **'Hazard report'**
  String get reportHazard;

  /// No description provided for @confidentialHazardReport.
  ///
  /// In en, this message translates to:
  /// **'Confidential hazard report'**
  String get confidentialHazardReport;

  /// No description provided for @otherChannels.
  ///
  /// In en, this message translates to:
  /// **'Other channels'**
  String get otherChannels;

  /// No description provided for @hazardDetails.
  ///
  /// In en, this message translates to:
  /// **'Hazard details'**
  String get hazardDetails;

  /// No description provided for @hazardCode.
  ///
  /// In en, this message translates to:
  /// **'Hazard code'**
  String get hazardCode;

  /// No description provided for @sentDate.
  ///
  /// In en, this message translates to:
  /// **'Sent date'**
  String get sentDate;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @yourRequestWasSent.
  ///
  /// In en, this message translates to:
  /// **'Your request was sent & we will report about process soon'**
  String get yourRequestWasSent;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get content;

  /// No description provided for @solution.
  ///
  /// In en, this message translates to:
  /// **'Recommended solution'**
  String get solution;

  /// No description provided for @hazardReportChannels.
  ///
  /// In en, this message translates to:
  /// **'Hazard report channels'**
  String get hazardReportChannels;

  /// No description provided for @confidentialReportChannels.
  ///
  /// In en, this message translates to:
  /// **'Confidential report channels'**
  String get confidentialReportChannels;

  /// No description provided for @infomationCenter.
  ///
  /// In en, this message translates to:
  /// **'Information center'**
  String get infomationCenter;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @web.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get web;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @myReports.
  ///
  /// In en, this message translates to:
  /// **'My reports'**
  String get myReports;

  /// No description provided for @youDontHaveReport.
  ///
  /// In en, this message translates to:
  /// **'Currently, you haven\'t sent any report'**
  String get youDontHaveReport;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @youDontHaveNotif.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get youDontHaveNotif;

  /// No description provided for @sentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Your request was sent successfully'**
  String get sentSuccessfully;

  /// No description provided for @weWillUseThisForOnly.
  ///
  /// In en, this message translates to:
  /// **'We will use your report for only risks related to flight safety, quality, and aviation security'**
  String get weWillUseThisForOnly;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get selectLocation;

  /// No description provided for @hazardDescription.
  ///
  /// In en, this message translates to:
  /// **'Please describe in detail the threat, risk.'**
  String get hazardDescription;

  /// No description provided for @tooShort.
  ///
  /// In en, this message translates to:
  /// **'too short'**
  String get tooShort;

  /// No description provided for @suggession.
  ///
  /// In en, this message translates to:
  /// **'Suggestions for reducing and eliminating risks'**
  String get suggession;

  /// No description provided for @suggessionLong.
  ///
  /// In en, this message translates to:
  /// **'Please provide suggestions on what can be done to prevent such mistakes from happening again.'**
  String get suggessionLong;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @takePicture.
  ///
  /// In en, this message translates to:
  /// **'Take a picture'**
  String get takePicture;

  /// No description provided for @attachzPicture.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get attachzPicture;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @ifYouHideYourIdentity.
  ///
  /// In en, this message translates to:
  /// **'If submitted anonymously, your personal information will only be visible to authorized personnel.'**
  String get ifYouHideYourIdentity;

  /// No description provided for @thisReportCanOnly.
  ///
  /// In en, this message translates to:
  /// **'This special form can only be submitted by internal employees, and if you are an employee, you must be logged in.'**
  String get thisReportCanOnly;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @areYouSureYouLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouLogout;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get contactInfo;

  /// No description provided for @weNeedToAskYou.
  ///
  /// In en, this message translates to:
  /// **'Please provide the relevant information as it is necessary to clarify the information and report back on the measures taken.'**
  String get weNeedToAskYou;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @continueee.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueee;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'mn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'mn': return AppLocalizationsMn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
