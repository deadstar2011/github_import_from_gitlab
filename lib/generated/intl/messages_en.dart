// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(id) => "Delivery ${id}";

  static m1(howMany) => "${Intl.plural(howMany, zero: 'All orders delivered', one: 'It remains to deliver another ${howMany} order.', two: 'It remains to deliver another ${howMany} orders.', few: 'It remains to deliver another ${howMany} orders.', many: 'It remains to deliver another ${howMany} orders.', other: 'It remains to deliver another ${howMany} orders.')}";

  static m2(versionNumber) => "Version: ${versionNumber}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "EnterOrderDescription" : MessageLookupByLibrary.simpleMessage("Is the order delivered?"),
    "EnterOrderStatus" : MessageLookupByLibrary.simpleMessage("Enter order status"),
    "actionCall" : MessageLookupByLibrary.simpleMessage("Call"),
    "actionClientReady" : MessageLookupByLibrary.simpleMessage("Client ready"),
    "actionDelivered" : MessageLookupByLibrary.simpleMessage("Delivered"),
    "actionHaveProblems" : MessageLookupByLibrary.simpleMessage("Problems"),
    "actionNotDial" : MessageLookupByLibrary.simpleMessage("Not dial"),
    "actionStartMoving" : MessageLookupByLibrary.simpleMessage("Start moving"),
    "address" : MessageLookupByLibrary.simpleMessage("Address"),
    "allowTracking" : MessageLookupByLibrary.simpleMessage("Allow tracking"),
    "appBarShadow" : MessageLookupByLibrary.simpleMessage("App Bar Shadow"),
    "arrivedWarehouse" : MessageLookupByLibrary.simpleMessage("Arrived at the warehouse"),
    "assignedMark" : MessageLookupByLibrary.simpleMessage("queue"),
    "authNetworkError" : MessageLookupByLibrary.simpleMessage("An error has occurred.\n Automatic login failed"),
    "badCode" : MessageLookupByLibrary.simpleMessage("Incorrect code,\ntry again"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "changeUrl" : MessageLookupByLibrary.simpleMessage("Change url"),
    "chooseReason" : MessageLookupByLibrary.simpleMessage("Choose reason"),
    "client" : MessageLookupByLibrary.simpleMessage("Client"),
    "clientNotified" : MessageLookupByLibrary.simpleMessage("Client notified"),
    "clientNotifiedDescription" : MessageLookupByLibrary.simpleMessage("You can deliver the order."),
    "clientNotifiedMark" : MessageLookupByLibrary.simpleMessage("client notified"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "comment" : MessageLookupByLibrary.simpleMessage("comment"),
    "completeCallToDispatcher" : MessageLookupByLibrary.simpleMessage("contact the dispatcher."),
    "completeTheShift" : MessageLookupByLibrary.simpleMessage("To complete the shift"),
    "componentSamples" : MessageLookupByLibrary.simpleMessage("Component samples"),
    "connectionError" : MessageLookupByLibrary.simpleMessage("Connection error"),
    "contactClient" : MessageLookupByLibrary.simpleMessage("Contact client"),
    "contactClientDescription" : MessageLookupByLibrary.simpleMessage("Ask if he is ready to accept the order."),
    "costOfDelivery" : MessageLookupByLibrary.simpleMessage("Cost of delivery"),
    "courier" : MessageLookupByLibrary.simpleMessage("Courier"),
    "customer" : MessageLookupByLibrary.simpleMessage("Customer"),
    "defaultNetworkError" : MessageLookupByLibrary.simpleMessage("An error has occurred.\nOperation failed"),
    "deliveryHeader" : m0,
    "doNotDial" : MessageLookupByLibrary.simpleMessage("Do not dial"),
    "done" : MessageLookupByLibrary.simpleMessage("Done"),
    "endShift" : MessageLookupByLibrary.simpleMessage("Exit"),
    "exampleStatelessTitle" : MessageLookupByLibrary.simpleMessage("Example"),
    "exit" : MessageLookupByLibrary.simpleMessage("Exit"),
    "exitCallToDispatcher" : MessageLookupByLibrary.simpleMessage("contact the dispatcher."),
    "exitMessage" : MessageLookupByLibrary.simpleMessage("Leaving the application, you remain on the shift. To complete the shift, "),
    "finished" : MessageLookupByLibrary.simpleMessage("Order completed successfully"),
    "finishedMark" : MessageLookupByLibrary.simpleMessage("finished"),
    "finishedWithProblems" : MessageLookupByLibrary.simpleMessage("Order completed with problems"),
    "geolocationDisabled" : MessageLookupByLibrary.simpleMessage("Geolocation disabled"),
    "geolocationDisabledDescription" : MessageLookupByLibrary.simpleMessage("You cannot use the app with geolocation disabled. Turn on geolocation"),
    "goTo" : MessageLookupByLibrary.simpleMessage("Go to"),
    "goToDeliveriesList" : MessageLookupByLibrary.simpleMessage("Go to deliveries list"),
    "greatJob" : MessageLookupByLibrary.simpleMessage("Great job"),
    "headerTitle" : MessageLookupByLibrary.simpleMessage("Title"),
    "helpTooltip" : MessageLookupByLibrary.simpleMessage("If you have any problems,\ncontact dispatcher"),
    "incorrectPhone" : MessageLookupByLibrary.simpleMessage("Number is missing or incorrect"),
    "isPaid" : MessageLookupByLibrary.simpleMessage("paid"),
    "loading" : MessageLookupByLibrary.simpleMessage("loading..."),
    "loadingFailed" : MessageLookupByLibrary.simpleMessage("Loading failed"),
    "map" : MessageLookupByLibrary.simpleMessage("Map"),
    "needCallMark" : MessageLookupByLibrary.simpleMessage("need call"),
    "noGeolocation" : MessageLookupByLibrary.simpleMessage("No access to geolocation"),
    "noGeolocationDescription" : MessageLookupByLibrary.simpleMessage("You cannot use the app without location tracking. Allow tracking?"),
    "notDialMark" : MessageLookupByLibrary.simpleMessage("do not dial"),
    "notFoundNavigator" : MessageLookupByLibrary.simpleMessage("Yandex.Navigator was not found.\nYou can go to the Play Market to install it. Go?"),
    "notFoundPlayMarket" : MessageLookupByLibrary.simpleMessage("Play Market failed to start. Install Yandex.Navigator yourself"),
    "notOnShift" : MessageLookupByLibrary.simpleMessage("You are not on shift"),
    "notOnShiftDescription" : MessageLookupByLibrary.simpleMessage("To start a shift, you must arrive at the warehouse:"),
    "orderPrice" : MessageLookupByLibrary.simpleMessage("Order price"),
    "pageDelivery" : MessageLookupByLibrary.simpleMessage("Delivery page"),
    "pageDeliveryList" : MessageLookupByLibrary.simpleMessage("Delivery list"),
    "pageMap" : MessageLookupByLibrary.simpleMessage("Map page"),
    "pageProfile" : MessageLookupByLibrary.simpleMessage("Profile page"),
    "pageSign" : MessageLookupByLibrary.simpleMessage("Sign page"),
    "pagesSamples" : MessageLookupByLibrary.simpleMessage("Application pages"),
    "paymentMethod" : MessageLookupByLibrary.simpleMessage("Payment method"),
    "performedMark" : MessageLookupByLibrary.simpleMessage("performed"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("Phone number"),
    "problemsMark" : MessageLookupByLibrary.simpleMessage("finished"),
    "profile" : MessageLookupByLibrary.simpleMessage("Profile"),
    "refuseDelivery" : MessageLookupByLibrary.simpleMessage("The order was canceled by the dispatcher"),
    "refusedMark" : MessageLookupByLibrary.simpleMessage("refused"),
    "reset" : MessageLookupByLibrary.simpleMessage("Reset"),
    "restDeliveries" : m1,
    "route" : MessageLookupByLibrary.simpleMessage("Route"),
    "routeBeingFormed" : MessageLookupByLibrary.simpleMessage("The route is being formed"),
    "routeBeingFormedDescription" : MessageLookupByLibrary.simpleMessage("The process may take several minutes."),
    "routeCompleted" : MessageLookupByLibrary.simpleMessage("Route completed"),
    "routeCompletedDescription" : MessageLookupByLibrary.simpleMessage("Receive new deliveries in stock:"),
    "routeList" : MessageLookupByLibrary.simpleMessage("Route list"),
    "routeNotFormed" : MessageLookupByLibrary.simpleMessage("The route is not formed"),
    "routeNotFormedDescription" : MessageLookupByLibrary.simpleMessage("Contact dispatcher"),
    "salesNumber" : MessageLookupByLibrary.simpleMessage("Sales number"),
    "samplesControl" : MessageLookupByLibrary.simpleMessage("Control samples"),
    "samplesDelivery" : MessageLookupByLibrary.simpleMessage("Delivery samples"),
    "samplesFonts" : MessageLookupByLibrary.simpleMessage("Font samples"),
    "samplesIcon" : MessageLookupByLibrary.simpleMessage("Icon samples"),
    "samplesMap" : MessageLookupByLibrary.simpleMessage("Map samples"),
    "samplesModal" : MessageLookupByLibrary.simpleMessage("Modal samples"),
    "samplesProfile" : MessageLookupByLibrary.simpleMessage("Profile samples"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "showModal" : MessageLookupByLibrary.simpleMessage("Show modal window"),
    "signIn" : MessageLookupByLibrary.simpleMessage("Login to the application"),
    "time" : MessageLookupByLibrary.simpleMessage("Time"),
    "undefinedStatus" : MessageLookupByLibrary.simpleMessage("Status is undefined"),
    "updateReady" : MessageLookupByLibrary.simpleMessage("Update available"),
    "updateTryError" : MessageLookupByLibrary.simpleMessage("Failed to update the application."),
    "vehicle" : MessageLookupByLibrary.simpleMessage("Vehicle"),
    "version" : m2,
    "warehouseAddress" : MessageLookupByLibrary.simpleMessage("Warehouse address"),
    "whatIsTheProblem" : MessageLookupByLibrary.simpleMessage("What is the problem?"),
    "writeCode" : MessageLookupByLibrary.simpleMessage("Enter the code\nissued by the dispatcher")
  };
}
