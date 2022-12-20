﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	КэшЗначений = Новый Структура;
	КэшЗначений.Вставить("ЭтоНовыйЭлемент",							НЕ ЗначениеЗаполнено(Объект.Ссылка));
	КэшЗначений.Вставить("ДоступныОсобыеПравилаПодписи",			Неопределено);
	КэшЗначений.Вставить("Тройка",									0);
	КэшЗначений.Вставить("МаксимальнаяТройка",						0);
	КэшЗначений.Вставить("РамкаДвойная",							Новый Рамка(ТипРамкиЭлементаУправления.Двойная));
	КэшЗначений.Вставить("РамкаОдинарная",							Новый Рамка(ТипРамкиЭлементаУправления.Одинарная));
	КэшЗначений.Вставить("ЦветаСтиляВыделенногоЦвета",				ЦветаСтиля.ВидДняПроизводственногоКалендаряСубботаЦвет);
	КэшЗначений.Вставить("ЕстьПравоИзменятьПодпись",				ПравоДоступа("Изменение", Метаданные.Справочники.Подписи));
		
	УправлениеВидимостьюДоступностью();
	
КонецПроцедуры

&НаКлиенте
Процедура РасшифровкаПодписиПриИзменении(Элемент)
	
	ИзменитьВидПоляПредставленияФизическогоЛица();
	ОбновитьНаименование();
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Не ЗначениеЗаполнено(Объект.ФизическоеЛицо) Тогда
		ТекстОшибки = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
		"Поле",
		"Заполнение",
		"ФизическоеЛицо");
		ОбщегоНазначения.СообщитьПользователю(
		ТекстОшибки,
		,
		"Объект.ФизическоеЛицо",
		,
		Отказ);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.Должность) Тогда
		ТекстОшибки = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
		"Поле",
		"Заполнение",
		"Должность");
		ОбщегоНазначения.СообщитьПользователю(
		ТекстОшибки,
		,
		"Объект.Должность",
		,
		Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РедактироватьПредставление(Команда)
	
	ИзменитьВидПоляПредставленияФизическогоЛица();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтозватьПравоПодписи(Команда)
	
	ЕстьПравоИзменитьПодпись();
	
	Объект.ПравоОтозвано = Истина;
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ДекорацияПравоОтозвано", "Видимость", Истина);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ДекорацияПодписьУжеИспользуется", "Видимость", Ложь);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ФормаОтозватьПравоПодписи", "Доступность", Ложь);
	
	Записать();
	
	Этаформа.ТолькоПросмотр = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияПодписьУжеИспользуетсяРасширеннаяПодсказкаОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ЭтаФорма.ТолькоПросмотр = Ложь;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ДекорацияПодписьУжеИспользуется", "Видимость", Ложь);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ФормаЗаписатьИЗакрыть", "Доступность", Истина);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаПериод", "Доступность", Истина);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаОграничениеИспользования", "Доступность", Истина);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаПодписант", "Доступность", Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ДолжностьПриИзменении(Элемент)
	
	ОбновитьНаименование();

КонецПроцедуры

&НаКлиенте
Процедура ФизическоеЛицоПриИзменении(Элемент)
	
	ЗаполнитьРасшифровкуПодписиНаСервере();
	ОбновитьНаименование();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЕстьПравоИзменитьПодпись()
	
	Если НЕ КэшЗначений.ЕстьПравоИзменятьПодпись Тогда
		
		ВызватьИсключение НСтр("ru ='Недостаточно прав, обратитесь к администратору.'");
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьВидПоляПредставленияФизическогоЛица()
	
	ВидПоля = ?(Элементы.РасшифровкаПодписи.Вид = ВидПоляФормы.ПолеНадписи, ВидПоляФормы.ПолеВвода, ВидПоляФормы.ПолеНадписи);
	ШиринаПоля = ?(ВидПоля = ВидПоляФормы.ПолеВвода, 36, 37);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "РасшифровкаПодписи", "Вид", ВидПоля);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "РасшифровкаПодписи", "АвтоМаксимальнаяШирина", Ложь);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "РасшифровкаПодписи", "МаксимальнаяШирина", ШиринаПоля);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "РасшифровкаПодписи", "ЦветТекста", КэшЗначений.ЦветаСтиляВыделенногоЦвета);
	
КонецПроцедуры

&НаСервере
Процедура УправлениеВидимостьюДоступностью()
	
	РедактированиеДоступно = Истина;
	Если Объект.ПравоОтозвано Тогда
		
		РедактированиеДоступно = Ложь;
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ДекорацияПравоОтозвано", "Видимость", Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ФормаОтозватьПравоПодписи", "Доступность", Ложь);
		ЭтаФорма.ТолькоПросмотр = Истина;
		
	ИначеЕсли ПодписьУжеИспользуется() Тогда
		
		РедактированиеДоступно = Ложь;
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ДекорацияПодписьУжеИспользуется", "Видимость", Истина);
		
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ФормаЗаписатьИЗакрыть", "Доступность", РедактированиеДоступно);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаПериод", "Доступность", РедактированиеДоступно);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаОграничениеИспользования", "Доступность", РедактированиеДоступно);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаПодписант", "Доступность", РедактированиеДоступно);
	
КонецПроцедуры

&НаСервере
Функция ПодписьУжеИспользуется()
	
	Возврат (Справочники.Подписи.ПодписьИспользуетсяВДокументах(Объект.Ссылка) = Истина);
	
КонецФункции

&НаКлиенте
Процедура ОбновитьНаименование()
	
	Объект.Наименование = Строка(Объект.Должность) + ", " + Объект.РасшифровкаПодписи;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьРасшифровкуПодписиНаСервере()
	
	Перем РасшифровкаПодписи;
	
	Если ЗначениеЗаполнено(Объект.ФизическоеЛицо) Тогда
		
		Период = ?(ЗначениеЗаполнено(Объект.ДатаНазначения), Объект.ДатаНазначения, ТекущаяДатаСеанса());
		
		РасшифровкаПодписи = РегистрыСведений.ФИОФизЛиц.ФИОФизЛица(Период, Объект.ФизическоеЛицо);
		Если НЕ ЗначениеЗаполнено(РасшифровкаПодписи) Тогда
			
			РасшифровкаПодписи = СокрЛП(ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.ФизическоеЛицо, "Наименование"));
			
		КонецЕсли;
		
	КонецЕсли;
		
	Объект.РасшифровкаПодписи = РасшифровкаПодписи;
	
КонецПроцедуры

#КонецОбласти