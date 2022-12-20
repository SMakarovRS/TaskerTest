﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("МножественныйВыбор") Тогда
		МножественныйВыбор = Параметры.МножественныйВыбор;
		Элементы.ДеревоИспользование.Видимость = Ложь;
	КонецЕсли;
	
	Если Параметры.Свойство("ТолькоСсылочныеТипы") Тогда
		ТолькоСсылочныеТипы = Параметры.ТолькоСсылочныеТипы;
	КонецЕсли;
	
	Если Параметры.Свойство("ВыбиратьРеквизитыИТабличныеЧасти") Тогда
		ВыбиратьРеквизитыИТабличныеЧасти = Параметры.ВыбиратьРеквизитыИТабличныеЧасти;
	КонецЕсли;
	
	Если Параметры.Свойство("ТолькоДокументы") Тогда
		ТолькоДокументы = Параметры.ТолькоДокументы;
	КонецЕсли;
	
	ВыполнитьНачальноеЗаполнение();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДерево

&НаКлиенте
Процедура ДеревоИспользованиеПриИзменении(Элемент)
	
	ТекущиеДанные = ТекущийЭлемент.ТекущиеДанные;
	Если ТекущиеДанные.Использование = 2 Тогда
		ТекущиеДанные.Использование = 0;
	КонецЕсли;
	ПометитьВложенныеЭлементы(ТекущиеДанные);
	ПометитьЭлементыРодителей(ТекущиеДанные.ПолучитьРодителя());

КонецПроцедуры

&НаКлиенте
Процедура ДеревоВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Дерево.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.ЭтоОбъект Тогда
		Закрыть(ТекущиеДанные.ПолноеИмя);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура рекурсивно устанавливает/снимает пометку для вложенных элементов начиная
// с передаваемого элемента.
//
// Параметры:
// Элемент      - ДанныеФормыКоллекцияЭлементовДерева 
//
&НаКлиенте
Процедура ПометитьВложенныеЭлементы(Элемент)

	ВложенныеЭлементы = Элемент.ПолучитьЭлементы();
	
	Если ВложенныеЭлементы.Количество() = 0 Тогда
		Если НЕ Элемент.ПолучитьРодителя() <> Неопределено Тогда
			Элемент.Использование = 0;
		КонецЕсли;		
	Иначе
		Для Каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
			ВложенныйЭлемент.Использование = Элемент.Использование;
			ПометитьВложенныеЭлементы(ВложенныйЭлемент);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПометитьВложенныеЭлементыСервер(Элемент)

	ВложенныеЭлементы = Элемент.Строки;
	
	Если ВложенныеЭлементы.Количество() = 0 Тогда
		Если НЕ Элемент.Родитель <> Неопределено Тогда
			Элемент.Использование = 0;
		КонецЕсли;		
	Иначе
		Для Каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
			ВложенныйЭлемент.Использование = Элемент.Использование;
			ПометитьВложенныеЭлементыСервер(ВложенныйЭлемент);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// Процедура рекурсивно устанавливает/снимает пометку для родителей передаваемого элемента.
//
// Параметры:
// Элемент      - ДанныеФормыКоллекцияЭлементовДерева 
//
&НаКлиенте
Процедура ПометитьЭлементыРодителей(СтрокаРодитель)

	Если СтрокаРодитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Использование = СтрокаРодитель.Использование;
	
	Если СтрокаРодитель.ПолучитьЭлементы().Количество() > 0 Тогда
		НайденыВключенные  = Ложь;
		НайденыВыключенные = Ложь;
		Для Каждого Строка Из СтрокаРодитель.ПолучитьЭлементы() Цикл
			Если Строка.Использование = 0 Тогда
				НайденыВыключенные = Истина;
			ИначеЕсли Строка.Использование = 1 Тогда
				НайденыВключенные  = Истина;
			ИначеЕсли Строка.Использование = 2 Тогда
				НайденыВыключенные = Истина;
				НайденыВключенные  = Истина;
			КонецЕсли;
			
			Если НайденыВключенные И НайденыВыключенные Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		Если НайденыВключенные И НЕ НайденыВыключенные Тогда
			Использование = 1;
		ИначеЕсли НЕ НайденыВключенные И НайденыВыключенные Тогда
			Использование = 0;
		Иначе
			Использование = 2;
		КонецЕсли;
	КонецЕсли; 
	
	СтрокаРодитель.Использование = Использование;
	
	ПометитьЭлементыРодителей(СтрокаРодитель.ПолучитьРодителя());

КонецПроцедуры

&НаСервере
Процедура ПометитьЭлементыРодителейСервер(СтрокаРодитель)

	Если СтрокаРодитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Использование = СтрокаРодитель.Использование;
	
	Если СтрокаРодитель.Строки.Количество() > 0 Тогда
		НайденыВключенные  = Ложь;
		НайденыВыключенные = Ложь;
		Для Каждого Строка Из СтрокаРодитель.Строки Цикл
			Если Строка.Использование = 0 Тогда
				НайденыВыключенные = Истина;
			ИначеЕсли Строка.Использование = 1 Тогда
				НайденыВключенные  = Истина;
			ИначеЕсли Строка.Использование = 2 Тогда
				НайденыВыключенные = Истина;
				НайденыВключенные  = Истина;
			КонецЕсли;
			
			Если НайденыВключенные И НайденыВыключенные Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		Если НайденыВключенные И НЕ НайденыВыключенные Тогда
			Использование = 1;
		ИначеЕсли НЕ НайденыВключенные И НайденыВыключенные Тогда
			Использование = 0;
		Иначе
			Использование = 2;
		КонецЕсли;
	КонецЕсли; 

	СтрокаРодитель.Использование = Использование;
	ПометитьЭлементыРодителейСервер(СтрокаРодитель.Родитель);

КонецПроцедуры

&НаСервере
Процедура ВыполнитьНачальноеЗаполнение()
	
	Дерево = РеквизитФормыВЗначение("Мета", Тип("ДеревоЗначений"));
	
	Если ТолькоСсылочныеТипы = Ложь Тогда
		ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.Константы, 			"Константы", 				"Константа", 				2, Ложь);
	КонецЕсли;
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.Справочники, 				"Справочники", 				"Справочник", 				3, Ложь);
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.Документы, 				"Документы", 				"Документ", 				4, Ложь);
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.Перечисления, 				"Перечисления", 			"Перечисление", 			0, Ложь);
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.ПланыВидовХарактеристик, 	"Планы видов характеристик","ПланВидовХарактеристик", 	5, Ложь);
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.ПланыСчетов, 				"Планы счетов", 			"ПланСчетов", 				6, Ложь);
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.ПланыВидовРасчета, 		"Планы видов расчета", 		"ПланВидовРасчета", 		7, Ложь);
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.ПланыОбмена, 				"Планы обмена", 			"ПланОбмена", 				8, Ложь);	
	Если ТолькоСсылочныеТипы = Ложь Тогда
		ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.РегистрыСведений,		"Регистры сведений", 		"РегистрСведений", 			11, Ложь);
	КонецЕсли;		
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.БизнесПроцессы, 			"Бизнесс-процессы", 		"БизнесПроцесс", 			10, Ложь);
	ДобавитьРегистрируемыеОбъекты(Дерево, Метаданные.Задачи, 					"Задачи", 					"Задача", 					9, Ложь);	
	
	УстановитьВсеФлагиРегистрируемыхОбъектов(Дерево, Ложь);	
	
	ЗначениеВРеквизитФормы(Дерево, "Мета");
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УстановитьВсеФлагиРегистрируемыхОбъектов(СтрокиРегистрируемыеОбъекты, Флаг)
	
	Для Каждого Стр Из СтрокиРегистрируемыеОбъекты.Строки Цикл
		Стр.Использование = Флаг;                   
		УстановитьВсеФлагиРегистрируемыхОбъектов(Стр, Флаг);
	КонецЦикла;
	
КонецПроцедуры // УстановитьВсеФлагиРегистрируемыхОбъектов

&НаСервереБезКонтекста
Процедура ПолучитьСтрокуРегистрируемогоОбъекта(СтрокиРегистрируемыеОбъекты, СтрокаРегОбъекта, Результат)
	
	Если Результат <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	Для Каждого Стр Из СтрокиРегистрируемыеОбъекты.Строки Цикл
		Если ВРег(Стр.Имя) = ВРег(СтрокаРегОбъекта) Тогда
			Результат = Стр;
			Прервать;
		КонецЕсли;
		
		ПолучитьСтрокуРегистрируемогоОбъекта(Стр, СтрокаРегОбъекта, Результат);
	КонецЦикла;
	
КонецПроцедуры // ПолучитьСтрокуРегистрируемогоОбъекта
	
&НаСервере
// Добавляет в объект все его реквизиты, ТЧ и предопределенные реквизиты и ТЧ.
Процедура ДобавитьРегистрируемыеОбъекты(Объекты, МетаданныеОбъекты, Представление, Имя, ИндексКартинки, ЗаполнятьРеквизитыИТЧ = Истина) Экспорт
	
	Массив						= Новый Массив;
	
	НоваяСтрока					= Объекты.Строки.Добавить();
	НоваяСтрока.Представление	= Представление;
	НоваяСтрока.Имя				= "";
	НоваяСтрока.ИндексКартинки	= ИндексКартинки;
	НоваяСтрока.СодержитЭлементы = Истина;
	НоваяСтрока.ЭтоОбъект		= Ложь;
	
	Для Каждого ОбъектМетаданных Из МетаданныеОбъекты Цикл
		
		ПолноеИмя				= ОбъектМетаданных.ПолноеИмя();
		
		// Пропуск метаданных журнала регистрации.
		Если Массив.Найти(ПолноеИмя) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ТипОбъекта				= ПолучитьТипОбъектаПоИмени(ПолноеИмя);
		ЭлементИмя				= ОбъектМетаданных.Имя;              
		СубСтрока				= НоваяСтрока.Строки.Добавить();
		СубСтрока.Представление = ?(ПустаяСтрока(ОбъектМетаданных.Синоним), ЭлементИмя, ОбъектМетаданных.Синоним);
		СубСтрока.Имя			= "";
		СубСтрока.ИмяТЧ			= "";
		СубСтрока.ИндексКартинки= ИндексКартинки;
		СубСтрока.ПолноеИмя		= ПолноеИмя;
		СубСтрока.СодержитЭлементы = Истина;
		СубСтрока.ЭтоОбъект		= Истина;
		Попытка
			СубСтрока.ТипЭлемента = ОбъектМетаданных.Тип;
		Исключение
		КонецПопытки;
		
		Если НЕ ЗаполнятьРеквизитыИТЧ Тогда
			Продолжить;
		КонецЕсли;
		
		// Стандартные реквизиты.		
		Реквизиты = ПолучитьРеквизитыОбъекта(ОбъектМетаданных, ТипОбъекта);
		Для Каждого Реквизит Из Реквизиты Цикл
			
			СтрокаРеквизита					= СубСтрока.Строки.Добавить();
			СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Представление), Реквизит.Значение, Реквизит.Представление);
			СтрокаРеквизита.Имя				= Реквизит.Значение;
			СтрокаРеквизита.ИмяТЧ			= "";
			СтрокаРеквизита.ИндексКартинки	= 0;
			СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
			СтрокаРеквизита.СодержитЭлементы = Ложь;
			СтрокаРеквизита.ЭтоОбъект		= Ложь;
			Попытка				
				СтрокаРеквизита.ТипЭлемента	= ОбъектМетаданных.СтандартныеРеквизиты[Реквизит.Значение].Тип;
			Исключение
			КонецПопытки;
			Попытка				
				СтрокаРеквизита.ТипЭлемента	= ОбъектМетаданных.Реквизиты[Реквизит.Значение].Тип;
			Исключение
			КонецПопытки;
			
		КонецЦикла;
		
		// Таб части (не константы, не регистры сведений).
		Если ТипОбъекта <> 4 И ТипОбъекта <> 10 Тогда
			
			Если ТипОбъекта = 5 Тогда
				
				Для Каждого ТЧ Из ОбъектМетаданных.СтандартныеТабличныеЧасти Цикл
					СтрокаТЧ				= СубСтрока.Строки.Добавить();
					СтрокаТЧ.Представление	= ?(ПустаяСтрока(ТЧ.Синоним), ТЧ.Имя, ТЧ.Синоним);
					СтрокаТЧ.Имя			= "";
					СтрокаТЧ.ИмяТЧ			= ТЧ.Имя;
					СтрокаТЧ.ИндексКартинки	= 1;
					СтрокаТЧ.ПолноеИмя		= ПолноеИмя;
					СтрокаТЧ.СодержитЭлементы = Истина;
					СтрокаТЧ.ЭтоОбъект		= Ложь;
					Попытка
						СтрокаТЧ.ТипЭлемента	= ТЧ.Тип;
					Исключение
					КонецПопытки;
					
					Для Каждого Реквизит Из ТЧ.СтандартныеРеквизиты Цикл
						
						Если Реквизит.Имя = "НомерСтроки" Тогда
							Продолжить;
						КонецЕсли;
						
						СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
						СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
						СтрокаРеквизита.Имя				= Реквизит.Имя;
						СтрокаРеквизита.ИмяТЧ			= ТЧ.Имя;
						СтрокаРеквизита.ИндексКартинки	= 0;
						СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
						СтрокаРеквизита.СодержитЭлементы = Ложь;
						СтрокаРеквизита.ЭтоОбъект		= Ложь;
						Попытка
							СтрокаРеквизита.ТипЭлемента		= Реквизит.Тип;
						Исключение
						КонецПопытки;
						
					КонецЦикла;
					
					Если ТЧ.Имя = "ВидыСубконто" Тогда
						
						Для Каждого Реквизит Из ОбъектМетаданных.ПризнакиУчетаСубконто Цикл
							
							Если Реквизит.Имя = "НомерСтроки" ИЛИ Реквизит.Имя = "Предопределенный" Тогда
								Продолжить;
							КонецЕсли;
							
							СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
							СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
							СтрокаРеквизита.Имя				= Реквизит.Имя;
							СтрокаРеквизита.ИмяТЧ			= ТЧ.Имя;
							СтрокаРеквизита.ИндексКартинки	= 0;
							СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
							СтрокаРеквизита.СодержитЭлементы = Ложь;
							СтрокаРеквизита.ЭтоОбъект		= Ложь;
							Попытка
								СтрокаРеквизита.ТипЭлемента		= Реквизит.Тип;
							Исключение
							КонецПопытки;
							
						КонецЦикла;
						
						
					КонецЕсли;
					
				КонецЦикла;
				
			ИначеЕсли ТипОбъекта = 6 Тогда
				// План видов расчета
				// БазовыеВидыРасчета
				
				Для Каждого ТЧ Из ОбъектМетаданных.СтандартныеТабличныеЧасти Цикл
					СтрокаТЧ				= СубСтрока.Строки.Добавить();
					СтрокаТЧ.Представление	= ?(ПустаяСтрока(ТЧ.Синоним), ТЧ.Имя, ТЧ.Синоним);
					СтрокаТЧ.Имя			= "";
					СтрокаТЧ.ИмяТЧ			= ТЧ.Имя;
					СтрокаТЧ.ИндексКартинки	= 1;
					СтрокаТЧ.ПолноеИмя		= ПолноеИмя;
					СтрокаТЧ.СодержитЭлементы = Истина;
					СтрокаТЧ.ЭтоОбъект		= Ложь;
					Попытка
						СтрокаТЧ.ТипЭлемента= ТЧ.Тип;
					Исключение
					КонецПопытки;
					
					Для Каждого Реквизит Из ТЧ.СтандартныеРеквизиты Цикл
						
						Если Реквизит.Имя = "НомерСтроки" ИЛИ Реквизит.Имя = "Предопределенный" Тогда
							Продолжить;
						КонецЕсли;
						
						СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
						СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
						СтрокаРеквизита.Имя				= Реквизит.Имя;
						СтрокаРеквизита.ИмяТЧ			= ТЧ.Имя;
						СтрокаРеквизита.ИндексКартинки	= 0;
						СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
						СтрокаРеквизита.СодержитЭлементы = Ложь;
						СтрокаРеквизита.ЭтоОбъект		= Ложь;
						Попытка
							СтрокаРеквизита.ТипЭлемента		= Реквизит.Тип;
						Исключение
						КонецПопытки;
						
					КонецЦикла;
					
				КонецЦикла;
				
			КонецЕсли;
			
			Для Каждого ТЧ Из ОбъектМетаданных.ТабличныеЧасти Цикл
				
				СтрокаТЧ				= СубСтрока.Строки.Добавить();
				СтрокаТЧ.Представление	= ?(ПустаяСтрока(ТЧ.Синоним), ТЧ.Имя, ТЧ.Синоним);
				СтрокаТЧ.Имя			= "";
				СтрокаТЧ.ИмяТЧ			= ТЧ.Имя;
				СтрокаТЧ.ИндексКартинки	= 1;
				СтрокаТЧ.ПолноеИмя		= ПолноеИмя;
				СтрокаТЧ.СодержитЭлементы = Истина;
				СтрокаТЧ.ЭтоОбъект		= Ложь;
				Попытка
					СтрокаТЧ.ТипЭлемента= ТЧ.Тип;
				Исключение
				КонецПопытки;
				
				// Реквизиты ТЧ
				Для Каждого Реквизит Из ТЧ["Реквизиты"] Цикл
					
					СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
					СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
					СтрокаРеквизита.Имя				= Реквизит.Имя;
					СтрокаРеквизита.ИмяТЧ			= ТЧ.Имя;
					СтрокаРеквизита.ИндексКартинки	= 0;
					СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
					СтрокаРеквизита.СодержитЭлементы = Ложь;
					СтрокаРеквизита.ЭтоОбъект		= Ложь;
					Попытка
						СтрокаРеквизита.ТипЭлемента	= Реквизит.Тип;
					Исключение
					КонецПопытки;
					
				КонецЦикла;				
				
			КонецЦикла;
			
			СубСтрока.Строки.Сортировать("ИмяТЧ,Имя", Истина);
			
		КонецЕсли;
		
		// Регисты сведений.
		Если ТипОбъекта = 10 Тогда
			
			СтрокаТЧ				= СубСтрока.Строки.Добавить();
			СтрокаТЧ.Представление	= "Записи";
			СтрокаТЧ.Имя			= "";
			СтрокаТЧ.ИмяТЧ			= "Записи";
			СтрокаТЧ.ИндексКартинки	= 1;
			СтрокаТЧ.ПолноеИмя		= ПолноеИмя;
			СтрокаТЧ.СодержитЭлементы = Истина;
			СтрокаТЧ.ЭтоОбъект		= Истина;
			
			Для Каждого Реквизит Из ОбъектМетаданных.СтандартныеРеквизиты Цикл
				СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
				СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
				СтрокаРеквизита.Имя				= Реквизит.Имя;
				СтрокаРеквизита.ИмяТЧ			= СтрокаТЧ.ИмяТЧ;
				СтрокаРеквизита.ИндексКартинки	= 0;
				СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
				СтрокаРеквизита.СодержитЭлементы = Ложь;
				СтрокаРеквизита.ЭтоОбъект		= Ложь;
				Попытка
					СтрокаРеквизита.ТипЭлемента	= Реквизит.Тип;
				Исключение
				КонецПопытки;
			КонецЦикла;
			Для Каждого Реквизит Из ОбъектМетаданных.Измерения Цикл
				СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
				СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
				СтрокаРеквизита.Имя				= Реквизит.Имя;
				СтрокаРеквизита.ИмяТЧ			= СтрокаТЧ.ИмяТЧ;
				СтрокаРеквизита.ИндексКартинки	= 12;
				СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
				СтрокаРеквизита.СодержитЭлементы = Ложь;
				СтрокаРеквизита.ЭтоОбъект		= Ложь;
				Попытка
					СтрокаРеквизита.ТипЭлемента	= Реквизит.Тип;
				Исключение
				КонецПопытки;
			КонецЦикла;
			Для Каждого Реквизит Из ОбъектМетаданных.Ресурсы Цикл
				СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
				СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
				СтрокаРеквизита.Имя				= Реквизит.Имя;
				СтрокаРеквизита.ИмяТЧ			= СтрокаТЧ.ИмяТЧ;
				СтрокаРеквизита.ИндексКартинки	= 13;
				СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
				СтрокаРеквизита.СодержитЭлементы = Ложь;
				СтрокаРеквизита.ЭтоОбъект		= Ложь;
				Попытка
					СтрокаРеквизита.ТипЭлемента	= Реквизит.Тип;
				Исключение
				КонецПопытки;
			КонецЦикла;				
			Для Каждого Реквизит Из ОбъектМетаданных.Реквизиты Цикл
				СтрокаРеквизита					= СтрокаТЧ.Строки.Добавить();
				СтрокаРеквизита.Представление	= ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним);
				СтрокаРеквизита.Имя				= Реквизит.Имя;
				СтрокаРеквизита.ИмяТЧ			= СтрокаТЧ.ИмяТЧ;
				СтрокаРеквизита.ИндексКартинки	= 0;
				СтрокаРеквизита.ПолноеИмя		= ПолноеИмя;
				СтрокаРеквизита.СодержитЭлементы = Ложь;
				СтрокаРеквизита.ЭтоОбъект		= Ложь;
				Попытка
					СтрокаРеквизита.ТипЭлемента	= Реквизит.Тип;
				Исключение
				КонецПопытки;
			КонецЦикла;			
		КонецЕсли;
		
	КонецЦикла;
	
	// Отсортируем по представлению только по метаданным, либо удалим, если ветка метаданных пуста.
	Если НоваяСтрока.Строки.Количество() = 0 Тогда
		Объекты.Строки.Удалить(НоваяСтрока);
	Иначе
		НоваяСтрока.Строки.Сортировать("Представление", Ложь);
	КонецЕсли;
	
КонецПроцедуры // ДобавитьРегистрируемыеОбъекты

&НаСервере
// Получить тип объекта по полному имени метаданных.
Функция ПолучитьТипОбъектаПоИмени(Знач ОбъектИмяМетаданных) Экспорт
	
	ПолноеИмя = ОбъектИмяМетаданных;
	ПозицияТочки = Найти(ПолноеИмя, ".");
	Если ПозицияТочки = 0 Тогда
		Возврат 0;
	КонецЕсли;
	ТипСтрокой = Лев(ПолноеИмя, ПозицияТочки - 1);
	Если ТипСтрокой = "Документ" Тогда
		Возврат 1;
	ИначеЕсли ТипСтрокой = "Справочник" Тогда
		Возврат 2;
	ИначеЕсли ТипСтрокой = "ПланВидовХарактеристик" Тогда
		Возврат 3;
	ИначеЕсли ТипСтрокой = "Константа" Тогда
		Возврат 4;
	ИначеЕсли ТипСтрокой = "ПланСчетов" Тогда
		Возврат 5;
	ИначеЕсли ТипСтрокой = "ПланВидовРасчета" Тогда
		Возврат 6;
	ИначеЕсли ТипСтрокой = "ПланОбмена" Тогда
		Возврат 7;
	ИначеЕсли ТипСтрокой = "Задача" Тогда
		Возврат 8;
	ИначеЕсли ТипСтрокой = "БизнесПроцесс" Тогда
		Возврат 9;
	ИначеЕсли ТипСтрокой = "РегистрСведений" Тогда
		Возврат 10;
	Иначе
		Возврат 0;
	КонецЕсли;        
	
КонецФункции // ПолучитьТипОбъектаПоИмени

&НаСервере
// Получает все реквизиты объекта.
Функция ПолучитьРеквизитыОбъекта(ОбъектМетаданных, ТипОбъекта, Объект = Неопределено) Экспорт
	
	// Стандартные реквизиты.
	Результат = ПолучитьСтандартныеРеквизитыОбъекта(ОбъектМетаданных, ТипОбъекта);
	
	// Задачи реквизиты адресации.
	Если ТипОбъекта = 8 Тогда		
		Для Каждого Реквизит Из ОбъектМетаданных.РеквизитыАдресации Цикл
			Результат.Добавить(Реквизит.Имя, ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним));
		КонецЦикла;
	КонецЕсли;	
	
	// Остальные реквизиты.
	Если ТипОбъекта <> 4 И ТипОбъекта <> 10 Тогда
		Для Каждого Реквизит Из ОбъектМетаданных["Реквизиты"] Цикл
			
			// Справочник и ПВХ для групп и элементов разные реквизиты пропускаем элементы.
			Если (Объект <> Неопределено) И (ТипОбъекта = 2 ИЛИ ТипОбъекта = 3) Тогда				
				Если Объект.ЭтоГруппа Тогда
					Если Реквизит.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляЭлемента Тогда
						Продолжить;
					КонецЕсли;
				Иначе
					Если Реквизит.Использование = Метаданные.СвойстваОбъектов.ИспользованиеРеквизита.ДляГруппы Тогда
						Продолжить;
					КонецЕсли;					
				КонецЕсли;
			КонецЕсли;
			
			Результат.Добавить(Реквизит.Имя, ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним));
		КонецЦикла;
	КонецЕсли;
	
	// Общие реквизиты.
	Попытка
		ЕстьОбщиеРеквизиты = Метаданные.ОбщиеРеквизиты.Количество() > 0
	Исключение
		ЕстьОбщиеРеквизиты = Ложь;
	КонецПопытки;
	
	Если ЕстьОбщиеРеквизиты Тогда                                         
		Для Каждого Реквизит Из Метаданные.ОбщиеРеквизиты Цикл
			
			НайденныйОбъект = Реквизит.Состав.Найти(ОбъектМетаданных);
			Если НайденныйОбъект <> Неопределено Тогда
				Если (НайденныйОбъект.Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Использовать) ИЛИ (Реквизит.АвтоИспользование = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита.Использовать И НайденныйОбъект.Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Авто) Тогда
					Результат.Добавить(Реквизит.Имя, ?(ПустаяСтрока(Реквизит.Синоним), Реквизит.Имя, Реквизит.Синоним));
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // ПолучитьРеквизитыОбъекта

// Возвращает для объекта метаданных стандартные реквизиты.
Функция ПолучитьСтандартныеРеквизитыОбъекта(Знач ОбъектМетаданных, Знач ТипОбъекта) Экспорт
	
	Результат = Новый СписокЗначений;	
	
	Если ТипОбъекта = 1 Тогда
		// Документ
		Результат.Добавить("Дата", "Дата");
		Если ОбъектМетаданных.ДлинаНомера > 0 Тогда
			Результат.Добавить("Номер", "Номер");
		КонецЕсли;		
		Если ОбъектМетаданных.Проведение = Метаданные.СвойстваОбъектов.Проведение.Разрешить Тогда
			Результат.Добавить("Проведен", "Проведен");
		КонецЕсли;
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");
	ИначеЕсли ТипОбъекта = 2 Тогда
		// Справочник
		Если ОбъектМетаданных.ДлинаКода > 0 Тогда
			Результат.Добавить("Код", "Код");
		КонецЕсли;
		Если ОбъектМетаданных.ДлинаНаименования > 0 Тогда
			Результат.Добавить("Наименование", "Наименование");
		КонецЕсли;		
		Если ОбъектМетаданных.Иерархический Тогда
			Результат.Добавить("Родитель", "Родитель");
			Результат.Добавить("ЭтоГруппа", "Это группа");
		КонецЕсли;		
		Если ОбъектМетаданных.Владельцы.Количество() > 0 Тогда
			Результат.Добавить("Владелец", "Владелец");
		КонецЕсли;
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");
	ИначеЕсли ТипОбъекта = 3 Тогда
		// ПланыВидовХарактеристик
		Если ОбъектМетаданных.ДлинаКода > 0 Тогда
			Результат.Добавить("Код", "Код");
		КонецЕсли;
		Если ОбъектМетаданных.ДлинаНаименования > 0 Тогда
			Результат.Добавить("Наименование", "Наименование");
		КонецЕсли;
		Если ОбъектМетаданных.Иерархический Тогда
			Результат.Добавить("Родитель", "Родитель");
			Результат.Добавить("ЭтоГруппа", "Это группа");
		КонецЕсли;
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");
	ИначеЕсли ТипОбъекта = 4 Тогда
		// Константы
		// ПУСТО
	ИначеЕсли ТипОбъекта = 5 Тогда
		// ПланыСчетов
		Если ОбъектМетаданных.ДлинаКода > 0 Тогда
			Результат.Добавить("Код", "Код");
		КонецЕсли;
		Если ОбъектМетаданных.ДлинаНаименования > 0 Тогда
			Результат.Добавить("Наименование", "Наименование");
		КонецЕсли;
		Результат.Добавить("Родитель", "Родитель");
		Результат.Добавить("Порядок", "Порядок");
		Результат.Добавить("Забалансовый", "Забалансовый");
		Результат.Добавить("Вид", "Вид");
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");
	ИначеЕсли ТипОбъекта = 6 Тогда
		// ПланыВидовРасчета
		Если ОбъектМетаданных.ДлинаКода > 0 Тогда
			Результат.Добавить("Код", "Код");
		КонецЕсли;
		Если ОбъектМетаданных.ДлинаНаименования > 0 Тогда
			Результат.Добавить("Наименование", "Наименование");
		КонецЕсли;
		Если ОбъектМетаданных.ИспользованиеПериодаДействия Тогда
			Результат.Добавить("ПериодДействияБазовый", "Базовый период действия");
		КонецЕсли;
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");
	ИначеЕсли ТипОбъекта = 7 Тогда
		// ПланыОбмена
		Результат.Добавить("НомерОтправленного", "Номер отправленного");
		Результат.Добавить("НомерПринятого", "Номер принятого");		
		Если ОбъектМетаданных.ДлинаКода > 0 Тогда
			Результат.Добавить("Код", "Код");
		КонецЕсли;		
		Если ОбъектМетаданных.ДлинаНаименования > 0 Тогда
			Результат.Добавить("Наименование", "Наименование");
		КонецЕсли;
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");
	ИначеЕсли ТипОбъекта = 8 Тогда
		// Задачи
		Если ОбъектМетаданных.ДлинаНомера > 0 Тогда
			Результат.Добавить("Номер", "Номер");
		КонецЕсли;
		Результат.Добавить("Дата", "Дата");
		Если ОбъектМетаданных.ДлинаНаименования > 0 Тогда
			Результат.Добавить("Наименование", "Наименование");
		КонецЕсли;
		Результат.Добавить("Выполнена"	   , "Выполнена");
		Результат.Добавить("БизнесПроцесс", "Бизнес-процесс");
		Результат.Добавить("ТочкаМаршрута", "Точка маршрута");
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");
	ИначеЕсли ТипОбъекта = 9 Тогда
		// БизнесПроцессы
		Если ОбъектМетаданных.ДлинаНомера > 0 Тогда
			Результат.Добавить("Номер", "Номер");
		КонецЕсли;
		Результат.Добавить("Дата", "Дата");
		Результат.Добавить("Стартован", "Стартован");
		Результат.Добавить("Завершен", "Завершен");		
		Результат.Добавить("ВедущаяЗадача", "Ведущая задача");
		Результат.Добавить("ПометкаУдаления", "Пометка удаления");			
	ИначеЕсли ТипОбъекта = 10 Тогда
		// РегистрыСведений
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // ПолучитьСтандартныеРеквизитыОбъекта

#КонецОбласти