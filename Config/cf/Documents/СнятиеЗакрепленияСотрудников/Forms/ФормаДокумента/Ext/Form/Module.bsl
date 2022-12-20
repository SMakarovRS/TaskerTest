﻿
#Область ОписаниеПеременных

// СтандартныеПодсистемы.ОценкаПроизводительности
&НаКлиенте
Перем ИдентификаторЗамераПроведение;
// Конец СтандартныеПодсистемы.ОценкаПроизводительности

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	СЛС.ПриСозданииНаСервере(Объект, Отказ, СтандартнаяОбработка, Параметры, ЭтаФорма);		
	
	Если Объект.Ссылка.Пустая() Тогда
		
		// Если открыта из другой
	    ОткрываетсяИзВне = Ложь;
	    Если Параметры.Свойство("ОткрываетсяИзВне") Тогда
	        ОткрываетсяИзВне = Параметры.ОткрываетсяИзВне;
			Если ОткрываетсяИзВне Тогда
				Попытка
					Структура = ПолучитьИзВременногоХранилища(Параметры["Объект"]);
		        	ЗначениеВРеквизитФормы(Структура.Документ, "Объект");
	            	Модифицированность = Истина;
					УдалитьИзВременногоХранилища(Параметры["Объект"]);
				Исключение
				КонецПопытки;	
		    КонецЕсли;
		КонецЕсли;
		
		// Документ создается из обработки "РабочийСтол".
		Если Параметры.Свойство("РабочийСтолЗначенияЗаполнения") Тогда
			ЗаполнитьЗначенияСвойств(Объект, Параметры.РабочийСтолЗначенияЗаполнения);
		КонецЕсли;
		
	КонецЕсли;
	
	// Установка реквизитов формы.
	ДатаДокумента = Объект.Дата;
	Если НЕ ЗначениеЗаполнено(ДатаДокумента) Тогда
		ДатаДокумента = ТекущаяДатаСеанса();
	КонецЕсли;
	
	#Область БСП_ПриСозданииНаСервере

	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "СтраницаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды	

	// ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ВерсионированиеОбъектов	
	
	#КонецОбласти
	
	ТекущийЭлемент = Элементы.Сотрудники;
	
	// Учет остатков контрагентов.
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("Организация");
	УправлениеITОтделом8УФ.УстановитьОграничениеТипаДляЭлементовФормы(ЭтаФорма, МассивЭлементов); 
	
	УстановитьВидимостьИДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// Корректировки документа
	УправлениеITОтделом8УФКлиент.ОбновитьНадписьАвтор(Объект, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ОценкаПроизводительности
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
       ИдентификаторЗамераПроведение = ОценкаПроизводительностиКлиент.ЗамерВремени();
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ОценкаПроизводительности
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	МассивМестХранения = Новый Массив;
	Для Каждого Строки Из Объект.Сотрудники Цикл
		МассивМестХранения.Добавить(Строки.МестоХранения);
	КонецЦикла;
	Оповестить("Запись_СнятиеЗакрепленияСотрудников",
		Новый Структура("МассивМестХранения", МассивМестХранения), Объект.Ссылка);
	
	// Корректировки документа
	УправлениеITОтделом8УФКлиент.ОбновитьНадписьАвтор(Объект, ЭтаФорма);
	
	// СтандартныеПодсистемы.ОценкаПроизводительности
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
        ОценкаПроизводительностиКлиент.УстановитьКлючевуюОперациюЗамера(ИдентификаторЗамераПроведение, 
			"ДокументСнятиеЗакрепленияСотрудников (проведение)");	
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ОценкаПроизводительности
	
КонецПроцедуры

// Процедура - обработчик события ПриЧтенииНаСервере.
//
&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	СЛС.ПриЧтенииНаСервере(ТекущийОбъект, ЭтаФорма);
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды	
	
	// СтандартныеПодсистемы.УправлениеДоступом
    УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
    // Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры // ПриЧтенииНаСервере()

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ТекущийОбъект.ДатаСоздания = Дата(1, 1, 1) Тогда
		ТекущийОбъект.ДатаСоздания = ТекущаяДатаСеанса();
	Иначе
		ТекущийОбъект.ДатаКорректировки = ТекущаяДатаСеанса();
	КонецЕсли; 
	
	Если ТекущийОбъект.Автор = Справочники.Пользователи.ПустаяСсылка() Тогда
		ТекущийОбъект.Автор = Пользователи.ТекущийПользователь();
	Иначе
		ТекущийОбъект.АвторКорректировки = Пользователи.ТекущийПользователь();
	КонецЕсли; 
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	СЛС.ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи, ЭтаФорма);
	
	// Обработчик подсистемы запрета редактирования реквизитов объектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
		
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)

	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ТипЗнч(ИсточникВыбора) = Тип("УправляемаяФорма") 
		И ИсточникВыбора.ИмяФормы = "ОбщаяФорма.ФормаВыбораОрганизацииКонтрагента"
		И ИсточникВыбора.ВладелецФормы = ЭтаФорма Тогда
		УправлениеITОтделом8УФКлиент.ВыполнитьОбработчикОбработкаВыбораФормы(ЭтаФорма, 
		 				"Организация",
						Объект.Организация,
						ВыбранноеЗначение,
						Новый ОписаниеОповещения("ПослеОбработкиВыбора", ЭтотОбъект));	
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
// Процедура - обработчик события ПриИзменении поля ввода Дата.
// В процедуре определяется ситуация, когда при изменении своей даты документ 
// оказывается в другом периоде нумерации документов, и в этом случае
// присваивает документу новый уникальный номер.
// Переопределяет соответствующий параметр формы.
//
Процедура ДатаПриИзменении(Элемент)
	
	// Обработка события изменения даты.
	ДатаПередИзменением = ДатаДокумента;
	ДатаДокумента = Объект.Дата;
	Если Объект.Дата <> ДатаПередИзменением Тогда
		СтруктураДанные = ПолучитьДанныеДатаПриИзменении(Объект.Ссылка, Объект.Дата, ДатаПередИзменением);
		Если СтруктураДанные.РазностьДат <> 0 Тогда
			Объект.Номер = "";
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры // ДатаПриИзменении()

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	// Обработка события изменения организации.
	Объект.Номер = "";
	
	УстановитьВидимостьИДоступность();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура СотрудникиМестоХраненияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Массив = УправлениеITОтделом8УФ.ПолучитьМассивМестХраненияСотрудника(?(Объект.Ссылка.Пустая(), КонецДня(УправлениеITОтделом8УФ.ТекущаяДатаСистемная()), Объект.Дата), Элементы.Сотрудники.ТекущиеДанные.Сотрудник);
	Элементы.СотрудникиМестоХранения.СписокВыбора.Очистить();
	Элементы.СотрудникиМестоХранения.СписокВыбора.ЗагрузитьЗначения(Массив);	
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиСотрудникПриИзменении(Элемент)
	
	Если Элементы.Сотрудники.ТекущиеДанные <> Неопределено Тогда
		Если НЕ ЗначениеЗаполнено(Элементы.Сотрудники.ТекущиеДанные.Сотрудник) Тогда
			Элементы.Сотрудники.ТекущиеДанные.МестоХранения = ПредопределенноеЗначение("Справочник.МестаХранения.ПустаяСсылка");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиСотрудникНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Объект.Организация) = Тип("СправочникСсылка.Организации") Тогда 
		МассивСотрудник	= Новый Массив();
		МассивСотрудник.Добавить(Тип("СправочникСсылка.Сотрудники"));
		ДопустимыеТипы = Новый ОписаниеТипов(МассивСотрудник, , );
		Элементы.СотрудникиСотрудник.ОграничениеТипа = ДопустимыеТипы;
	ИначеЕсли ТипЗнч(Объект.Организация) = Тип("СправочникСсылка.Контрагенты") Тогда 
		СтандартнаяОбработка = Ложь;
		МассивСотрудник	= Новый Массив();
		МассивСотрудник.Добавить(Тип("СправочникСсылка.КонтактныеЛица"));
		ДопустимыеТипы = Новый ОписаниеТипов(МассивСотрудник, , );
		Элементы.СотрудникиСотрудник.ОграничениеТипа = ДопустимыеТипы;
		ОткрытьФормуВыбораКонтактныеЛица("Сотрудник");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НадписьАвторНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Спк = УправлениеITОтделом8УФКлиент.ПолучитьСписокНадписьАвтор(Объект);	
	ПоказатьВыборИзСписка(Новый ОписаниеОповещения("НадписьАвторНажатиеЗавершение", ЭтотОбъект), Спк, Элементы.НадписьАвтор, );
КонецПроцедуры

&НаКлиенте
Процедура НадписьАвторНажатиеЗавершение(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт    

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоСотруднику(Команда)
	
	Значение = ПредопределенноеЗначение("Справочник.Сотрудники.ПустаяСсылка");
	ПоказатьВводЗначения(Новый ОписаниеОповещения("ЗаполнитьПоСотрудникуЗавершение", ЭтотОбъект, Новый Структура("Значение", Значение)), Значение, НСтр("ru = 'Выберите сотрудника'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоСотрудникуЗавершение(Значение, ДополнительныеПараметры) Экспорт
    
    Значение = ?(Значение = Неопределено, ДополнительныеПараметры.Значение, Значение);
    
    Если (Значение <> Неопределено) Тогда
        ОчищатьТЧ = Ложь;
        Если Объект.Сотрудники.Количество() > 0 Тогда
            Текст = НСтр("ru = 'Табличная часть ""Сотрудники"" не пуста, очистить?'");
            Ответ = Неопределено;

            ПоказатьВопрос(Новый ОписаниеОповещения("ЗаполнитьПоСотрудникуЗавершениеЗавершение", ЭтотОбъект, Новый Структура("Значение", Значение)), Текст, РежимДиалогаВопрос.ДаНет, 0);
            Возврат;
        КонецЕсли;
        ЗаполнитьПоСотрудникуЗавершениеФрагмент(Значение, ОчищатьТЧ);

    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоСотрудникуЗавершениеЗавершение(РезультатВопроса, ДополнительныеПараметры1) Экспорт
    
    Значение = ДополнительныеПараметры1.Значение;
    
    
    Ответ = РезультатВопроса;
    Если Ответ = КодВозвратаДиалога.Да Тогда
        ОчищатьТЧ = Истина;
    КонецЕсли;
    
    ЗаполнитьПоСотрудникуЗавершениеФрагмент(Значение, ОчищатьТЧ);

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоСотрудникуЗавершениеФрагмент(Знач Значение, Знач ОчищатьТЧ)
    
    ЗаполнитьМестаХраненияСотрудника(Объект.Дата, Значение, ОчищатьТЧ)

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область БСП

// Процедура устанавливает видимость элементов формы.
//
// Параметры:
//  Нет.
//
&НаСервере
Процедура УстановитьВидимостьИДоступность()
	
	Если ТипЗнч(Объект.Организация) = Тип("СправочникСсылка.Организации") Тогда 
		Элементы.СотрудникиСотрудник.Заголовок = НСтр("ru = 'Сотрудник'");
	ИначеЕсли ТипЗнч(Объект.Организация) = Тип("СправочникСсылка.Контрагенты") Тогда 
		Элементы.СотрудникиСотрудник.Заголовок = НСтр("ru = 'Контактное лицо'");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуВыбораКонтактныеЛица(Знач ПолеРаботы)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("УчетОстатков", Истина);
	ПараметрыФормы.Вставить("ОтборКонтрагент", Объект.Организация);
		
	ПараметрыПоля = Новый Структура;
	ПараметрыПоля.Вставить("ИмяПоля", ПолеРаботы);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВыбораСотрудники", ЭтотОбъект, ПараметрыПоля); 
	ОткрытьФорму("Справочник.КонтактныеЛица.ФормаВыбора",ПараметрыФормы,ЭтотОбъект, , , ,
													ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);   
	
КонецПроцедуры
												
&НаКлиенте
Процедура ПослеВыбораСотрудники(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		 ТекущиеДанные[ДополнительныеПараметры.ИмяПоля] = Результат;
	КонецЕсли;	
	
КонецПроцедуры

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
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
    УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

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

#КонецОбласти

&НаСервереБезКонтекста
// Получает набор данных с сервера для процедуры ДатаПриИзменении.
//
Функция ПолучитьДанныеДатаПриИзменении(ДокументСсылка, ДатаНовая, ДатаПередИзменением)
	
	СтруктураДанные = Новый Структура();
	СтруктураДанные.Вставить("РазностьДат", УправлениеITОтделом8УФ.ПроверитьНомерДокумента(ДокументСсылка, ДатаНовая, ДатаПередИзменением));
	
	Возврат СтруктураДанные;
	
КонецФункции // ПолучитьДанныеДатаПриИзменении()

&НаСервере
Функция СписокМестХраненияСотрудника(ДатаАктуальности, Сотрудник)
	
	Запрос = Новый Запрос();
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ОтветственныеСотрудникиСрезПоследних.МестоХранения КАК МестоХранения
		|ИЗ
		|	РегистрСведений.ОтветственныеСотрудники.СрезПоследних(&ДатаАктуальности, Сотрудник = &Сотрудник) КАК ОтветственныеСотрудникиСрезПоследних
		|
		|УПОРЯДОЧИТЬ ПО
		|	МестоХранения
		|АВТОУПОРЯДОЧИВАНИЕ";
	
	Запрос.УстановитьПараметр("ДатаАктуальности", ДатаАктуальности);
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	Результат = Новый СписокЗначений;
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Результат.Добавить(Выборка.МестоХранения);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

&НаСервере
Функция ЗначениеНаСервере(Стр)
	Возврат Вычислить(Стр);
КонецФункции

&НаСервере
Процедура ЗаполнитьМестаХраненияСотрудника(ДатаАктуальности, Сотрудник, ОчищатьТЧ)
	
	Если ОчищатьТЧ Тогда
		Объект.Сотрудники.Очистить();
	КонецЕсли;
	
	Запрос = Новый Запрос();
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ОтветственныеСотрудникиСрезПоследних.МестоХранения,
		|	ОтветственныеСотрудникиСрезПоследних.Сотрудник
		|ИЗ
		|	РегистрСведений.ОтветственныеСотрудники.СрезПоследних(&ДатаАктуальности, Сотрудник = &Сотрудник) КАК ОтветственныеСотрудникиСрезПоследних";
	
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	Запрос.УстановитьПараметр("ДатаАктуальности", ДатаАктуальности);
		
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.Сотрудники.Добавить(), Выборка);
	КонецЦикла;
КонецПроцедуры

#Область УчетОстатковКонтрагентов

&НаКлиенте
Процедура Подключаемый_НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
			
	УправлениеITОтделом8УФКлиент.ВыполнитьОбработчикНачалоВыбора(ЭтаФорма, Объект.Организация, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_АвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
		
	УправлениеITОтделом8УФКлиент.ВыполнитьОбработчикАвтоПодбор(ЭтаФорма, 
				"Организация",
				Текст, 
				ДанныеВыбора,
				Ожидание,
				СтандартнаяОбработка);
				
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_Очистка(Элемент, СтандартнаяОбработка)	
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)	
		
	УправлениеITОтделом8УФКлиент.ВыполнитьОбработчикОбработкаВыбора(ЭтаФорма, 
				"Организация", 
				Объект.Организация,
				Новый ОписаниеОповещения("ПослеОбработкиВыбора", ЭтотОбъект),
				ВыбранноеЗначение,
				СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОбработкиВыбора(Результат, ДополнительныеПараметры) Экспорт
	
	ОрганизацияПриИзменении(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

