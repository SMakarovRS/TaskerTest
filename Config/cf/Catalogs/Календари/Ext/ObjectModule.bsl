﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЗначениеЗаполнено(ДатаОкончания) И ДатаОкончания < ДатаНачала Тогда
		ТекстСообщения = НСтр("ru = 'Дата окончания меньше даты начала. Скорее всего, дата окончания заполнена неверно.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, Ссылка, , , Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан("Справочник.Календари");
	
	Если Не УчитыватьПраздники Тогда
		// Если график работы не учитывает праздники, то нужно удалить интервалы предпраздничного дня.
		РасписаниеПредпраздничногоДня = РасписаниеРаботы.НайтиСтроки(Новый Структура("НомерДня", 0));
		Для Каждого СтрокаРасписания Из РасписаниеПредпраздничногоДня Цикл
			РасписаниеРаботы.Удалить(СтрокаРасписания);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	// Если дата окончания не указана, она будет подобрана по производственному календарю.
	ДатаОкончанияЗаполнения = ДатаОкончания;
	
	ДниВключенныеВГрафик = РегистрыСведений.КалендарныеГрафики.ДниВключенныеВГрафик(
									ДатаНачала, 
									СпособЗаполнения, 
									ШаблонЗаполнения, 
									ДатаОкончанияЗаполнения,
									ПроизводственныйКалендарь, 
									УчитыватьПраздники, 
									ДатаОтсчета);
									
	РегистрыСведений.КалендарныеГрафики.ЗаписатьДанныеГрафикаВРегистр(
		Ссылка, ДниВключенныеВГрафик, ДатаНачала, ДатаОкончанияЗаполнения);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли