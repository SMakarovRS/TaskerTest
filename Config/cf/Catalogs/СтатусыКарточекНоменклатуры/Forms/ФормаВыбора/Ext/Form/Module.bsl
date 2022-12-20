﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("КарточкаНоменклатуры") Тогда
		
		КарточкаНоменклатуры = Параметры.КарточкаНоменклатуры;
		МассивСтатусов       = 
			КарточкаНоменклатуры.Владелец.ВидНоменклатуры.СтатусыКарточкиНоменклатуры.ВыгрузитьКолонку("Статус");
		
		Если МассивСтатусов.Количество() > 0 Тогда
			РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Список, "Ссылка", МассивСтатусов, 
				, ВидСравненияКомпоновкиДанных.ВСписке);
				
		КонецЕсли;
			
			
	КонецЕсли;	
	
	ДоступноИзменение = ПравоДоступа("Изменение", Метаданные.Справочники.СтатусыКарточекНоменклатуры);

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти
