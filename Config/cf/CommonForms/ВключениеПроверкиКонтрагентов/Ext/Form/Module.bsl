﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЕстьПравоНаРедактированиеНастроекСервиса = ПроверкаКонтрагентов.ЕстьПравоНаРедактированиеНастроек();
	
	ПроверкаКонтрагентов.СохранитьДатуПоследнегоОтображенияПредложенияПодключиться();
	
	УправлениеЭУ();
	
КонецПроцедуры

&НаКлиенте
Процедура НапомнитьПозже(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВключитьСервисСейчас(Команда)
	
	ПроверкаКонтрагентовВызовСервера.ПриВключенииВыключенииПроверки(Истина);
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура РучнаяПроверка(Команда)
	
	ПроверкаКонтрагентовВызовСервера.ЗапомнитьЧтоБольшеНеНужноПоказыватьПредложениеИспользоватьСервис();
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура БольшеНеПоказывать(Команда)
	
	ПроверкаКонтрагентовВызовСервера.ЗапомнитьЧтоБольшеНеНужноПоказыватьПредложениеИспользоватьСервис();
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УправлениеЭУ()
	
	ЭтоМедленныйРежимРаботы = ПроверкаКонтрагентов.ЭтоМедленныйРежимРаботы();
	
	// В зависимости от наличия административных прав будут доступны разные элементы управления.
	Элементы.ИнформацияОНеобходимостиОбратитьсяКАдминистратору.ОтображатьЗаголовок = 
		НЕ ЕстьПравоНаРедактированиеНастроекСервиса;
	
	СтандартныеПодсистемыСервер.УстановитьОтображениеЗаголовковГрупп(ЭтотОбъект);
	
	// Управление кнопками. Видимость.
	Элементы.ВключитьСервисСейчас.Видимость = ЕстьПравоНаРедактированиеНастроекСервиса;
	Элементы.РучнаяПроверка.Видимость       = ЕстьПравоНаРедактированиеНастроекСервиса;
	Элементы.БольшеНеПоказывать.Видимость   = НЕ ЕстьПравоНаРедактированиеНастроекСервиса;
	
	// Управление кнопками. Кнопка по умолчанию.
	Если ЕстьПравоНаРедактированиеНастроекСервиса Тогда
		Если ЭтоМедленныйРежимРаботы Тогда
			Элементы.РучнаяПроверка.КнопкаПоУмолчанию = Истина;
		Иначе
			Элементы.ВключитьСервисСейчас.КнопкаПоУмолчанию = Истина;
		КонецЕсли;
	Иначе
		Элементы.НапомнитьПозже.КнопкаПоУмолчанию = Истина;
	КонецЕсли;
	
	// Настройка в зависимости от медленности компьютера.
	Элементы.РежимыМедленнойРаботы.Видимость = ЭтоМедленныйРежимРаботы;
	Если ЭтоМедленныйРежимРаботы Тогда
		УправлениеНадписьюДляМедленногоРежима();
	Иначе
		ПрисоединитьСсылкуНаИнструкцию(Элементы.ИнформацияОСервисе);
	КонецЕсли;
	
	// Сообщаем про тестовый режим.
	ПроверкаКонтрагентов.УстановитьВидимостьИЗаголовокПредупрежденияПроТестовыйРежим(Элементы.ТестовыйРежим);
	
	КлючСохраненияПоложенияОкна = Строка(ЕстьПравоНаРедактированиеНастроекСервиса)
		+ Строка(ЭтоМедленныйРежимРаботы)
		+ Строка(Элементы.ТестовыйРежим.Видимость);
	
КонецПроцедуры

&НаСервере
Процедура УправлениеНадписьюДляМедленногоРежима()

	ИБФайловая = (ОбщегоНазначения.ИнформационнаяБазаФайловая()
		И Не ОбщегоНазначения.КлиентПодключенЧерезВебСервер());

	Если ИБФайловая Тогда
		Элементы.РежимыМедленнойРаботы.ТекущаяСтраница = Элементы.НедостаточноПамяти;
	Иначе
		Элементы.РежимыМедленнойРаботы.ТекущаяСтраница = Элементы.МедленноеСоединение;
	КонецЕсли;

КонецПроцедуры
	
&НаСервере
Процедура ПрисоединитьСсылкуНаИнструкцию(Элемент)
	
	ПутьКИнструкции = Новый ФорматированнаяСтрока(
		НСтр("ru = 'Подробнее о проверке'"),
		,
		,
		,
		ПроверкаКонтрагентовКлиентСервер.ПутьКИнструкции());
	
	Элемент.Заголовок = Новый ФорматированнаяСтрока(
		Элемент.Заголовок,
		Символы.ПС,
		ПутьКИнструкции);
	
КонецПроцедуры

#КонецОбласти
