﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СписокКлиентов = "";
	ТЗ = Клиенты.Выгрузить();
	ТЗ.Сортировать("Клиент");
	Для Каждого Строки Из ТЗ Цикл
		Если НЕ ПустаяСтрока(СписокКлиентов) Тогда
			СписокКлиентов = СписокКлиентов + ", ";
		КонецЕсли;
		СписокКлиентов = СписокКлиентов + Строка(Строки.Клиент);
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Ошибки = Неопределено;
	
	Если Клиенты.Количество() = 0 Тогда
		ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "Объект.Клиенты", 
			НСтр("ru = 'Не заполнена табличная часть ""Клиенты""'"), "Клиенты");
	КонецЕсли;
		
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
	
КонецПроцедуры

// Процедура - обработчик события ОбработкаПроведения объекта.
//
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	// Инициализация дополнительных свойств для проведения документа.
	УправлениеITОтделом8УФ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	
	// Инициализация данных документа.
	СЛС.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);	
	
	// Подготовка наборов записей.
	УправлениеITОтделом8УФ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	// Отражение в разделах учета.
	СЛС.ОтразитьДвиженияВРазделахУчета(Ссылка, ДополнительныеСвойства, Движения, Отказ);		
	
	// Запись наборов записей.
	УправлениеITОтделом8УФ.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы.МенеджерВременныхТаблиц.Закрыть();
	
КонецПроцедуры

// Процедура - обработчик события ОбработкаУдаленияПроведения объекта.
//
Процедура ОбработкаУдаленияПроведения(Отказ)
	
	// Инициализация дополнительных свойств для удаления проведения документа.
	УправлениеITОтделом8УФ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	
	// Подготовка наборов записей.
	УправлениеITОтделом8УФ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	// Запись наборов записей.
	УправлениеITОтделом8УФ.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
