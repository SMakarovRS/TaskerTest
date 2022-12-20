﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;	
	
КонецПроцедуры

// Процедура - обработчик события ОбработкаПроверкиЗаполнения объекта.
//
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ОбменДанными.Загрузка Тогда	
		Возврат;		
	КонецЕсли;
	
	// Проверка на ошибки.
	СписокОшибок = ПроверитьДокументПередПроведением();
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(СписокОшибок, Отказ);
	
КонецПроцедуры // ОбработкаПроверкиЗаполнения()

// Процедура - обработчик события ОбработкаПроведения объекта.
//
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	// Проверка на ошибки.
	// Из-за использования дерева приходится несколько раз делать проверку.
	Если НЕ ОбменДанными.Загрузка Тогда
		СписокОшибок = ПроверитьДокументПередПроведением();
		ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(СписокОшибок, Отказ);	
	КонецЕсли;	
	
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

	// Контроль.
	СЛС.ВыполнитьКонтрольОтрицательныхОстатков(Ссылка, ДополнительныеСвойства, Отказ);	
	
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
	
	// Контроль.
	СЛС.ВыполнитьКонтрольОтрицательныхОстатков(Ссылка, ДополнительныеСвойства, Отказ, Истина);

КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ДанныеЗаполнения <> Неопределено Тогда
		Основание = ДанныеЗаполнения;
	КонецЕсли;
		
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.Поступление") Тогда
		// На основании документа "Поступление".
		Организация		= ДанныеЗаполнения.Организация;
		МестоХранения	= ДанныеЗаполнения.МестоХранения;
		
		Для каждого Строки Из ДанныеЗаполнения.Номенклатура Цикл
			ЗаполнитьЗначенияСвойств(Номенклатура.Добавить(), Строки);
		КонецЦикла;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.Задание") Тогда
		Организация			= ДанныеЗаполнения.Организация;
		МестоХранения		= ДанныеЗаполнения.МестоХранения;
		Комментарий			= ДанныеЗаполнения.Тема;
	КонецЕсли
	
КонецПроцедуры

#КонецОбласти	

#Область СлужебныеПроцедурыИФункции

// Проверяет документ перед проведением, возвращает СписокЗначений с ошибками,
// если пустой, то ошибок нет.
Функция ПроверитьДокументПередПроведением()
	
	СписокОшибок = Неопределено;
			
	// Проверка не заполненных столбцов.
	Для каждого Строки Из Номенклатура Цикл
		
		// Пустая номенклатура.
		Если НЕ ЗначениеЗаполнено(Строки.Номенклатура) Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", НСтр("ru = 'Есть строки с незаполненной номенклатурой.'"), "");
			Продолжить;			
		КонецЕсли;
		
		// Проверка пустой карточки номенклатуры.
		Если НЕ ЗначениеЗаполнено(Строки.КарточкаНоменклатуры) Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'Для номенклатуры %1 не заполнены карточки номенклатуры.'"), Строки.Номенклатура), "");
		КонецЕсли;
		
		// Пустое количество.
		Если Строки.Количество = 0 Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'Для номенклатуры %1 не заполнено количество.'"), Строки.Номенклатура), "");
		КонецЕсли;

		// Проверка, что в Номенклатуре нет услуг.
		Если ЗначениеЗаполнено(Строки.Номенклатура) Тогда
			Если ЗначениеЗаполнено(Строки.Номенклатура.ВидНоменклатуры) Тогда
				Если Строки.Номенклатура.ВидНоменклатуры.ТипВидаНоменклатуры = Перечисления.ТипыВидовНоменклатуры.Услуга Тогда
					ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'Номенклатура %1 не может быть выбрана в дереве, т.к. это услуга.'"), Строки.Номенклатура), "");
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Если СписокОшибок <> Неопределено Тогда
		Возврат СписокОшибок;
	КонецЕсли;
	
	// Проверка, что нет комплектов в документе.
	Запрос = Новый Запрос();
	Запрос.Текст =
		"ВЫБРАТЬ
		|	КомплектацияОстатки.Комплект
		|ИЗ
		|	РегистрНакопления.Комплектация.Остатки(&Период, Комплект В (&СписокКомплектов)) КАК КомплектацияОстатки";
		
	Если Ссылка.Пустая() Тогда
		Запрос.УстановитьПараметр("Период", ТекущаяДатаСеанса());
	Иначе		
		Запрос.УстановитьПараметр("Период", Ссылка.МоментВремени());
	КонецЕсли;	
	Запрос.УстановитьПараметр("СписокКомплектов", Номенклатура.ВыгрузитьКолонку("КарточкаНоменклатуры"));
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'Номенклатура %1 не может быть собрана в комплектацию, т.к. она сама является комплектом.'"), Выборка.Комплект), "");
	КонецЦикла;
	
	// Проверка дублей строк.
	ТЗНоменклатура = Номенклатура.Выгрузить();
	ТЗНоменклатура.Колонки.Добавить("КоличествоОдинаковых");
	Для каждого Строки Из ТЗНоменклатура Цикл
		Строки.КоличествоОдинаковых = 1;
	КонецЦикла;
	ТЗНоменклатура.Свернуть("Номенклатура,КарточкаНоменклатуры", "КоличествоОдинаковых");
	
	Для каждого Строки Из ТЗНоменклатура Цикл
		Если Строки.КоличествоОдинаковых > 1 Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'Для номенклатуры %1 есть дублирующиеся строки.'"), Строки.Номенклатура), "");
		КонецЕсли;		
	КонецЦикла;
	
	// Проверки номенклатуры.
	Для каждого Строки Из Номенклатура Цикл
		
		// Учет по карточкам и количество <> 1.
		Если Строки.Номенклатура.ВидНоменклатуры.ВестиУчетПоКарточкамНоменклатуры И Строки.Количество <> 1 Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'Для номенклатуры %1 в ее виде указано, что ведется учет по карточкам. Для такой номенклатуры количество в строке не может быть больше единицы.'"), Строки.Номенклатура), "");
		КонецЕсли;
		
		// Проверка, что карточка соответствует номенклатуре.
		Если Строки.Номенклатура <> Строки.КарточкаНоменклатуры.Владелец Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'Для номенклатуры ""%1"" выбрана карточка, которая не является дочерней карточкой этой номенклатуры.'"), Строки.Номенклатура), "");
		КонецЕсли;
		
		// Карточка не заполнена.
		Если НЕ ЗначениеЗаполнено(Строки.КарточкаНоменклатуры) Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(СписокОшибок, "Объект.Номенклатура", СтрШаблон(НСтр("ru = 'В строке %1 не выбрана карточка номенклатуры.'"), Строки.НомерСтроки), "");
		КонецЕсли;
		
	КонецЦикла;	
	
	Возврат СписокОшибок;
	
КонецФункции

#КонецОбласти

#КонецЕсли