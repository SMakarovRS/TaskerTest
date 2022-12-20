﻿//////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ФОРМЫ

&НаКлиенте
Процедура сфпУстановитьТекущиеОтборы()
	ЭлементыСпискаОтбора = Список.КомпоновщикНастроек.Настройки.Отбор.Элементы;
	Для Каждого ТекущийОтбор Из ЭлементыСпискаОтбора Цикл
		Если ТекущийОтбор.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный Тогда
			Если ТекущийОтбор.Представление = "ОтборПоПользователям" Тогда
				Если СписокПользователей.Количество() > 0 Тогда
					ТекущийОтбор.ПравоеЗначение	= СписокПользователей;
					ТекущийОтбор.Использование	= Истина;
				Иначе
		            ТекущийОтбор.Использование	= Ложь;
				КонецЕсли;	
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	сфпУстановитьТекущиеОтборы()
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если сфпСофтФонПроСервер.сфпИспользоватьОграничениеПоказаТелефонныхЗвонков() Тогда
		ТекПользователь 	= сфпСофтФонПроСервер.сфпТекущийПользователь();
		МассивПользователей = сфпСофтФонПроСервер.сфпПолучитьМассивПрослушиваемыхПользователей(ТекПользователь);
		СписокПользователей = сфпСофтФонПроСервер.сфпПреобразоватьМассивЗвонящихВСписокЗначений(МассивПользователей);
	Иначе
		СписокПользователей = Новый СписокЗначений;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОповеститьОВыборе(Значение);
КонецПроцедуры

&НаКлиенте
Процедура Выбрать(Команда)
	ТекДанные = Элементы.Список.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда Возврат; КонецЕсли;
	ОповеститьОВыборе(ТекДанные.Ссылка);
КонецПроцедуры
