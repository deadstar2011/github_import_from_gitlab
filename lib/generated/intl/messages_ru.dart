// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static m0(id) => "Заказ ${id}";

  static m1(howMany) => "${Intl.plural(howMany, zero: 'Все заказы доставлены', one: 'Осталось доставить еще ${howMany} заказ.', two: 'Осталось доставить еще ${howMany} заказа.', few: 'Осталось доставить еще ${howMany} заказов.', many: 'Осталось доставить еще ${howMany} заказов.', other: 'Осталось доставить еще ${howMany} заказов.')}";

  static m2(versionNumber) => "Версия ${versionNumber}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "EnterOrderDescription" : MessageLookupByLibrary.simpleMessage("Доставлен ли заказ?"),
    "EnterOrderStatus" : MessageLookupByLibrary.simpleMessage("Укажите статус заказа"),
    "actionCall" : MessageLookupByLibrary.simpleMessage("Позвонить"),
    "actionClientReady" : MessageLookupByLibrary.simpleMessage("Клиент готов"),
    "actionDelivered" : MessageLookupByLibrary.simpleMessage("Доставлен"),
    "actionHaveProblems" : MessageLookupByLibrary.simpleMessage("Проблемы"),
    "actionNotDial" : MessageLookupByLibrary.simpleMessage("Недозвон"),
    "actionStartMoving" : MessageLookupByLibrary.simpleMessage("Начать движение"),
    "address" : MessageLookupByLibrary.simpleMessage("Адрес"),
    "allowTracking" : MessageLookupByLibrary.simpleMessage("Разрешить отслеживание"),
    "appBarShadow" : MessageLookupByLibrary.simpleMessage("Тень для app бара"),
    "arrivedWarehouse" : MessageLookupByLibrary.simpleMessage("Прибыл на склад"),
    "assignedMark" : MessageLookupByLibrary.simpleMessage("в очереди"),
    "authNetworkError" : MessageLookupByLibrary.simpleMessage("Произошла ошибка.\nВыполнить автоматический вход не удалось"),
    "badCode" : MessageLookupByLibrary.simpleMessage("Неверный код,\nповторите попытку"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Отмена"),
    "changeUrl" : MessageLookupByLibrary.simpleMessage("Смена урла"),
    "chooseReason" : MessageLookupByLibrary.simpleMessage("Выберите причину"),
    "client" : MessageLookupByLibrary.simpleMessage("Клиент"),
    "clientNotified" : MessageLookupByLibrary.simpleMessage("Клиент уведомлен"),
    "clientNotifiedDescription" : MessageLookupByLibrary.simpleMessage("Вы можете доставить заказ"),
    "clientNotifiedMark" : MessageLookupByLibrary.simpleMessage("клиент в курсе"),
    "close" : MessageLookupByLibrary.simpleMessage("Закрыть"),
    "comment" : MessageLookupByLibrary.simpleMessage("Комментарий"),
    "completeCallToDispatcher" : MessageLookupByLibrary.simpleMessage("свяжитесь с диспетчером."),
    "completeTheShift" : MessageLookupByLibrary.simpleMessage("Для завершения смены,"),
    "componentSamples" : MessageLookupByLibrary.simpleMessage("Примеры компонентов"),
    "connectionError" : MessageLookupByLibrary.simpleMessage("Не удалось подключиться"),
    "contactClient" : MessageLookupByLibrary.simpleMessage("Свяжитесь с клиентом"),
    "contactClientDescription" : MessageLookupByLibrary.simpleMessage("Уточните, готов ли он принять заказ"),
    "costOfDelivery" : MessageLookupByLibrary.simpleMessage("Стоимость доставки"),
    "courier" : MessageLookupByLibrary.simpleMessage("Курьер"),
    "customer" : MessageLookupByLibrary.simpleMessage("Заказчик"),
    "defaultNetworkError" : MessageLookupByLibrary.simpleMessage("Произошла ошибка.\nОперация не выполнена"),
    "deliveryHeader" : m0,
    "doNotDial" : MessageLookupByLibrary.simpleMessage("Не удалось дозвониться"),
    "done" : MessageLookupByLibrary.simpleMessage("Готово"),
    "endShift" : MessageLookupByLibrary.simpleMessage("Выйти"),
    "exampleStatelessTitle" : MessageLookupByLibrary.simpleMessage("Пример"),
    "exit" : MessageLookupByLibrary.simpleMessage("Выйти"),
    "exitCallToDispatcher" : MessageLookupByLibrary.simpleMessage("свяжитесь с диспетчером."),
    "exitMessage" : MessageLookupByLibrary.simpleMessage("Выходя из приложения, вы остаетесь на смене. Чтобы завершить смену, "),
    "finished" : MessageLookupByLibrary.simpleMessage("Заказ успешено завершен"),
    "finishedMark" : MessageLookupByLibrary.simpleMessage("завершен"),
    "finishedWithProblems" : MessageLookupByLibrary.simpleMessage("Заказ завершен с проблемами"),
    "geolocationDisabled" : MessageLookupByLibrary.simpleMessage("Геолокация отключена"),
    "geolocationDisabledDescription" : MessageLookupByLibrary.simpleMessage("Вы не можете использовать приложение с отключенной геолокацией. Включите геолокацию"),
    "goTo" : MessageLookupByLibrary.simpleMessage("Перейти"),
    "goToDeliveriesList" : MessageLookupByLibrary.simpleMessage("К списку заказов"),
    "greatJob" : MessageLookupByLibrary.simpleMessage("Отличная работа"),
    "headerTitle" : MessageLookupByLibrary.simpleMessage("Заголовок"),
    "helpTooltip" : MessageLookupByLibrary.simpleMessage("Если у вас возникли проблемы,\nсвяжитесь с диспетчером"),
    "incorrectPhone" : MessageLookupByLibrary.simpleMessage("Номер отсутствует или некорректен"),
    "isPaid" : MessageLookupByLibrary.simpleMessage("оплачено"),
    "loading" : MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "loadingFailed" : MessageLookupByLibrary.simpleMessage("Ошибка загрузки"),
    "map" : MessageLookupByLibrary.simpleMessage("Карта"),
    "needCallMark" : MessageLookupByLibrary.simpleMessage("нужно позвонить"),
    "noGeolocation" : MessageLookupByLibrary.simpleMessage("Нет доступа к геолокации"),
    "noGeolocationDescription" : MessageLookupByLibrary.simpleMessage("Вы не можете использовать приложение без отслежования местоположения. Разрешить отслеживание?"),
    "notDialMark" : MessageLookupByLibrary.simpleMessage("недозвон"),
    "notFoundNavigator" : MessageLookupByLibrary.simpleMessage("Яндекс.Навигатор не найден.\nВы можете перейти в Play Market чтобы его установить. Перейти?"),
    "notFoundPlayMarket" : MessageLookupByLibrary.simpleMessage("Не удалось запустить Play Market. Установите Яндекс.Навигатор самостоятельно"),
    "notOnShift" : MessageLookupByLibrary.simpleMessage("Вы не на смене"),
    "notOnShiftDescription" : MessageLookupByLibrary.simpleMessage("Чтобы заступить на смену,вы должны прибыть на склад:"),
    "orderPrice" : MessageLookupByLibrary.simpleMessage("Сумма заказа"),
    "pageDelivery" : MessageLookupByLibrary.simpleMessage("Страница доставки"),
    "pageDeliveryList" : MessageLookupByLibrary.simpleMessage("Страница доставок"),
    "pageMap" : MessageLookupByLibrary.simpleMessage("Страница карты"),
    "pageProfile" : MessageLookupByLibrary.simpleMessage("Страница профиля"),
    "pageSign" : MessageLookupByLibrary.simpleMessage("Страница входа"),
    "pagesSamples" : MessageLookupByLibrary.simpleMessage("Страницы приложения"),
    "paymentMethod" : MessageLookupByLibrary.simpleMessage("Способ оплаты"),
    "performedMark" : MessageLookupByLibrary.simpleMessage("исполняется"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("Телефон"),
    "problemsMark" : MessageLookupByLibrary.simpleMessage("завершен"),
    "profile" : MessageLookupByLibrary.simpleMessage("Профиль"),
    "refuseDelivery" : MessageLookupByLibrary.simpleMessage("Заказ был отменен диспетчером"),
    "refusedMark" : MessageLookupByLibrary.simpleMessage("отменен диспетчером"),
    "reset" : MessageLookupByLibrary.simpleMessage("Сбросить"),
    "restDeliveries" : m1,
    "route" : MessageLookupByLibrary.simpleMessage("Маршрут"),
    "routeBeingFormed" : MessageLookupByLibrary.simpleMessage("Маршрут формируется"),
    "routeBeingFormedDescription" : MessageLookupByLibrary.simpleMessage("Процесс может занять несколько минут"),
    "routeCompleted" : MessageLookupByLibrary.simpleMessage("Маршрут исполнен"),
    "routeCompletedDescription" : MessageLookupByLibrary.simpleMessage("Получите новые заказы на складе:"),
    "routeList" : MessageLookupByLibrary.simpleMessage("Маршрутный лист"),
    "routeNotFormed" : MessageLookupByLibrary.simpleMessage("Маршрут не сформирован"),
    "routeNotFormedDescription" : MessageLookupByLibrary.simpleMessage("Уточните информацию у диспетчера"),
    "salesNumber" : MessageLookupByLibrary.simpleMessage("Номер реализации"),
    "samplesControl" : MessageLookupByLibrary.simpleMessage("Примеры контролов"),
    "samplesDelivery" : MessageLookupByLibrary.simpleMessage("Примеры заказов"),
    "samplesFonts" : MessageLookupByLibrary.simpleMessage("Примеры шрифтов"),
    "samplesIcon" : MessageLookupByLibrary.simpleMessage("Примеры иконок"),
    "samplesMap" : MessageLookupByLibrary.simpleMessage("Примеры карты"),
    "samplesModal" : MessageLookupByLibrary.simpleMessage("Примеры модалок"),
    "samplesProfile" : MessageLookupByLibrary.simpleMessage("Примеры профиля"),
    "save" : MessageLookupByLibrary.simpleMessage("Сохранить"),
    "showModal" : MessageLookupByLibrary.simpleMessage("Показать модальное окно"),
    "signIn" : MessageLookupByLibrary.simpleMessage("Вход в приложение"),
    "time" : MessageLookupByLibrary.simpleMessage("Время"),
    "undefinedStatus" : MessageLookupByLibrary.simpleMessage("Статус не определен"),
    "updateReady" : MessageLookupByLibrary.simpleMessage("Доступно обновление"),
    "updateTryError" : MessageLookupByLibrary.simpleMessage("Не удалось обновить приложение."),
    "vehicle" : MessageLookupByLibrary.simpleMessage("Транспорт"),
    "version" : m2,
    "warehouseAddress" : MessageLookupByLibrary.simpleMessage("Адрес склада"),
    "whatIsTheProblem" : MessageLookupByLibrary.simpleMessage("Укажите в чем проблема"),
    "writeCode" : MessageLookupByLibrary.simpleMessage("Введите код,\n выданный диспетчером")
  };
}
