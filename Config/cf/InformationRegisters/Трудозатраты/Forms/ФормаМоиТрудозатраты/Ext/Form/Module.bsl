﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущийПользователь  = Пользователи.ТекущийПользователь();
	УстановитьПериод();
	Список.Параметры.УстановитьЗначениеПараметра("Исполнитель",   ТекущийПользователь);
	Период = Новый СтандартныйПериод(ВариантСтандартногоПериода.Сегодня);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	УстановитьПериод();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновитьМоиТрудозатраты" Тогда
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПериодПриИзменении(Элемент)
	
	УстановитьПериод();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Копирование Тогда
		Отказ = Истина;
		ТекущиеДанные = Элементы.Список.ТекущиеДанные;		
		Если ТекущиеДанные = Неопределено Тогда
			Возврат;
		КонецЕсли;
		СтруктураПараметров = Новый Структура;
		СтруктураПараметров.Вставить("Объект", 			 ТекущиеДанные.Объект); 
		СтруктураПараметров.Вставить("Исполнитель", 	 ТекущиеДанные.Исполнитель); 
		СтруктураПараметров.Вставить("Инициатор", 	 	 ТекущиеДанные.Инициатор); 
		СтруктураПараметров.Вставить("КлючУникальности", Новый УникальныйИдентификатор);
		СтруктураПараметров.Вставить("ДатаНачала", 		 ТекущиеДанные.ДатаНачала); 
		СтруктураПараметров.Вставить("ДатаОкончания", 	 ТекущиеДанные.ДатаОкончания); 
		СтруктураПараметров.Вставить("Длительность", 	 ТекущиеДанные.Длительность); 
		СтруктураПараметров.Вставить("ВидРаботы", 		 ТекущиеДанные.ВидРаботы); 
		СтруктураПараметров.Вставить("Описание", 		 ТекущиеДанные.Описание); 
		СтруктураПараметров.Вставить("Данные", 			 ТекущиеДанные.Данные); 
		СтруктураПараметров.Вставить("ВидФормы", 		 "ФормаНовойЗаписиКопирование");
		ОписаниеОповещения  = Новый ОписаниеОповещения("ПослеДобавленияТрудозатрат", ЭтотОбъект);		
		ОткрытьФорму("РегистрСведений.Трудозатраты.Форма.ФормаЗаписи", СтруктураПараметров, ЭтотОбъект,,,, 
            ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Иначе
		Отказ = Истина;
		Добавить(Неопределено);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура Добавить(Команда)	
	
	ОписаниеОповещения  = Новый ОписаниеОповещения("ПослеДобавленияТрудозатрат", ЭтотОбъект);
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ВидФормы", "ФормаНовойЗаписиМоиТрудозатраты");
	ОткрытьФорму("РегистрСведений.Трудозатраты.Форма.ФормаЗаписи", СтруктураПараметров, ЭтотОбъект,,,,
        ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеДобавленияТрудозатрат(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПериод()	
	
	МоментВремени 		 = ТекущаяДатаСеанса();
	Если Период.ДатаНачала = Дата(1, 1, 1) Тогда
		Период.ДатаНачала = НачалоДня(МоментВремени);
	КонецЕсли;
	Если Период.ДатаОкончания = Дата(1, 1, 1) Тогда
		Период.ДатаОкончания = КонецДня(МоментВремени);
	КонецЕсли;
	
	Список.Параметры.УстановитьЗначениеПараметра("ДатаНачала",    НачалоДня(Период.ДатаНачала)); 
	Список.Параметры.УстановитьЗначениеПараметра("ДатаОкончания", КонецДня(Период.ДатаОкончания));
	
КонецПроцедуры

#КонецОбласти
