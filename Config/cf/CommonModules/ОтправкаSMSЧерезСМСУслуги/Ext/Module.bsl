﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Отправляет SMS через СМС-Услуги.
//
// Параметры:
//  НомераПолучателей - Массив - номера получателей в формате +7ХХХХХХХХХХ;
//  Текст 			  - Строка - текст сообщения, длиной не более 480 символов;
//  ИмяОтправителя 	  - Строка - имя отправителя, которое будет отображаться вместо номера входящего SMS;
//  Логин			  - Строка - логин пользователя услуги отправки sms;
//  Пароль			  - Строка - пароль пользователя услуги отправки sms.
//
// Возвращаемое значение:
//  Структура: ОтправленныеСообщения - Массив структур: НомерОтправителя.
//                                                  ИдентификаторСообщения.
//             ОписаниеОшибки        - Строка - пользовательское представление ошибки, если пустая строка,
//                                          то ошибки нет.
Функция ОтправитьSMS(НомераПолучателей, Текст, ИмяОтправителя, Логин, Пароль) Экспорт
	
	Результат = Новый Структура("ОтправленныеСообщения,ОписаниеОшибки", Новый Массив, "");
	
	// Подготовка получателей.
	Получатели = Новый Массив;
	Для Каждого Элемент Из НомераПолучателей Цикл
		Получатель = ФорматироватьНомерДляОтправки(Элемент);
		Если Получатели.Найти(Получатель) = Неопределено Тогда
			Получатели.Добавить(Получатель);
		КонецЕсли;
	КонецЦикла;
	
	// Проверка на заполнение обязательных параметров.
	Если НомераПолучателей.Количество() = 0 Или ПустаяСтрока(Текст) Тогда
		Результат.ОписаниеОшибки = НСтр("ru = 'Неверные параметры сообщения'");
		Возврат Результат;
	КонецЕсли;
	
	// Подготовка параметров запроса.
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("login", Логин);
	ПараметрыЗапроса.Вставить("password", Пароль);
	ПараметрыЗапроса.Вставить("action", "send");
	ПараметрыЗапроса.Вставить("text", Текст);
	ПараметрыЗапроса.Вставить("to", Получатели);
	ПараметрыЗапроса.Вставить("source", ИмяОтправителя);
	
	// отправка запроса
	ТекстОтвета = ВыполнитьЗапрос("send.php", ПараметрыЗапроса);
	Если Не ЗначениеЗаполнено(ТекстОтвета) Тогда
		Результат.ОписаниеОшибки = Результат.ОписаниеОшибки + НСтр("ru = 'Соединение не установлено'");
		Возврат Результат;
	КонецЕсли;
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(ТекстОтвета);
	ОтветСервера = Новый Структура("code,descr,smsid");
	ЗаполнитьЗначенияСвойств(ОтветСервера, ФабрикаXDTO.ПрочитатьXML(ЧтениеXML));
	ЧтениеXML.Закрыть();
	
	КодРезультата = ОтветСервера.code;
	Если КодРезультата = "1" Тогда
		ИдентификаторСообщения = ОтветСервера.smsid;
		Для Каждого Получатель Из Получатели Цикл
			ОтправленноеСообщение = Новый Структура("НомерПолучателя,ИдентификаторСообщения", 
				ФорматироватьНомерИзРезультатаОтправки(Получатель), Получатель + "/" + ИдентификаторСообщения);
			Результат.ОтправленныеСообщения.Добавить(ОтправленноеСообщение);
		КонецЦикла;
	Иначе
		Результат.ОписаниеОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр(
			"ru = 'Не удалось отправить SMS:
			|%1 (код ошибки: %2)'"), ОтветСервера.descr, КодРезультата);
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Отправка SMS'", ОбщегоНазначения.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка, , , Результат.ОписаниеОшибки);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Возвращает текстовое представление статуса доставки сообщения.
//
// Параметры:
//  ИдентификаторСообщения - Строка - идентификатор, присвоенный sms при отправке;
//  НастройкиОтправкиSMS   - см. ОтправкаSMSПовтИсп.НастройкиОтправкиSMS;
//
// Возвращаемое значение:
//  Строка - статус доставки. См. описание функции ОтправкаSMS.СтатусДоставки.
Функция СтатусДоставки(Знач ИдентификаторСообщения, НастройкиОтправкиSMS) Экспорт
	
	ЧастиИдентификатора = СтрРазделить(ИдентификаторСообщения, "/", Истина);
	НомерПолучателя = ЧастиИдентификатора[0];
	ИдентификаторСообщения = ЧастиИдентификатора[1];
	
	Логин = НастройкиОтправкиSMS.Логин;
	Пароль = НастройкиОтправкиSMS.Пароль;
	
	СтатусыДоставки = Новый Соответствие;
	
	// Подготовка параметров запроса.
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("login", Логин);
	ПараметрыЗапроса.Вставить("password", Пароль);
	ПараметрыЗапроса.Вставить("smsid", ИдентификаторСообщения);
	
	// отправка запроса
	ТекстОтвета = ВыполнитьЗапрос("report.php", ПараметрыЗапроса);
	Если Не ЗначениеЗаполнено(ТекстОтвета) Тогда
		Возврат "Ошибка";
	КонецЕсли;
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(ТекстОтвета);
	ОтветСервера = ШаблонОтветаСервера();
	ЗаполнитьЗначенияСвойств(ОтветСервера, ФабрикаXDTO.ПрочитатьXML(ЧтениеXML));
	ЧтениеXML.Закрыть();

	КодРезультата = ОтветСервера.code;
	Если КодРезультата = "1" Тогда
		Для Каждого Статус Из ОтветСервера.detail.Свойства() Цикл
			Получатели = ОтветСервера.detail[Статус.Имя].Последовательность();
			Для Индекс = 0 По Получатели.Количество()-1 Цикл
				Получатель = Получатели.ПолучитьЗначение(Индекс);
				СтатусыДоставки.Вставить(Получатель, СтатусДоставкиSMS(Статус.Имя));
			КонецЦикла;
		КонецЦикла;
	Иначе
		ОписаниеОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр(
			"ru = 'Не удалось получить статус доставки SMS (smsid: ""%3""):
			|%1 (код ошибки: %2)'"), ОтветСервера.descr, КодРезультата, ИдентификаторСообщения);
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Отправка SMS'", ОбщегоНазначения.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка, , , ОписаниеОшибки);
		Возврат "Ошибка";
	КонецЕсли;
	
	Результат = СтатусыДоставки[НомерПолучателя];
	Если Результат = Неопределено Тогда
		Результат = "НеОтправлялось";
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Конструктор параметров ответа сервера.
// 
// Возвращаемое значение:
//  Структура - Описание:
//   * code - Число -
//   * descr - Строка - 
//   * detail - ОбъектXDTO - 
// 
Функция ШаблонОтветаСервера()
	
	Возврат Новый Структура("code,descr,detail");
	
КонецФункции

Функция СтатусДоставкиSMS(КодСостояния)
	СоответствиеСтатусов = Новый Соответствие;
	СоответствиеСтатусов.Вставить("enqueued", "Отправляется");
	СоответствиеСтатусов.Вставить("onModer", "Отправляется");
	СоответствиеСтатусов.Вставить("process", "Отправляется");
	СоответствиеСтатусов.Вставить("waiting", "Отправлено");
	СоответствиеСтатусов.Вставить("delivered", "Доставлено");
	СоответствиеСтатусов.Вставить("notDelivered", "НеДоставлено");
	СоответствиеСтатусов.Вставить("cancel", "НеОтправлено");
	
	Результат = СоответствиеСтатусов[КодСостояния];
	Возврат ?(Результат = Неопределено, "НеОтправлялось", Результат);
КонецФункции

Функция ВыполнитьЗапрос(ИмяМетода, ПараметрыЗапроса)
	
	HTTPЗапрос = ОтправкаSMS.ПодготовитьHTTPЗапрос("/API/XML/" + ИмяМетода, СформироватьТелоHTTPЗапроса(ПараметрыЗапроса));
	HTTPОтвет = Неопределено;
	
	Попытка
		Соединение = Новый HTTPСоединение("lcab.sms-uslugi.ru",,,, 
			ПолучениеФайловИзИнтернета.ПолучитьПрокси("http"), 
			60);
		HTTPОтвет = Соединение.ОтправитьДляОбработки(HTTPЗапрос);
	Исключение
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Отправка SMS'", ОбщегоНазначения.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	Если HTTPОтвет <> Неопределено Тогда
		Если HTTPОтвет.КодСостояния <> 200 Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Запрос ""%1"" не выполнен. Код состояния: %2.'"), ИмяМетода, HTTPОтвет.КодСостояния) + Символы.ПС
				+ HTTPОтвет.ПолучитьТелоКакСтроку();
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Отправка SMS'", ОбщегоНазначения.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка, , , ТекстОшибки);
		КонецЕсли;
		
		Возврат HTTPОтвет.ПолучитьТелоКакСтроку();
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция СформироватьТелоHTTPЗапроса(ПараметрыЗапроса)
	
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.УстановитьСтроку();
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	ЗаписьXML.ЗаписатьНачалоЭлемента("data");
	Для Каждого Параметр Из ПараметрыЗапроса Цикл
		Если Параметр.Ключ = "to" Тогда
			Для Каждого Номер Из Параметр.Значение Цикл
				ЗаписьXML.ЗаписатьНачалоЭлемента(Параметр.Ключ);
				ЗаписьXML.ЗаписатьАтрибут("number", Номер);
				ЗаписьXML.ЗаписатьКонецЭлемента();
			КонецЦикла;
		Иначе
			ЗаписьXML.ЗаписатьНачалоЭлемента(Параметр.Ключ);
			ЗаписьXML.ЗаписатьТекст(Параметр.Значение);
			ЗаписьXML.ЗаписатьКонецЭлемента();
		КонецЕсли;
	КонецЦикла;
	ЗаписьXML.ЗаписатьКонецЭлемента();
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции

Функция ФорматироватьНомерДляОтправки(Номер)
	Результат = "";
	ДопустимыеСимволы = "1234567890";
	Для Позиция = 1 По СтрДлина(Номер) Цикл
		Символ = Сред(Номер,Позиция,1);
		Если СтрНайти(ДопустимыеСимволы, Символ) > 0 Тогда
			Результат = Результат + Символ;
		КонецЕсли;
	КонецЦикла;
	Возврат Результат;
КонецФункции

Функция ФорматироватьНомерИзРезультатаОтправки(Номер)
	Результат = Номер;
	
	Если СтрДлина(Результат) > 10 Тогда
		ПервыйСимвол = Лев(Результат, 1);
		Если ПервыйСимвол = "8" Тогда
			Результат = "+7" + Сред(Результат, 2);
		ИначеЕсли ПервыйСимвол <> "+" Тогда
			Результат = "+" + Результат;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

// Возвращает список разрешений для отправки SMS с использованием всех доступных провайдеров.
//
// Возвращаемое значение:
//  Массив - .
//
Функция Разрешения() Экспорт
	
	Протокол = "HTTP";
	Адрес = "lcab.sms-uslugi.ru";
	Порт = Неопределено;
	Описание = НСтр("ru = 'Отправка SMS через ""СМС-Услуги"".'");
	
	МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
	
	Разрешения = Новый Массив;
	Разрешения.Добавить(
		МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(Протокол, Адрес, Порт, Описание));
	
	Возврат Разрешения;
КонецФункции

Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
	Настройки.АдресОписанияУслугиВИнтернете = "http://sms-uslugi.ru";
	
КонецПроцедуры


#КонецОбласти

