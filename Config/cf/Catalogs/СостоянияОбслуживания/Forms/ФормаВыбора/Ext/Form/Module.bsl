﻿
#Область ОбработчикиСобытийФормы

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
// Процедура - обработчик события ПриСозданииНаСервере.
//
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	// Выделение основного элемента	
	Список.Параметры.УстановитьЗначениеПараметра("НастройкаПользователя", ПланыВидовХарактеристик.НастройкиПользователей["СостояниеНовогоОбслуживания"]);
	Список.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь", Пользователи.ТекущийПользователь());
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
// Процедура - обработчик события ОбработкаОповещения.
//
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененыНастройкиПользователя" Тогда
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры // ОбработкаОповещения()

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
// Процедура - обработчик события ПриАктивизацииСтроки.
//
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ОсновнаяНастройка = Элементы.Список.ТекущиеДанные.ОсновнаяНастройка;
	
	Если ОсновнаяНастройка Тогда
		Элементы.ФормаКомандаУстановитьОсновнойЭлемент.Заголовок = НСтр("ru = 'Используется при создании новых ремонтов'");
		Элементы.ФормаКомандаУстановитьОсновнойЭлемент.Доступность = Ложь;
	Иначе
		Элементы.ФормаКомандаУстановитьОсновнойЭлемент.Заголовок = "";
		Элементы.ФормаКомандаУстановитьОсновнойЭлемент.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры // СписокПриАктивизацииСтроки()

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
// Процедура - обработчик выполнения команды УстановитьОсновнойЭлемент.
//
Процедура КомандаУстановитьОсновнойЭлемент(Команда)
		
	ВыбранныйЭлемент = Элементы.Список.ТекущаяСтрока;
	Если ЗначениеЗаполнено(ВыбранныйЭлемент) Тогда
		УправлениеITОтделом8УФ.УстановитьНастройкуПользователя(ВыбранныйЭлемент, "СостояниеНовогоОбслуживания");
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти