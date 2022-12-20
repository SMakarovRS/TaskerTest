﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	// Заполнение реквизита для RLS.
	Если Не ЭтоНовый() Тогда
		ГруппаДоступа = Ссылка;
	ИначеЕсли ЗначениеЗаполнено(ПолучитьСсылкуНового()) Тогда
		ГруппаДоступа = ПолучитьСсылкуНового();
	Иначе
		ГруппаДоступа = Справочники.ГруппыДоступаКатегорийБазыЗнаний.ПолучитьСсылку();
		УстановитьСсылкуНового(ГруппаДоступа);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли