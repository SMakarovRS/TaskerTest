﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если НЕ ЭтоГруппа Тогда
	
		КоличествоИзмерений = Измерения.Количество();
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Ошибки = Неопределено;
	
	ТЗ = Измерения.Выгрузить();
	ТЗ.Колонки.Добавить("Колво");
	ТЗ.ЗаполнитьЗначения(1, "Колво");
	ТЗ.Свернуть("Назначение", "Колво");
	
	Для Каждого Строки Из ТЗ Цикл
		
		Если ЗначениеЗаполнено(Строки.Назначение) И Строки.Колво > 1 Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, 
				"Объект.Измерения", 
				НСтр("ru = 'В столбце ""Назначение"" значения ""Пользователь"" и ""Проект"" могут быть указаны
				| только по одному измерению на каждое ""Назначение"".'"),
				"Ошибки");
		КонецЕсли;
		
	КонецЦикла;
	
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Идентификатор = "";
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли