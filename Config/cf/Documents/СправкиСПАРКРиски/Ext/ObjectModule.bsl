﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоНовый() Тогда
		Если Не ЗначениеЗаполнено(Идентификатор) Тогда
			ВызватьИсключение НСтр("ru = 'Не заполнен идентификатор справки.'");
		КонецЕсли;
		Пользователь = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
	Если ПометкаУдаления Тогда
		Попытка
			СПАРКРиски.ОтменитьЗаданиеПроверкиГотовностиСправкиСПАРКРиски(Идентификатор);
		Исключение
			СПАРКРиски.ЗаписатьОшибкуВЖурналРегистрации(
				ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		СПАРКРиски.ОтменитьЗаданиеПроверкиГотовностиСправкиСПАРКРиски(Идентификатор);
	Исключение
		СПАРКРиски.ЗаписатьОшибкуВЖурналРегистрации(
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли