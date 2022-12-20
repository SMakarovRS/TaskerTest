﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	БазовыеЦвета = ЗначениеИзСтрокиВнутр(ПолучитьОбщийМакет("БазовыеЦвета").ПолучитьТекст());
	Если Объект.Ссылка.Пустая() Тогда
		РедактируемыйЦветФона 				= WebЦвета.Белый;
		РедактируемыйЦветТекста 			= WebЦвета.Черный;
	Иначе
		Попытка
			РедактируемыйЦветФона 			= РаботаСЦветомКлиентСервер.HexВЦвет(Объект.ЦветФона);
			РедактируемыйЦветТекста 		= РаботаСЦветомКлиентСервер.HexВЦвет(Объект.ЦветТекста);
		Исключение
			РедактируемыйЦветФона 			= WebЦвета.Белый;
			РедактируемыйЦветТекста 		= WebЦвета.Черный;
		КонецПопытки;
	КонецЕсли;
	
	НоваяСтрока 		= ПримерТекста.Добавить();
	НоваяСтрока.Пример 	= НСтр("ru = 'Пример текста,'");
	НоваяСтрока 		= ПримерТекста.Добавить();
	НоваяСтрока.Пример 	= НСтр("ru = 'который будет выводиться'");
	НоваяСтрока 		= ПримерТекста.Добавить();
	НоваяСтрока.Пример 	= НСтр("ru = 'в списке проектов'");
	
	ОбновитьИзображение();
	ОбновитьЦветТекстаИФона();
		
	Если Объект.Ссылка.Пустая() Тогда
		Если НЕ ЗначениеЗаполнено(Объект.ОтветственныйЗаПроект) Тогда
			Объект.ОтветственныйЗаПроект 	= Пользователи.ТекущийПользователь();
			Объект.ДатаНачала				= НачалоДня(ТекущаяДатаСеанса());
			Объект.ДатаОкончания			= КонецМесяца(ТекущаяДатаСеанса());
		КонецЕсли;
	КонецЕсли;
	
	#Область БСП
			
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "СтраницаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	#КонецОбласти
	
	#Область Трудозатраты
	ОбновитьЗаголовокТрудозатрат();

	РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Трудозатраты, "Объект", Объект.Ссылка);
	#КонецОбласти
	
	ОбновитьЗаголовокЧекЛиста();
	
	ЗаданияСервер.УстановитьШагКорректировкиВеса(ШагКорректировкиВеса);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Описание = ТекущийОбъект.Описание.Получить();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ЗначениеЗаполнено(ТекущийОбъект.Родитель) Тогда
		ОбщегоНазначения.СообщитьПользователю(
			НСтр("ru = 'Проект нельзя перенести в другой проект. В следующем релизе в проекты будут добавлены группы проектов (папки) и проекты можно будет распределить по группам.'"),
			, "Объект.Родитель");
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	ТекущийОбъект.Описание = Новый ХранилищеЗначения(Описание);
	
	ТекущийОбъект.ЦветФона   = РаботаСЦветомКлиентСервер.ЦветВHex(РедактируемыйЦветФона);
	ТекущийОбъект.ЦветТекста = РаботаСЦветомКлиентСервер.ЦветВHex(РедактируемыйЦветТекста);
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	УправлениеITОтделом8УФКлиент.ОбновитьОграничениеТипаКлиента(Объект.Инициатор, Элементы.Клиент);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	#Область Трудозатраты	
	ОбновитьЗаголовокТрудозатрат();
	РаботаСОтборамиКлиентСервер.УстановитьЭлементОтбораСписка(Трудозатраты.Отбор, "Объект", Объект.Ссылка);
	#КонецОбласти
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновитьМоиТрудозатраты" Тогда
		
		Если Объект.Ссылка = Источник Тогда
			Элементы.Трудозатраты.Обновить();
			ОбновитьЗаголовокТрудозатрат();
		КонецЕсли;		
		
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)

	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("ОбновитьЦветаПроектов");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьПериод(Команда)
	
	Диалог = Новый ДиалогРедактированияСтандартногоПериода();
	Диалог.Период = Новый СтандартныйПериод(Объект.ДатаНачала, КонецДня(Объект.ДатаОкончания));
	Диалог.Показать(Новый ОписаниеОповещения("ВыборПериодаЗавершение", ЭтотОбъект, Новый Структура("Диалог", Диалог)));	
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПериодПлан(Команда)
	
	Диалог = Новый ДиалогРедактированияСтандартногоПериода();
	Диалог.Период = Новый СтандартныйПериод(Объект.ДатаНачалаПлан, КонецДня(Объект.ДатаОкончанияПлан));
	Диалог.Показать(Новый ОписаниеОповещения("ВыборПериодаПланЗавершение", ЭтотОбъект, Новый Структура("Диалог", Диалог)));	
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьНастройкиЦвета(Команда)
	
	РедактируемыйЦветФона 	= WebЦвета.Белый;
	РедактируемыйЦветТекста = WebЦвета.Черный;
	ОбновитьЦветТекстаИФона();
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СлучайныеЦвета(Команда)
	
	СлучайныйЦветНаСервере();

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьИзображениеИзНабора(Команда)
	
	Результат = Неопределено;	
	ОткрытьФорму("ОбщаяФорма.ФормаВыбораИзображенияИзНабора",,,,,,
		Новый ОписаниеОповещения("ВыбратьИзображениеИзНабораЗавершение", ЭтотОбъект),
			РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
			
КонецПроцедуры
		
&НаКлиенте
Процедура ВыбратьИзображениеИзНабораЗавершение(Результат, ДополнительныеПараметры) Экспорт
    
    Если Результат <> Неопределено Тогда
        Адрес = ПоместитьВоВременноеХранилище(Результат);
        ПоместитьФайлОбъекта(Адрес);
        Элементы.АдресКартинки.Обновить();
		ОбновитьИзображение();
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьИзображениеИзФайла(Команда)
	
	ВыбратьКартинкуИзФайла();
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьИзображение(Команда)
	
	ОчиститьИзображениеНаСервере();	
	ОбновитьИзображение();
	Элементы.АдресКартинки.Обновить();
	
КонецПроцедуры

&НаКлиенте
Процедура Диаграмма(Команда)
	
	УправлениеITОтделом8УФКлиент.ОткрытьДиаграммуГантаПроекта(Объект.Ссылка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КлиентПриИзменении(Элемент)
	
	УправлениеITОтделом8УФКлиент.ОбновитьОграничениеТипаКлиента(Объект.Инициатор, Элементы.Клиент);
	
КонецПроцедуры

&НаКлиенте
Процедура ИнициаторОчистка(Элемент, СтандартнаяОбработка)
	
	УправлениеITОтделом8УФКлиент.ОбновитьОграничениеТипаКлиента(Объект.Инициатор, Элементы.Клиент);
	
КонецПроцедуры

&НаКлиенте
Процедура ВесРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	Если ШагКорректировкиВеса > 1 Тогда		
		
		СтандартнаяОбработка = Ложь;
		Если Направление = 1 Тогда
			Объект.Вес = Объект.Вес + ШагКорректировкиВеса;
		Иначе
			Объект.Вес = Объект.Вес - ШагКорректировкиВеса;
		КонецЕсли;	
		
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветФонаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Результат = Неопределено;

	ПоказатьВыборИзСписка(Новый ОписаниеОповещения("РедактируемыйЦветНачалоВыбораЗавершение2", ЭтотОбъект), БазовыеЦвета,
		Элемент, БазовыеЦвета.НайтиПоЗначению(РедактируемыйЦветФона));

	КонецПроцедуры
	
&НаКлиенте
Процедура РедактируемыйЦветНачалоВыбораЗавершение2(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
    
    Результат = ВыбранныйЭлемент;
    Если Результат <> Неопределено Тогда
        
        Если ТипЗнч(Результат.Значение) = Тип("Строка") Тогда
            ПараметрыФормы = Новый Структура("РедактируемыйЦвет", РедактируемыйЦветФона);
            ОткрытьФорму("ОбщаяФорма.ФормаВыбораЦвета", ПараметрыФормы, Элементы.РедактируемыйЦветФона,,,,
				Новый ОписаниеОповещения("РедактируемыйЦветНачалоВыбораЗавершение", ЭтотОбъект,
					Новый Структура("Результат", Результат)), РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
            Возврат;
        Иначе
            РедактируемыйЦветФона = Результат.Значение;
        КонецЕсли;
        РедактируемыйЦветНачалоВыбораФрагмент();
        
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветНачалоВыбораЗавершение(Результат1, ДополнительныеПараметры) Экспорт

    Результат = ДополнительныеПараметры.Результат;
    РедактируемыйЦветНачалоВыбораФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветНачалоВыбораФрагмент()

    ОбновитьЦветТекстаИФона();

КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветТекстаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Результат = Неопределено;
	
	ПоказатьВыборИзСписка(Новый ОписаниеОповещения("РедактируемыйЦветТекстаНачалоВыбораЗавершение1", ЭтотОбъект),
		БазовыеЦвета, Элемент, БазовыеЦвета.НайтиПоЗначению(РедактируемыйЦветТекста));
		
КонецПроцедуры
	
&НаКлиенте
Процедура РедактируемыйЦветТекстаНачалоВыбораЗавершение1(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
    
    Результат = ВыбранныйЭлемент;
    Если Результат <> Неопределено Тогда
        
        Если ТипЗнч(Результат.Значение) = Тип("Строка") Тогда
            ПараметрыФормы = Новый Структура("РедактируемыйЦвет", РедактируемыйЦветТекста);
            ОткрытьФорму("ОбщаяФорма.ФормаВыбораЦвета", ПараметрыФормы, Элементы.РедактируемыйЦветТекста,,,,
				Новый ОписаниеОповещения("РедактируемыйЦветТекстаНачалоВыбораЗавершение", ЭтотОбъект,
					Новый Структура("Результат", Результат)), РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
            Возврат;
        Иначе
            РедактируемыйЦветТекста = Результат.Значение;
        КонецЕсли;
        РедактируемыйЦветТекстаНачалоВыбораФрагмент();
        
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветТекстаНачалоВыбораЗавершение(Результат1, ДополнительныеПараметры) Экспорт
    
    Результат = ДополнительныеПараметры.Результат;
    
    
    РедактируемыйЦветТекстаНачалоВыбораФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветТекстаНачалоВыбораФрагмент()
    
    ОбновитьЦветТекстаИФона();

КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветТекстаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Цвет") Тогда
		РедактируемыйЦветТекста = ВыбранноеЗначение;
		ОбновитьЦветТекстаИФона();
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура РедактируемыйЦветФонаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Цвет") Тогда
		РедактируемыйЦветФона = ВыбранноеЗначение;
		ОбновитьЦветТекстаИФона();
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура АдресКартинкиНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьКартинкуИзФайла();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПроектнаяГруппа

&НаКлиенте
Процедура ПроектнаяГруппаУчастникОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
		Если ТипЗнч(ВыбранноеЗначение) = Тип("Тип") 			
			И ЭтоТипОрганизация(ВыбранноеЗначение) Тогда
			СтандартнаяОбработка = Ложь;
					
			ОткрытьФормуВыбораОрганизации("Участник");
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТрудозатраты

&НаКлиенте
Процедура ТрудозатратыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если КоличествоЗаписейТрудозатрат > 0 И ПоследняяДатаОкончанияТрудозатратОбъекта() = Дата(1, 1, 1) Тогда
		Отказ = Истина;
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Установите дату окончания в последней строке для добавления новых данных по трудозатратам'"), , Элементы.Трудозатраты);
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПоследняяДатаОкончанияТрудозатратОбъекта()
	
	Возврат ТрудозатратыСервер.ПоследняяДатаОкончанияТрудозатратОбъекта(Объект.Ссылка);
	
КонецФункции

&НаКлиенте
Процедура ТрудозатратыПослеУдаления(Элемент)
	
	ОбновитьЗаголовокТрудозатрат();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыЧекЛист

&НаКлиенте
Процедура ЧекЛистПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		Элемент.ТекущиеДанные.Автор = ПользователиКлиент.АвторизованныйПользователь();
		Элемент.ТекущиеДанные.Дата 	= ПолучитьДатуНаСервере();
		Элемент.ТекущиеДанные.Вес 	= 1;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЧекЛистПослеУдаления(Элемент)
	
	
	ПодключитьОбработчикОжидания("ОбновитьЗаголовокЧекЛистаКлиент", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЧекЛистПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ПодключитьОбработчикОжидания("ОбновитьЗаголовокЧекЛистаКлиент", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЧекЛистВыполненоПриИзменении(Элемент)
		
	ОбновитьЗаголовокЧекЛиста();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область БСП

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, 
	НавигационнаяСсылка = Неопределено, 
	СтандартнаяОбработка = Неопределено)
	
    УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойств

#КонецОбласти

&НаСервере
Процедура ОбновитьЦветТекстаИФона()
	
	Элементы.ПримерТекстаСтолбец.ЦветФона   		= РедактируемыйЦветФона;
	Элементы.ПримерТекстаСтолбец.ЦветТекста 		= РедактируемыйЦветТекста;
		
КонецПроцедуры

&НаКлиенте
Процедура ВыборПериодаЗавершение(Период, ДополнительныеПараметры) Экспорт
    
    Диалог = ДополнительныеПараметры.Диалог;
        
    Если Период <> Неопределено Тогда 
        Объект.ДатаНачала 		= Период.ДатаНачала;
		Объект.ДатаОкончания 	= Период.ДатаОкончания;		
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыборПериодаПланЗавершение(Период, ДополнительныеПараметры) Экспорт
    
    Диалог = ДополнительныеПараметры.Диалог;
        
    Если Период <> Неопределено Тогда 
        Объект.ДатаНачалаПлан 		= Период.ДатаНачала;
		Объект.ДатаОкончанияПлан 	= Период.ДатаОкончания;
    КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ОбновитьЗаголовокЧекЛиста()
	
	ЗаголовокЧекЛист = "";
	Если Объект.ЧекЛист.Количество() > 0 Тогда
		ЗаголовокЧекЛист = СтрШаблон(НСтр("ru = '%1 из %2'"), Объект.ЧекЛист.НайтиСтроки(Новый Структура("Выполнено", Истина)).Количество(), Объект.ЧекЛист.Количество());
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗаголовокЧекЛистаКлиент()
	
	ОбновитьЗаголовокЧекЛиста();
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьДатуНаСервере()
	
	Возврат ТекущаяДатаСеанса();
	
КонецФункции

#Область Трудозатраты

&НаСервере
Процедура ОбновитьЗаголовокТрудозатрат()
	
	КоличествоЗаписейТрудозатрат = ТрудозатратыСервер.КоличествоЗаписейТрудозатратОбъекта(Объект.Ссылка);
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ОткрытьФормуВыбораОрганизации(Знач ПолеРаботы)
	
	ПараметрыПоля = Новый Структура;
	ПараметрыПоля.Вставить("ИмяПоля", ПолеРаботы);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВыбораОрганизации", ЭтотОбъект, ПараметрыПоля); 
	ОткрытьФорму("Справочник.Организации.ФормаВыбора", , ЭтотОбъект, , , , 
		ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);   
	
КонецПроцедуры

&НаСервере
Функция ЭтоТипОрганизация(Знач Значение)	
	
	Возврат Метаданные.НайтиПоТипу(Значение).Имя = "Организации";
	
КонецФункции

&НаКлиенте
Процедура ПослеВыбораОрганизации(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элементы.ПроектнаяГруппа.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		 ТекущиеДанные[ДополнительныеПараметры.ИмяПоля] = Результат;
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура СлучайныйЦветНаСервере()
        
	РедактируемыйЦветФона = РаботаСЦветомКлиентСервер.СлучайныйСветлыйЦвет();
	РедактируемыйЦветТекста = РаботаСЦветомКлиентСервер.КонтрастныйЦвет(РедактируемыйЦветФона);
	ОбновитьЦветТекстаИФона();
	Модифицированность = Истина;
	
КонецПроцедуры

// Процедура извлекает данные объекта из временного хранилища, 
// производит модификацию элемента справочника и записывает его.
// 
// Параметры: 
//  АдресВременногоХранилища - Строка - адрес временного хранилища. 
// 
// Возвращаемое значение: 
//  Нет.
&НаСервере
Процедура ПоместитьФайлОбъекта(АдресВременногоХранилища)
	
	ЭлементСправочника = РеквизитФормыВЗначение("Объект");
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресВременногоХранилища);
	ЭлементСправочника.Картинка = Новый ХранилищеЗначения(ДвоичныеДанные, Новый СжатиеДанных());
	ЭлементСправочника.Записать();
	Модифицированность = Ложь;
	УдалитьИзВременногоХранилища(АдресВременногоХранилища);
	ЗначениеВРеквизитФормы(ЭлементСправочника, "Объект"); 
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьИзображение()
	
	АдресКартинки = ПолучитьНавигационнуюСсылку(Объект.Ссылка, "Картинка")
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКартинкуИзФайла()
	
	Перем ВыбранноеИмя;
	Перем АдресВременногоХранилища;

	НачатьПодключениеРасширенияРаботыСФайлами(Новый ОписаниеОповещения("ВыбратьКартинкуИзФайлаЗавершение2", ЭтотОбъект, 
		Новый Структура("АдресВременногоХранилища", АдресВременногоХранилища)));
	
КонецПроцедуры
	
&НаСервере
Процедура ОчиститьИзображениеНаСервере()
	
	ЭлементСправочника = РеквизитФормыВЗначение("Объект");
	ЭлементСправочника.Картинка = Неопределено;
	ЭлементСправочника.Записать();
	Модифицированность = Ложь;
	ЗначениеВРеквизитФормы(ЭлементСправочника, "Объект");
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКартинкуИзФайлаЗавершение1(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	АдресВременногоХранилища = ДополнительныеПараметры.АдресВременногоХранилища;
	ДиалогОткрытияФайла = ДополнительныеПараметры.ДиалогОткрытияФайла;
	
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		ВыбранноеИмя = ДиалогОткрытияФайла.ПолноеИмяФайла;
		НачатьПомещениеФайла(Новый ОписаниеОповещения("ВыбратьКартинкуИзФайлаЗавершение", ЭтотОбъект, 
			Новый Структура("АдресВременногоХранилища", АдресВременногоХранилища)), 
			АдресВременногоХранилища, ВыбранноеИмя, Ложь,);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКартинкуИзФайлаЗавершение2(Подключено, ДополнительныеПараметры) Экспорт
	
	АдресВременногоХранилища = ДополнительныеПараметры.АдресВременногоХранилища;
	
	Если Подключено Тогда
		Режим = РежимДиалогаВыбораФайла.Открытие;
		ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(Режим);
		ДиалогОткрытияФайла.ПолноеИмяФайла = "";
		Фильтр = УправлениеITОтделом8УФКлиентСервер.ПолучитьФильтрИзображений();
		ДиалогОткрытияФайла.Фильтр = Фильтр;
		ДиалогОткрытияФайла.МножественныйВыбор = Ложь;
		ДиалогОткрытияФайла.Заголовок = НСтр("ru = 'Выберите изображение'");
		ДиалогОткрытияФайла.Показать(Новый ОписаниеОповещения("ВыбратьКартинкуИзФайлаЗавершение1", ЭтотОбъект,
			Новый Структура("АдресВременногоХранилища, ДиалогОткрытияФайла", АдресВременногоХранилища, ДиалогОткрытияФайла)));
	Иначе		
		ПоказатьПредупреждение(,НСтр("ru = 'Данная возможность недоступна, так как не подключено расширение работы с файлами.'", "ru"));
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКартинкуИзФайлаЗавершение(Результат, Адрес, ВыбранноеИмя, ДополнительныеПараметры) Экспорт
    
    Если Результат Тогда
        ПоместитьФайлОбъекта(Адрес);
        Элементы.АдресКартинки.Обновить();			
		ОбновитьИзображение();
    КонецЕсли;

КонецПроцедуры

#КонецОбласти