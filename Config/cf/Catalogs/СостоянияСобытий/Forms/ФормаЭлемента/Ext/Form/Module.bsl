﻿
#Область ОбработчикиСобытийФормы

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

// Процедура ПриСозданииНаСервере
//
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Цвет = Объект.Ссылка.Цвет.Получить();
	Иначе
		ЗначениеКопирования = Неопределено;
		Параметры.Свойство("ЗначениеКопирования", ЗначениеКопирования);
		Если ЗначениеКопирования <> Неопределено Тогда
			Цвет = ЗначениеКопирования.Цвет.Получить();
		Иначе
			Цвет = Новый Цвет(0, 0, 0);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры // ПриСозданииНаСервере()

// Процедура ПередЗаписьюНаСервере
//
&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Цвет = Новый Цвет(0, 0, 0) Тогда
		ТекущийОбъект.Цвет = Новый ХранилищеЗначения(Неопределено);
	Иначе
		ТекущийОбъект.Цвет = Новый ХранилищеЗначения(Цвет);
	КонецЕсли;
	
КонецПроцедуры // ПередЗаписьюНаСервере()

// Процедура ПередЗаписьюНаСервере
//
&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_СостоянияСобытий");
	
КонецПроцедуры // ПослеЗаписи()

#КонецОбласти