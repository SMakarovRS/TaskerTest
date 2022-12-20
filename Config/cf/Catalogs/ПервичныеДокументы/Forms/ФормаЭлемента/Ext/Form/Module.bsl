﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	Если Объект.Ссылка.Пустая() Тогда
		
		Объект.Ответственный= ТекущийПользователь;
		
		// Организация.
		Если Объект.Организация = Неопределено Тогда
			ЗначениеНастройки	= УправлениеITОтделом8УФПовтИсп.ПолучитьЗначениеПоУмолчаниюПользователя(
				ТекущийПользователь, "ОсновнаяОрганизация");
		Иначе
			ЗначениеНастройки = Объект.Организация; 
		КонецЕсли;
					
		Если ЗначениеЗаполнено(ЗначениеНастройки) Тогда
			Если Объект.Организация <> ЗначениеНастройки Тогда
				Объект.Организация = ЗначениеНастройки;
			КонецЕсли;
		Иначе
			Объект.Организация = УправлениеITОтделом8УФПовтИсп.ПолучитьОсновнуюОрганизацию();
		КонецЕсли;
		
		// Ставка НДС.
		ЗначениеНастройки	= УправлениеITОтделом8УФПовтИсп.ПолучитьЗначениеПоУмолчаниюПользователя(
			ТекущийПользователь, "ОсновнаяСтавкаНДС");
			
		Если ЗначениеЗаполнено(ЗначениеНастройки) Тогда
			Если Объект.СтавкаНДС <> ЗначениеНастройки Тогда
				Объект.СтавкаНДС = ЗначениеНастройки;
			КонецЕсли;
		КонецЕсли;	

	КонецЕсли;	
		
	РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Документы, 
		"ПервичныйДокумент", Объект.Ссылка);

	ОбновитьКоличествоСвязанныхОбъектов();
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "СтраницаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.УправлениеДоступом
    УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ПервичныеДокументы_ДобавленаСвязьДокумента" Тогда
		ОбновитьКоличествоСвязанныхОбъектов();
		// Элементы.Документы.Обновить();
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Документы, 
		"ПервичныйДокумент", Объект.Ссылка);
	
	Оповестить("ПервичныеДокументы_Запись");
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПереданВОплатуПриИзменении(Элемент)
	
	Если Объект.ПереданВОплату Тогда
		Объект.ДатаПередачиВОплату = ТекущаяДатаСеансаНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОплаченПриИзменении(Элемент)
	
	Если Объект.Оплачен Тогда
		Объект.ДатаОплаты = ТекущаяДатаСеансаНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПереданВАрхивПриИзменении(Элемент)
	
	Если Объект.ПереданВАрхив Тогда
		Объект.ДатаПередачиВАрхив = ТекущаяДатаСеансаНаСервере();
		Объект.Статус = ПредопределенноеЗначение("Перечисление.СтатусыПервичныхДокументов.Архив");			
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДоговорНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("КонтролироватьВыборДоговора", Истина);
	ПараметрыФормы.Вставить("Контрагент", 				   Объект.Контрагент);
	ПараметрыФормы.Вставить("Организация", 				   Объект.Организация);
	СтандартнаяОбработка = Ложь;
	ОткрытьФорму("Справочник.ДоговорыКонтрагентов.Форма.ФормаВыбора", ПараметрыФормы, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СуммаПриИзменении(Элемент)
	
	Если Объект.Сумма > 0 Тогда
		СтавкаНДС 			= УправлениеITОтделом8УФПовтИсп.ПолучитьЗначениеСтавкиНДС(Объект.СтавкаНДС);
		Объект.СуммаНДС		= Объект.Сумма - (Объект.Сумма) / ((СтавкаНДС + 100) / 100);
		Объект.СуммаБезНДС	= Объект.Сумма - Объект.СуммаНДС;
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура СтавкаНДСПриИзменении(Элемент)
	
	Если Объект.Сумма > 0 Тогда
		СтавкаНДС 			= УправлениеITОтделом8УФПовтИсп.ПолучитьЗначениеСтавкиНДС(Объект.СтавкаНДС);
		Объект.СуммаНДС		= Объект.Сумма - (Объект.Сумма) / ((СтавкаНДС + 100) / 100);
		Объект.СуммаБезНДС	= Объект.Сумма - Объект.СуммаНДС;
	КонецЕсли;	

КонецПроцедуры

&НаКлиенте
Процедура ДокументыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущиеДанные 		 = Элементы.Документы.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ТекущиеДанные.Свойство("ГруппировкаСтроки") Тогда	
		ПоказатьЗначение(, ТекущиеДанные.Объект);
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура СтатусПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(Объект.Статус) Тогда
		Если Объект.Статус = ПредопределенноеЗначение("Перечисление.СтатусыПервичныхДокументов.Архив")
			И Объект.ПереданВАрхив = Ложь Тогда
			Объект.ПереданВАрхив = Истина;
			Объект.ДатаПередачиВАрхив = ТекущаяДатаСеансаНаСервере();
		КонецЕсли;	
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыПослеУдаления(Элемент)
	
	ОбновитьКоличествоСвязанныхОбъектов();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства
//@skip-warning
&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
	
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, 
		НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
    УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаСервере
Функция ТекущаяДатаСеансаНаСервере()
	
	Возврат ТекущаяДатаСеанса();
	
КонецФункции

&НаКлиенте
Процедура ДокументыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Объект.Ссылка.Пустая() Тогда
		Отказ 		   	   = Истина;
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВопросаЗаписатьДокумент", ЭтотОбъект);
		ПоказатьВопрос(ОписаниеОповещения, 
			НСтр("ru = 'Данные еще не записаны. Добавить связанные объекты можно только после записи данных. Продолжить?'"),
			РежимДиалогаВопрос.ДаНет);
		Возврат;
	КонецЕсли;	
	
	Отказ = Истина;
	ДобавитьПредметВДокумент();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВопросаЗаписатьДокумент(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ЭтотОбъект.Записать();
	
	Если Не Объект.Ссылка.Пустая() Тогда
		ДобавитьПредметВДокумент(Новый Структура("ОбновитьПринудительно", Истина));
	КонецЕсли;	
	
КонецПроцедуры	

&НаКлиенте
Процедура ДобавитьПредметВДокумент(СтруктураПараметров = Неопределено)
	
	ФормаПараметры = Новый Структура;	
	ФормаПараметры.Вставить("ПервичныйДокумент", Объект.Ссылка);
	
	Если СтруктураПараметров = Неопределено Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ДобавитьПредметВДокументФрагмент", ЭтотОбъект);
	Иначе
		ОписаниеОповещения = Новый ОписаниеОповещения("ДобавитьПредметВДокументФрагмент", ЭтотОбъект, 
			СтруктураПараметров);
	КонецЕсли;	
	
	ОткрытьФорму("РегистрСведений.СвязьПервичныхДокументов.Форма.ФормаЗаписи", ФормаПараметры, ЭтотОбъект,,,, 
		ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПредметВДокументФрагмент(Результат, ДополнительныеПараметры) Экспорт
	
	Если ДополнительныеПараметры <> Неопределено 
		И ДополнительныеПараметры.Свойство("ОбновитьПринудительно") Тогда
		РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Документы, 
			"ПервичныйДокумент", Объект.Ссылка);
	КонецЕсли;	
	
	Элементы.Документы.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьКоличествоСвязанныхОбъектов()
	
	Если Объект.Ссылка.Пустая() Тогда
		КоличествоСвязанныхОбъектов = 0;
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос();
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КОЛИЧЕСТВО(СвязьПервичныхДокументов.Объект) КАК КоличествоОбъектов
		|ИЗ
		|	РегистрСведений.СвязьПервичныхДокументов КАК СвязьПервичныхДокументов
		|ГДЕ
		|	СвязьПервичныхДокументов.ПервичныйДокумент = &ПервичныйДокумент";
	Запрос.УстановитьПараметр("ПервичныйДокумент", Объект.Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		КоличествоСвязанныхОбъектов = Выборка.КоличествоОбъектов;
	Иначе
		КоличествоСвязанныхОбъектов = 0;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти