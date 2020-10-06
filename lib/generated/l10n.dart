// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Example`
  String get exampleStatelessTitle {
    return Intl.message(
      'Example',
      name: 'exampleStatelessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get headerTitle {
    return Intl.message(
      'Title',
      name: 'headerTitle',
      desc: '',
      args: [],
    );
  }

  /// `App Bar Shadow`
  String get appBarShadow {
    return Intl.message(
      'App Bar Shadow',
      name: 'appBarShadow',
      desc: '',
      args: [],
    );
  }

  /// `Go to deliveries list`
  String get goToDeliveriesList {
    return Intl.message(
      'Go to deliveries list',
      name: 'goToDeliveriesList',
      desc: '',
      args: [],
    );
  }

  /// `Great job`
  String get greatJob {
    return Intl.message(
      'Great job',
      name: 'greatJob',
      desc: '',
      args: [],
    );
  }

  /// `What is the problem?`
  String get whatIsTheProblem {
    return Intl.message(
      'What is the problem?',
      name: 'whatIsTheProblem',
      desc: '',
      args: [],
    );
  }

  /// `Show modal window`
  String get showModal {
    return Intl.message(
      'Show modal window',
      name: 'showModal',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, zero{All orders delivered} one{It remains to deliver another {howMany} order.} two{It remains to deliver another {howMany} orders.} few{It remains to deliver another {howMany} orders.} many{It remains to deliver another {howMany} orders.} other{It remains to deliver another {howMany} orders.}}`
  String restDeliveries(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'All orders delivered',
      one: 'It remains to deliver another $howMany order.',
      two: 'It remains to deliver another $howMany orders.',
      few: 'It remains to deliver another $howMany orders.',
      many: 'It remains to deliver another $howMany orders.',
      other: 'It remains to deliver another $howMany orders.',
      name: 'restDeliveries',
      desc: '',
      args: [howMany],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Leaving the application, you remain on the shift. To complete the shift, `
  String get exitMessage {
    return Intl.message(
      'Leaving the application, you remain on the shift. To complete the shift, ',
      name: 'exitMessage',
      desc: '',
      args: [],
    );
  }

  /// `contact the dispatcher.`
  String get exitCallToDispatcher {
    return Intl.message(
      'contact the dispatcher.',
      name: 'exitCallToDispatcher',
      desc: '',
      args: [],
    );
  }

  /// `Contact client`
  String get contactClient {
    return Intl.message(
      'Contact client',
      name: 'contactClient',
      desc: '',
      args: [],
    );
  }

  /// `Ask if he is ready to accept the order.`
  String get contactClientDescription {
    return Intl.message(
      'Ask if he is ready to accept the order.',
      name: 'contactClientDescription',
      desc: '',
      args: [],
    );
  }

  /// `Client notified`
  String get clientNotified {
    return Intl.message(
      'Client notified',
      name: 'clientNotified',
      desc: '',
      args: [],
    );
  }

  /// `You can deliver the order.`
  String get clientNotifiedDescription {
    return Intl.message(
      'You can deliver the order.',
      name: 'clientNotifiedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter order status`
  String get EnterOrderStatus {
    return Intl.message(
      'Enter order status',
      name: 'EnterOrderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Is the order delivered?`
  String get EnterOrderDescription {
    return Intl.message(
      'Is the order delivered?',
      name: 'EnterOrderDescription',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get actionCall {
    return Intl.message(
      'Call',
      name: 'actionCall',
      desc: '',
      args: [],
    );
  }

  /// `Client ready`
  String get actionClientReady {
    return Intl.message(
      'Client ready',
      name: 'actionClientReady',
      desc: '',
      args: [],
    );
  }

  /// `Not dial`
  String get actionNotDial {
    return Intl.message(
      'Not dial',
      name: 'actionNotDial',
      desc: '',
      args: [],
    );
  }

  /// `Start moving`
  String get actionStartMoving {
    return Intl.message(
      'Start moving',
      name: 'actionStartMoving',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get actionDelivered {
    return Intl.message(
      'Delivered',
      name: 'actionDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Problems`
  String get actionHaveProblems {
    return Intl.message(
      'Problems',
      name: 'actionHaveProblems',
      desc: '',
      args: [],
    );
  }

  /// `Courier`
  String get courier {
    return Intl.message(
      'Courier',
      name: 'courier',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get client {
    return Intl.message(
      'Client',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Sales number`
  String get salesNumber {
    return Intl.message(
      'Sales number',
      name: 'salesNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Order price`
  String get orderPrice {
    return Intl.message(
      'Order price',
      name: 'orderPrice',
      desc: '',
      args: [],
    );
  }

  /// `Cost of delivery`
  String get costOfDelivery {
    return Intl.message(
      'Cost of delivery',
      name: 'costOfDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `comment`
  String get comment {
    return Intl.message(
      'comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `paid`
  String get isPaid {
    return Intl.message(
      'paid',
      name: 'isPaid',
      desc: '',
      args: [],
    );
  }

  /// `Warehouse address`
  String get warehouseAddress {
    return Intl.message(
      'Warehouse address',
      name: 'warehouseAddress',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle`
  String get vehicle {
    return Intl.message(
      'Vehicle',
      name: 'vehicle',
      desc: '',
      args: [],
    );
  }

  /// `You are not on shift`
  String get notOnShift {
    return Intl.message(
      'You are not on shift',
      name: 'notOnShift',
      desc: '',
      args: [],
    );
  }

  /// `To start a shift, you must arrive at the warehouse:`
  String get notOnShiftDescription {
    return Intl.message(
      'To start a shift, you must arrive at the warehouse:',
      name: 'notOnShiftDescription',
      desc: '',
      args: [],
    );
  }

  /// `The route is not formed`
  String get routeNotFormed {
    return Intl.message(
      'The route is not formed',
      name: 'routeNotFormed',
      desc: '',
      args: [],
    );
  }

  /// `Contact dispatcher`
  String get routeNotFormedDescription {
    return Intl.message(
      'Contact dispatcher',
      name: 'routeNotFormedDescription',
      desc: '',
      args: [],
    );
  }

  /// `The route is being formed`
  String get routeBeingFormed {
    return Intl.message(
      'The route is being formed',
      name: 'routeBeingFormed',
      desc: '',
      args: [],
    );
  }

  /// `The process may take several minutes.`
  String get routeBeingFormedDescription {
    return Intl.message(
      'The process may take several minutes.',
      name: 'routeBeingFormedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Route completed`
  String get routeCompleted {
    return Intl.message(
      'Route completed',
      name: 'routeCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Receive new deliveries in stock:`
  String get routeCompletedDescription {
    return Intl.message(
      'Receive new deliveries in stock:',
      name: 'routeCompletedDescription',
      desc: '',
      args: [],
    );
  }

  /// `No access to geolocation`
  String get noGeolocation {
    return Intl.message(
      'No access to geolocation',
      name: 'noGeolocation',
      desc: '',
      args: [],
    );
  }

  /// `You cannot use the app without location tracking. Allow tracking?`
  String get noGeolocationDescription {
    return Intl.message(
      'You cannot use the app without location tracking. Allow tracking?',
      name: 'noGeolocationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Arrived at the warehouse`
  String get arrivedWarehouse {
    return Intl.message(
      'Arrived at the warehouse',
      name: 'arrivedWarehouse',
      desc: '',
      args: [],
    );
  }

  /// `Allow tracking`
  String get allowTracking {
    return Intl.message(
      'Allow tracking',
      name: 'allowTracking',
      desc: '',
      args: [],
    );
  }

  /// `performed`
  String get performedMark {
    return Intl.message(
      'performed',
      name: 'performedMark',
      desc: '',
      args: [],
    );
  }

  /// `client notified`
  String get clientNotifiedMark {
    return Intl.message(
      'client notified',
      name: 'clientNotifiedMark',
      desc: '',
      args: [],
    );
  }

  /// `need call`
  String get needCallMark {
    return Intl.message(
      'need call',
      name: 'needCallMark',
      desc: '',
      args: [],
    );
  }

  /// `do not dial`
  String get notDialMark {
    return Intl.message(
      'do not dial',
      name: 'notDialMark',
      desc: '',
      args: [],
    );
  }

  /// `finished`
  String get finishedMark {
    return Intl.message(
      'finished',
      name: 'finishedMark',
      desc: '',
      args: [],
    );
  }

  /// `refused`
  String get refusedMark {
    return Intl.message(
      'refused',
      name: 'refusedMark',
      desc: '',
      args: [],
    );
  }

  /// `finished`
  String get problemsMark {
    return Intl.message(
      'finished',
      name: 'problemsMark',
      desc: '',
      args: [],
    );
  }

  /// `queue`
  String get assignedMark {
    return Intl.message(
      'queue',
      name: 'assignedMark',
      desc: '',
      args: [],
    );
  }

  /// `If you have any problems,\ncontact dispatcher`
  String get helpTooltip {
    return Intl.message(
      'If you have any problems,\ncontact dispatcher',
      name: 'helpTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code\nissued by the dispatcher`
  String get writeCode {
    return Intl.message(
      'Enter the code\nissued by the dispatcher',
      name: 'writeCode',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect code,\ntry again`
  String get badCode {
    return Intl.message(
      'Incorrect code,\ntry again',
      name: 'badCode',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get route {
    return Intl.message(
      'Route',
      name: 'route',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Login to the application`
  String get signIn {
    return Intl.message(
      'Login to the application',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Route list`
  String get routeList {
    return Intl.message(
      'Route list',
      name: 'routeList',
      desc: '',
      args: [],
    );
  }

  /// `To complete the shift`
  String get completeTheShift {
    return Intl.message(
      'To complete the shift',
      name: 'completeTheShift',
      desc: '',
      args: [],
    );
  }

  /// `contact the dispatcher.`
  String get completeCallToDispatcher {
    return Intl.message(
      'contact the dispatcher.',
      name: 'completeCallToDispatcher',
      desc: '',
      args: [],
    );
  }

  /// `Delivery {id}`
  String deliveryHeader(Object id) {
    return Intl.message(
      'Delivery $id',
      name: 'deliveryHeader',
      desc: '',
      args: [id],
    );
  }

  /// `Component samples`
  String get componentSamples {
    return Intl.message(
      'Component samples',
      name: 'componentSamples',
      desc: '',
      args: [],
    );
  }

  /// `Icon samples`
  String get samplesIcon {
    return Intl.message(
      'Icon samples',
      name: 'samplesIcon',
      desc: '',
      args: [],
    );
  }

  /// `Control samples`
  String get samplesControl {
    return Intl.message(
      'Control samples',
      name: 'samplesControl',
      desc: '',
      args: [],
    );
  }

  /// `Font samples`
  String get samplesFonts {
    return Intl.message(
      'Font samples',
      name: 'samplesFonts',
      desc: '',
      args: [],
    );
  }

  /// `Modal samples`
  String get samplesModal {
    return Intl.message(
      'Modal samples',
      name: 'samplesModal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery samples`
  String get samplesDelivery {
    return Intl.message(
      'Delivery samples',
      name: 'samplesDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Profile samples`
  String get samplesProfile {
    return Intl.message(
      'Profile samples',
      name: 'samplesProfile',
      desc: '',
      args: [],
    );
  }

  /// `Map samples`
  String get samplesMap {
    return Intl.message(
      'Map samples',
      name: 'samplesMap',
      desc: '',
      args: [],
    );
  }

  /// `Application pages`
  String get pagesSamples {
    return Intl.message(
      'Application pages',
      name: 'pagesSamples',
      desc: '',
      args: [],
    );
  }

  /// `Sign page`
  String get pageSign {
    return Intl.message(
      'Sign page',
      name: 'pageSign',
      desc: '',
      args: [],
    );
  }

  /// `Delivery list`
  String get pageDeliveryList {
    return Intl.message(
      'Delivery list',
      name: 'pageDeliveryList',
      desc: '',
      args: [],
    );
  }

  /// `Delivery page`
  String get pageDelivery {
    return Intl.message(
      'Delivery page',
      name: 'pageDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Map page`
  String get pageMap {
    return Intl.message(
      'Map page',
      name: 'pageMap',
      desc: '',
      args: [],
    );
  }

  /// `Profile page`
  String get pageProfile {
    return Intl.message(
      'Profile page',
      name: 'pageProfile',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get endShift {
    return Intl.message(
      'Exit',
      name: 'endShift',
      desc: '',
      args: [],
    );
  }

  /// `Version: {versionNumber}`
  String version(Object versionNumber) {
    return Intl.message(
      'Version: $versionNumber',
      name: 'version',
      desc: '',
      args: [versionNumber],
    );
  }

  /// `loading...`
  String get loading {
    return Intl.message(
      'loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Loading failed`
  String get loadingFailed {
    return Intl.message(
      'Loading failed',
      name: 'loadingFailed',
      desc: '',
      args: [],
    );
  }

  /// `The order was canceled by the dispatcher`
  String get refuseDelivery {
    return Intl.message(
      'The order was canceled by the dispatcher',
      name: 'refuseDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Order completed with problems`
  String get finishedWithProblems {
    return Intl.message(
      'Order completed with problems',
      name: 'finishedWithProblems',
      desc: '',
      args: [],
    );
  }

  /// `Order completed successfully`
  String get finished {
    return Intl.message(
      'Order completed successfully',
      name: 'finished',
      desc: '',
      args: [],
    );
  }

  /// `Do not dial`
  String get doNotDial {
    return Intl.message(
      'Do not dial',
      name: 'doNotDial',
      desc: '',
      args: [],
    );
  }

  /// `Connection error`
  String get connectionError {
    return Intl.message(
      'Connection error',
      name: 'connectionError',
      desc: '',
      args: [],
    );
  }

  /// `Choose reason`
  String get chooseReason {
    return Intl.message(
      'Choose reason',
      name: 'chooseReason',
      desc: '',
      args: [],
    );
  }

  /// `Status is undefined`
  String get undefinedStatus {
    return Intl.message(
      'Status is undefined',
      name: 'undefinedStatus',
      desc: '',
      args: [],
    );
  }

  /// `Geolocation disabled`
  String get geolocationDisabled {
    return Intl.message(
      'Geolocation disabled',
      name: 'geolocationDisabled',
      desc: '',
      args: [],
    );
  }

  /// `You cannot use the app with geolocation disabled. Turn on geolocation`
  String get geolocationDisabledDescription {
    return Intl.message(
      'You cannot use the app with geolocation disabled. Turn on geolocation',
      name: 'geolocationDisabledDescription',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred.\nOperation failed`
  String get defaultNetworkError {
    return Intl.message(
      'An error has occurred.\nOperation failed',
      name: 'defaultNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred.\n Automatic login failed`
  String get authNetworkError {
    return Intl.message(
      'An error has occurred.\n Automatic login failed',
      name: 'authNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update the application.`
  String get updateTryError {
    return Intl.message(
      'Failed to update the application.',
      name: 'updateTryError',
      desc: '',
      args: [],
    );
  }

  /// `Update available`
  String get updateReady {
    return Intl.message(
      'Update available',
      name: 'updateReady',
      desc: '',
      args: [],
    );
  }

  /// `Change url`
  String get changeUrl {
    return Intl.message(
      'Change url',
      name: 'changeUrl',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Number is missing or incorrect`
  String get incorrectPhone {
    return Intl.message(
      'Number is missing or incorrect',
      name: 'incorrectPhone',
      desc: '',
      args: [],
    );
  }

  /// `Go to`
  String get goTo {
    return Intl.message(
      'Go to',
      name: 'goTo',
      desc: '',
      args: [],
    );
  }

  /// `Yandex.Navigator was not found.\nYou can go to the Play Market to install it. Go?`
  String get notFoundNavigator {
    return Intl.message(
      'Yandex.Navigator was not found.\nYou can go to the Play Market to install it. Go?',
      name: 'notFoundNavigator',
      desc: '',
      args: [],
    );
  }

  /// `Play Market failed to start. Install Yandex.Navigator yourself`
  String get notFoundPlayMarket {
    return Intl.message(
      'Play Market failed to start. Install Yandex.Navigator yourself',
      name: 'notFoundPlayMarket',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}