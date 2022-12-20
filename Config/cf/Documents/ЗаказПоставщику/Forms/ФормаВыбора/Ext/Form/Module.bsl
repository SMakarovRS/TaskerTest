﻿#Область ОбработчикиСобытийФормы

// Процедура - обработчик события формы "ПриСозданииНаСервере".
//
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ОтборКонтрагент") Тогда
		
		Если ЗначениеЗаполнено(Параметры.ОтборКонтрагент) Тогда
			РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Список, 
				"Контрагент", Параметры.ОтборКонтрагент);
				
		КонецЕсли;
			
	КонецЕсли;
	
	Если Параметры.Свойство("ОтборДоговор") Тогда
		
		Если ЗначениеЗаполнено(Параметры.ОтборДоговор) Тогда
			РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Список, 
				"Договор", Параметры.ОтборДоговор);
		КонецЕсли;
		
	КонецЕсли;
	
	Если Параметры.Свойство("ЗакрыватьПриВыборе") Тогда
		ЗакрыватьПриВыборе = Истина;
	КонецЕсли;
	
	РаскраситьСписок();
	
КонецПроцедуры // ПриСозданииНаСервере()

// Процедура - обработчик события ОбработкаОповещения формы.
//
&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_СостоянияЗаказовПоставщикам" Тогда
		РаскраситьСписок();
	КонецЕсли;
	
КонецПроцедуры // ОбработкаОповещения()

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура раскрашивает список.
//
&НаСервере
Процедура РаскраситьСписок()
	
	// Раскраска списка
	СписокУдаляемыхЭлементов = Новый СписокЗначений;	
	Для каждого ЭлементУсловногоОформления Из Список.УсловноеОформление.Элементы Цикл
		Если ЭлементУсловногоОформления.ИдентификаторПользовательскойНастройки = "Предустановленный"
			ИЛИ ЭлементУсловногоОформления.Представление = НСтр("ru = 'Заказ закрыт'") Тогда
			СписокУдаляемыхЭлементов.Добавить(ЭлементУсловногоОформления);
		КонецЕсли;
	КонецЦикла;
	Для каждого Элемент Из СписокУдаляемыхЭлементов Цикл
		Список.УсловноеОформление.Элементы.Удалить(Элемент.Значение);
	КонецЦикла;
		
	ВыборкаСостоянияЗаказов = Справочники.СостоянияЗаказовПоставщикам.Выбрать();
	Пока ВыборкаСостоянияЗаказов.Следующий() Цикл
		
		ЦветФона = ВыборкаСостоянияЗаказов.Цвет.Получить();
		Если ТипЗнч(ЦветФона) <> Тип("Цвет") Тогда
			Продолжить;
		КонецЕсли;
		
		ЭлементУсловногоОформления = Список.УсловноеОформление.Элементы.Добавить();
		
		ЭлементОтбора 				= ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));		
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("СостояниеЗаказа");
		ЭлементОтбора.ВидСравнения 	= ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.ПравоеЗначение= ВыборкаСостоянияЗаказов.Ссылка;
		
		ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветФона);
		ЭлементУсловногоОформления.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
		ЭлементУсловногоОформления.ИдентификаторПользовательскойНастройки = "Предустановленный";		
		ЭлементУсловногоОформления.Представление = НСтр("ru = 'По состоянию заказа'") + " " + ВыборкаСостоянияЗаказов.Наименование;
		
	КонецЦикла;
		
	ЭлементУсловногоОформления 	= Список.УсловноеОформление.Элементы.Добавить();	
	ЭлементОтбора 				= ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Закрыт");
	ЭлементОтбора.ВидСравнения  = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение= Истина;
	
	ШрифтТекстаСтроки = Новый Шрифт(,,,,,Истина);
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Шрифт", ШрифтТекстаСтроки);
	ЭлементУсловногоОформления.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементУсловногоОформления.ИдентификаторПользовательскойНастройки = "Предустановленный";
	ЭлементУсловногоОформления.Представление = НСтр("ru = 'Заказ закрыт'");
			
КонецПроцедуры // РаскраситьСписок()

#КонецОбласти