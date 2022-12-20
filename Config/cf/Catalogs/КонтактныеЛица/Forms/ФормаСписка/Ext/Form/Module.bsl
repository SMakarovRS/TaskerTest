﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	ПоказыватьАктуальных = Истина;
	ОбновитьВидимостьДоступность();

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

&НаКлиенте
Процедура ПоказыватьТолькоАктуальных(Команда)
	
	ПоказыватьАктуальных = НЕ ПоказыватьАктуальных;
	ОбновитьВидимостьДоступность();
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьВидимостьДоступность()
	
	Элементы.ФормаПоказыватьТолькоАктуальных.Пометка = ПоказыватьАктуальных;
	
	Если ПоказыватьАктуальных Тогда
		// Только актуальные.
		РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Список, "Актуальность", Истина);
	Иначе				
		// Всех подряд
		РаботаСОтборамиКлиентСервер.УдалитьЭлементОтбораСписка(Список, "Актуальность");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
