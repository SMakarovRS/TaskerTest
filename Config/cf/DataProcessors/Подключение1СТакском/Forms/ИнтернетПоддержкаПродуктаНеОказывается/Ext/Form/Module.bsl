﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

// Хранение контекста взаимодействия с сервисом
&НаКлиенте
Перем КонтекстВзаимодействия Экспорт;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если КлиентскоеПриложение.ТекущийВариантИнтерфейса() = ВариантИнтерфейсаКлиентскогоПриложения.Такси Тогда
		Элементы.ГруппаКонтента.Отображение = ОтображениеОбычнойГруппы.Нет;
	КонецЕсли;
	
	Если Параметры.ПриНачалеРаботыСистемы Тогда
		ЗапускатьПриСтарте = Истина;
	Иначе
		Элементы.ГруппаЗапускатьПриСтарте.Видимость = Ложь;
	КонецЕсли;
	
	КлючСохраненияПоложенияОкна = Строка(ЗапускатьПриСтарте);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Подключение1СТакскомКлиент.ОбработатьОткрытиеФормы(КонтекстВзаимодействия, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если Не ПрограммноеЗакрытие Тогда
		Подключение1СТакскомКлиент.ЗавершитьБизнесПроцесс(КонтекстВзаимодействия, ЗавершениеРаботы);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НадписьСодержанияКонтентаОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "TechSupport" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ИнтернетПоддержкаПользователейКлиент.ОтправитьСообщениеВТехПоддержку(
			НСтр("ru = 'Интернет-поддержка. Интернет-поддержка продукта не оказывается.'"),
			НСтр("ru = 'При подключении Интернет-поддержки отображается сообщение ""Интернет-поддержка продукта не оказывается"".'"),
			,
			,
			Новый Структура("Логин, Пароль",
				Подключение1СТакскомКлиент.ЗначениеСессионногоПараметра(
					КонтекстВзаимодействия.КСКонтекст,
					"login"),
				Подключение1СТакскомКлиент.ЗначениеСессионногоПараметра(
					КонтекстВзаимодействия.КСКонтекст,
					"password")));
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура УстановитьНастройкуЗапускатьПриСтарте(ЗначениеНастройки)
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(
		"ИнтернетПоддержкаПользователей",
		"ВсегдаПоказыватьПриСтартеПрограммы",
		ЗначениеНастройки);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапускатьПриСтартеПриИзменении(Элемент)
	
	УстановитьНастройкуЗапускатьПриСтарте(ЗапускатьПриСтарте);
	
КонецПроцедуры

#КонецОбласти