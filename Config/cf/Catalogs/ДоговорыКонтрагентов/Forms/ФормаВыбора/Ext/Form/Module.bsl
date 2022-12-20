﻿
#Область ОбработчикиСобытийФормы

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
// Процедура - обработчик события ПриСозданииНаСервере.
//
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Список.Параметры.УстановитьЗначениеПараметра("ДатаАктуальности", НачалоДня(ТекущаяДатаСеанса()));	
	
	Организация = Справочники.Организации.ПустаяСсылка();
	Если Параметры.Свойство("Организация") Тогда
		Организация = Параметры.Организация; 
	Иначе
 		Если Параметры.Свойство("Отбор") Тогда
 			Если Параметры.Отбор.Свойство("Организация") Тогда
				Организация = Параметры.Отбор.Организация;  				
 			КонецЕсли;
 		КонецЕсли;					
	КонецЕсли;

	Контрагент = Справочники.Контрагенты.ПустаяСсылка();	
	Если Параметры.Свойство("Контрагент") Тогда
		Контрагент = Параметры.Контрагент;
	Иначе
 		Если Параметры.Свойство("Отбор") Тогда
 			Если Параметры.Отбор.Свойство("Контрагент") Тогда
				Контрагент = Параметры.Отбор.Контрагент;  				
 			КонецЕсли;
// 			Если Параметры.Отбор.Свойство("Владелец") Тогда
//				Контрагент = Параметры.Отбор.Владелец;  				
// 			КонецЕсли; 			
 		КонецЕсли;
	КонецЕсли;

	КонтролироватьВыборДоговора = Ложь;
	Если Параметры.Свойство("КонтролироватьВыборДоговора") Тогда
		КонтролироватьВыборДоговора = Параметры.КонтролироватьВыборДоговора;
		КонтролироватьСоответствиеДокументу = КонтролироватьВыборДоговора; 
	Иначе
 		КонтролироватьВыборДоговора = ЗначениеЗаполнено(Организация) ИЛИ ЗначениеЗаполнено(Контрагент);
 		КонтролироватьСоответствиеДокументу = ЗначениеЗаполнено(Организация) И ЗначениеЗаполнено(Контрагент);
	КонецЕсли;	
	
	Параметры.Свойство("ВидыДоговоров", ВидыДоговоров);	
	
	УстановитьОтборИУсловноеОформление();
	
КонецПроцедуры // ПриСозданииНаСервере()

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОтборСтатусПриИзменении(Элемент)
	
	РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Список, "Статус", ОтборСтатус, 
		ЗначениеЗаполнено(ОтборСтатус));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ РЕКВИЗИТОВ ФОРМЫ

// Процедура - обработчик события ВыборЗначения таблицы Список.
//
&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	ТекстВопроса = "";
	Если Не ПроверитьСоответствиеДоговораУсловиямДокумента(КонтролироватьСоответствиеДокументу, ТекстВопроса, Значение,
		Организация, Контрагент, ВидыДоговоров) Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ПараметрыВопроса = Новый Структура;
		ПараметрыВопроса.Вставить("Значение", Значение);
		
		ОписаниеОповещения = Новый ОписаниеОповещения("СписокВыборЗначенияЗавершение", ЭтотОбъект, ПараметрыВопроса);
		ТекстВопроса = ТекстВопроса + НСтр("ru = '
                                            |
                                            |Выбрать другой договор?'");
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыборЗначенияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
		ОповеститьОВыборе(ДополнительныеПараметры.Значение);
	КонецЕсли;
	
КонецПроцедуры

// Процедура - обработчик события ПередНачаломДобавления таблицы Список.
//
&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если КонтролироватьВыборДоговора
		И ЗначениеЗаполнено(Контрагент)
		И ЗначениеЗаполнено(Организация)
		И ВидыДоговоров.Количество() > 0 Тогда
		
		Отказ = Истина;
		
		ДанныеЗаполненияДоговора = Новый Структура;
		ДанныеЗаполненияДоговора.Вставить("Владелец", Контрагент);
		ДанныеЗаполненияДоговора.Вставить("Организация", Организация);
		ДанныеЗаполненияДоговора.Вставить("ВидДоговора", ВидыДоговоров[0].Значение);
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ЗначенияЗаполнения", ДанныеЗаполненияДоговора);
		
		ОткрытьФорму("Справочник.ДоговорыКонтрагентов.ФормаОбъекта", ПараметрыФормы, Элемент);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ

// Устанавливает отбор и условное оформление списка, если у контрагента установлен признак ведения расчетов по договорам.
//
&НаСервере
Процедура УстановитьОтборИУсловноеОформление()
	
	СписокУдаляемыхЭлементов = Новый СписокЗначений;
	Для Каждого ЭлементУсловногоОформления Из Список.КомпоновщикНастроек.Настройки.УсловноеОформление.Элементы Цикл
		Если ЭлементУсловногоОформления.ИдентификаторПользовательскойНастройки = "Предустановленный"
			И ЭлементУсловногоОформления.Представление = НСтр("ru = 'Не соответствуют условиям документа'") Тогда
			СписокУдаляемыхЭлементов.Добавить(ЭлементУсловногоОформления);
		КонецЕсли;
	КонецЦикла;
	Для Каждого Элемент Из СписокУдаляемыхЭлементов Цикл
		Список.КомпоновщикНастроек.Настройки.УсловноеОформление.Элементы.Удалить(Элемент.Значение);
	КонецЦикла;
	
	Если Не КонтролироватьВыборДоговора Тогда
		Возврат;
	КонецЕсли;
	
	РаботаСОтборамиКлиентСервер.УдалитьЭлементОтбораСписка(Список, "Владелец");
	РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Список, "Владелец", Контрагент);
	
	Если Не КонтролироватьСоответствиеДокументу Тогда
		Возврат;
	КонецЕсли;
	
	ЭлементУсловногоОформления = Список.КомпоновщикНастроек.Настройки.УсловноеОформление.Элементы.Добавить();
	
	ГруппаИЛИ = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаИЛИ.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли;
	ГруппаИЛИ.Использование = Истина;
	
	ЭлементОтбора = ГруппаИЛИ.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Организация");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ЭлементОтбора.ПравоеЗначение = Организация;
	
	Если ЗначениеЗаполнено(ВидыДоговоров) ИЛИ ВидыДоговоров.Количество() > 0 Тогда	
		ЭлементОтбора = ГруппаИЛИ.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидДоговора");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСписке;
		ЭлементОтбора.ПравоеЗначение = ВидыДоговоров;
	КонецЕсли;
	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.ТемноСерый);
	ЭлементУсловногоОформления.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементУсловногоОформления.ИдентификаторПользовательскойНастройки = "Предустановленный";
	ЭлементУсловногоОформления.Представление = НСтр("ru = 'Не соответствуют условиям документа'");
	
	// Основной договор.	
	Если ЗначениеЗаполнено(Контрагент) И ЗначениеЗаполнено(Контрагент.ДоговорПоУмолчанию) Тогда		
		
		ЭлементыУсловногоОформленияСписка	= Список.УсловноеОформление.Элементы;
		ЭлементУсловногоОформления			= ЭлементыУсловногоОформленияСписка.Добавить();		
		ЭлементОтбора 						= ЭлементУсловногоОформления.Отбор.Элементы.Добавить(
			Тип("ЭлементОтбораКомпоновкиДанных"));		
		ЭлементОтбора.ЛевоеЗначение 		= Новый ПолеКомпоновкиДанных("Ссылка");
		ЭлементОтбора.ВидСравнения 			= ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.ПравоеЗначение 		= Контрагент.ДоговорПоУмолчанию;
		
		ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(,,Истина,));		
		ЭлементУсловногоОформления.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
		
	КонецЕсли;	
	
КонецПроцедуры

// Проверяет соответствие реквизитов договора "Организация" и "ВидДоговора" переданным параметрам.
//
&НаСервереБезКонтекста
Функция ПроверитьСоответствиеДоговораУсловиямДокумента(КонтролироватьСоответствиеДокументу, ТекстСообщения, Договор, 
	Организация, Контрагент, СписокВидовДоговора)
	
	Если Не КонтролироватьСоответствиеДокументу Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат Справочники.ДоговорыКонтрагентов.ДоговорСоответствуетУсловиямДокумента(ТекстСообщения, Договор, 
		Организация, Контрагент, СписокВидовДоговора);
	
КонецФункции

#КонецОбласти