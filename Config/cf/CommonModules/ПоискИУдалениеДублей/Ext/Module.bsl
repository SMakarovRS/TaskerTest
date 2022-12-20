﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Поиск дублей для указанного значения.
//
// Параметры:
//     ОбластьПоиска - Строка - имя таблицы данных (полное имя метаданных) области поиска.
//                              Например, "Справочник.Номенклатура". Поддерживается поиск в справочниках, 
//                              планах видов характеристик, видах расчетов, планах счетов.
//
//     ЭталонныйОбъект - Произвольный - объект с данными элемента, для которого производится поиск дублей.
//
//     ДополнительныеПараметры - Произвольный - параметр для передачи в обработчики событий менеджера.
//
// Возвращаемое значение:
//     ТаблицаЗначений - содержит строки с описаниями дублей.
// 
Функция НайтиДублиЭлемента(Знач ОбластьПоиска, Знач ЭталонныйОбъект, Знач ДополнительныеПараметры) Экспорт
	
	ПараметрыПоискаДублей = Новый Структура;
	ПараметрыПоискаДублей.Вставить("КомпоновщикПредварительногоОтбора");
	ПараметрыПоискаДублей.Вставить("ОбластьПоискаДублей", ОбластьПоиска);
	ПараметрыПоискаДублей.Вставить("УчитыватьПрикладныеПравила", Истина);
	
	// Из параметров
	ПараметрыПоискаДублей.Вставить("ПравилаПоиска", Новый ТаблицаЗначений);
	ПараметрыПоискаДублей.ПравилаПоиска.Колонки.Добавить("Реквизит", Новый ОписаниеТипов("Строка"));
	ПараметрыПоискаДублей.ПравилаПоиска.Колонки.Добавить("Правило",  Новый ОписаниеТипов("Строка"));
	
	// См. Обработка.ПоискИУдалениеДублей
	ПараметрыПоискаДублей.КомпоновщикПредварительногоОтбора = Новый КомпоновщикНастроекКомпоновкиДанных;
	ОбластьПоискаМетаданные = Метаданные.НайтиПоПолномуИмени(ОбластьПоиска);
	ДоступныеРеквизитыОтбора = ДоступныеИменаРеквизитовОтбора(ОбластьПоискаМетаданные.СтандартныеРеквизиты);
	ДоступныеРеквизитыОтбора = ?(ПустаяСтрока(ДоступныеРеквизитыОтбора), ",", ДоступныеРеквизитыОтбора)
		+ ДоступныеИменаРеквизитовОтбора(ОбластьПоискаМетаданные.Реквизиты);
	ТекстЗапроса = "ВЫБРАТЬ * ИЗ #Таблица";
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "*", Сред(ДоступныеРеквизитыОтбора, 2));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "#Таблица", ОбластьПоиска);
	
	СхемаКомпоновки = Новый СхемаКомпоновкиДанных;
	ИсточникДанных = СхемаКомпоновки.ИсточникиДанных.Добавить();
	ИсточникДанных.ТипИсточникаДанных = "Local";
	
	НаборДанных = СхемаКомпоновки.НаборыДанных.Добавить(Тип("НаборДанныхЗапросСхемыКомпоновкиДанных"));
	НаборДанных.Запрос = ТекстЗапроса;
	НаборДанных.АвтоЗаполнениеДоступныхПолей = Истина;
	
	ПараметрыПоискаДублей.КомпоновщикПредварительногоОтбора.Инициализировать( Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновки) );
	
	// Вызов прикладного кода
	ОбработкаПоиска = Обработки.ПоискИУдалениеДублей.Создать();
	
	ИспользоватьПрикладныеПравила = ОбработкаПоиска.ЕстьПрикладныеПравилаОбластиПоискаДублей(ОбластьПоиска);
	Если ИспользоватьПрикладныеПравила Тогда
		ПрикладныеПараметры = ПараметрыПоискаДублей(ПараметрыПоискаДублей.ПравилаПоиска, ПараметрыПоискаДублей.КомпоновщикПредварительногоОтбора);
		МенеджерОбластиПоиска = ОбработкаПоиска.МенеджерОбластиПоискаДублей(ОбластьПоиска);
		МенеджерОбластиПоиска.ПараметрыПоискаДублей(ПрикладныеПараметры, ДополнительныеПараметры);
		ПараметрыПоискаДублей.Вставить("ДополнительныеПараметры", ДополнительныеПараметры);
	КонецЕсли;
	
	ГруппыДублей = ОбработкаПоиска.ГруппыДублей(ПараметрыПоискаДублей, ЭталонныйОбъект);
	Результат = ГруппыДублей.ТаблицаДублей;
	
	// Там ровно одна группа, возвращаем нужные элементы.
	Для Каждого Строка Из Результат.НайтиСтроки(Новый Структура("Родитель", Неопределено)) Цикл
		Результат.Удалить(Строка);
	КонецЦикла;
	ПустаяСсылка = МенеджерОбластиПоиска.ПустаяСсылка();
	Для Каждого Строка Из Результат.НайтиСтроки(Новый Структура("Ссылка", ПустаяСсылка)) Цикл
		Результат.Удалить(Строка);
	КонецЦикла;
	
	Возврат Результат; 
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ПроверитьВозможностьЗаменыЭлементовСтрока(ПарыЗамен, ПараметрыЗамены) Экспорт
	
	Результат = "";
	Ошибки = ПроверитьВозможностьЗаменыЭлементов(ПарыЗамен, ПараметрыЗамены);
	Для Каждого КлючЗначение Из Ошибки Цикл
		Результат = Результат + Символы.ПС + КлючЗначение.Значение;
	КонецЦикла;
	Возврат СокрЛП(Результат);
	
КонецФункции

Функция ПроверитьВозможностьЗаменыЭлементов(ПарыЗамен, ПараметрыЗамены) Экспорт
	
	Если ПарыЗамен.Количество() = 0 Тогда
		Возврат Новый Соответствие;
	КонецЕсли;
	
	Для Каждого Элемент Из ПарыЗамен Цикл
		ПервыйЭлемент = Элемент.Ключ;
		Прервать;
	КонецЦикла;
	
	Результат = Новый Соответствие;
	
	ИмяОбъектаМетаданных = ПервыйЭлемент.Метаданные().ПолноеИмя();
	СведенияОбОбъекте = ОбъектыСПоискомДублей()[ИмяОбъектаМетаданных];
	Если СведенияОбОбъекте <> Неопределено И (СведенияОбОбъекте = "" Или СтрНайти(СведенияОбОбъекте, "ВозможностьЗаменыЭлементов") > 0) Тогда
		МодульМенеджера = ОбщегоНазначения.МенеджерОбъектаПоСсылке(ПервыйЭлемент);
		Результат = МодульМенеджера.ВозможностьЗаменыЭлементов(ПарыЗамен, ПараметрыЗамены);
	КонецЕсли;
	
	ПоискИУдалениеДублейПереопределяемый.ПриОпределенииВозможностиЗаменыЭлементов(ИмяОбъектаМетаданных, ПарыЗамен, ПараметрыЗамены, Результат);
	Возврат Результат;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистем конфигурации.

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
Процедура ПриНастройкеВариантовОтчетов(Настройки) Экспорт
	МодульВариантыОтчетов = ОбщегоНазначения.ОбщийМодуль("ВариантыОтчетов");
	МодульВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.МестаИспользованияСсылок);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// См. Обработка.ПоискИУдалениеДублей
Функция ДоступныеИменаРеквизитовОтбора(Знач КоллекцияМетаданных)
	Результат = "";
	ТипХранилища = Тип("ХранилищеЗначения");
	
	Для Каждого Реквизит Из КоллекцияМетаданных Цикл
		ЭтоХранилище = Реквизит.Тип.СодержитТип(ТипХранилища);
		Если Не ЭтоХранилище Тогда
			Результат = Результат + "," + Реквизит.Имя;
		КонецЕсли
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Процедура ОпределитьМестаИспользования(Знач НаборСсылок, Знач АдресРезультата) Экспорт
	
	ТаблицаПоиска = ОбщегоНазначения.МестаИспользования(НаборСсылок);
	
	Фильтр = Новый Структура("ЭтоСлужебныеДанные", Ложь);
	АктуальныеСтроки = ТаблицаПоиска.НайтиСтроки(Фильтр);
	
	Результат = ТаблицаПоиска.Скопировать(АктуальныеСтроки, "Ссылка");
	Результат.Колонки.Добавить("Вхождения", Новый ОписаниеТипов("Число"));
	Результат.ЗаполнитьЗначения(1, "Вхождения");
	
	Результат.Индексы.Добавить("Ссылка");
	
	Результат.Свернуть("Ссылка", "Вхождения");
	Для Каждого Ссылка Из НаборСсылок Цикл
		Если Результат.Найти(Ссылка, "Ссылка") = Неопределено Тогда
			Результат.Добавить().Ссылка = Ссылка;
		КонецЕсли;
	КонецЦикла;
	
	ПоместитьВоВременноеХранилище(Результат, АдресРезультата);
КонецПроцедуры

// Производит замену ссылок во всех данных информационной базы. 
//
// Параметры:
//     Параметры - Структура - где:
//       * ПарыЗамен - Соответствие - Пары замен.
//           * Ключ     - ЛюбаяСсылка - Что ищем (дубль).
//           * Значение - ЛюбаяСсылка - На что заменяем (оригинал).
//           Ссылки сами на себя и пустые ссылки для поиска будут проигнорированы.
//       * СпособУдаления - Строка - Необязательный. Что делать с дублем после успешной замены.
//           ""                - По умолчанию. Не предпринимать никаких действий.
//           "Пометка"         - Помечать на удаление.
//           "Непосредственно" - Удалять непосредственно.
//     АдресРезультата - Строка - адрес временного хранилища, куда будет помещен результат замены - ТаблицаЗначений:
//       * Ссылка - ЛюбаяСсылка - Ссылка, которую заменяли.
//       * ОбъектОшибки - Произвольный - Объект - причина ошибки.
//       * ПредставлениеОбъектаОшибки - Строка - Строковое представление объекта ошибки.
//       * ТипОшибки - Строка - Маркер типа ошибки. Возможны варианты:
//                              "ОшибкаБлокировки"  - при обработке ссылки некоторые объекты были заблокированы
//                              "ДанныеИзменены"    - в процессе обработки данные были изменены другим пользователем
//                              "ОшибкаЗаписи"      - не смогли записать объект
//                              "НеизвестныеДанные" - при обработке были найдены данные, которые
//                                                    не планировались к анализу, замена не реализована
//                              "ЗаменаЗапрещена"   - обработчик ВозможностьЗаменыЭлементов вернул отказ.
//       * ТекстОшибки - Строка - Подробное описание ошибки.
//
Процедура ЗаменитьСсылки(Параметры, Знач АдресРезультата) Экспорт
	
	ПараметрыЗаменыСсылок = ОбщегоНазначения.ПараметрыЗаменыСсылок();
	ПараметрыЗаменыСсылок.СпособУдаления = Параметры.СпособУдаления;
	ПараметрыЗаменыСсылок.ВключатьБизнесЛогику = Истина;
	ПараметрыЗаменыСсылок.ЗаменаПарыВТранзакции = Ложь;
	
	Результат = ОбщегоНазначения.ЗаменитьСсылки(Параметры.ПарыЗамен, ПараметрыЗаменыСсылок);
	ПоместитьВоВременноеХранилище(Результат, АдресРезультата);
	
КонецПроцедуры

// Формирует таблицу обслуживаемых объектов метаданных и их общие настройки.
//
// Возвращаемое значение:
//   ТаблицаЗначений - с колонками:
//       * ПолноеИмя             - Строка   - полное имя метаданных объекта-таблицы.
//       * ПредставлениеЭлемента - Строка   - представление элемента для пользователя.
//       * ПредставлениеСписка   - Строка   - представление списка для пользователя.
//       * Удален                - Булево   - это объект метаданных с префиксом "Удалить".
//       * СобытиеПараметрыПоискаДублей      - Булево - в модуле менеджера определен обработчик ВозможностьЗаменыЭлементов.
//       * СобытиеПриПоискеДублей            - Булево - в модуле менеджера определен обработчик ПараметрыПоискаДублей.
//       * СобытиеВозможностьЗаменыЭлементов - Булево - в модуле менеджера определен обработчик ПриПоискеДублей.
//
Функция НастройкиОбъектовМетаданных() Экспорт
	Настройки = Новый ТаблицаЗначений;
	Настройки.Колонки.Добавить("Вид",                   Новый ОписаниеТипов("Строка"));
	Настройки.Колонки.Добавить("ПолноеИмя",             Новый ОписаниеТипов("Строка"));
	Настройки.Колонки.Добавить("ПредставлениеЭлемента", Новый ОписаниеТипов("Строка"));
	Настройки.Колонки.Добавить("ПредставлениеСписка",   Новый ОписаниеТипов("Строка"));
	Настройки.Колонки.Добавить("Удален",                Новый ОписаниеТипов("Булево"));
	Настройки.Колонки.Добавить("СобытиеПараметрыПоискаДублей",      Новый ОписаниеТипов("Булево"));
	Настройки.Колонки.Добавить("СобытиеПриПоискеДублей",            Новый ОписаниеТипов("Булево"));
	Настройки.Колонки.Добавить("СобытиеВозможностьЗаменыЭлементов", Новый ОписаниеТипов("Булево"));
	
	СписокОбъектов = ОбъектыСПоискомДублей();
	ЗарегистрироватьКоллекциюМетаданных(Настройки, СписокОбъектов, Метаданные.Справочники, "Справочник");
	ЗарегистрироватьКоллекциюМетаданных(Настройки, СписокОбъектов, Метаданные.Документы, "Документ");
	ЗарегистрироватьКоллекциюМетаданных(Настройки, СписокОбъектов, Метаданные.ПланыСчетов, "ПланСчетов");
	ЗарегистрироватьКоллекциюМетаданных(Настройки, СписокОбъектов, Метаданные.ПланыВидовРасчета, "ПланВидовРасчета");
	ЗарегистрироватьКоллекциюМетаданных(Настройки, СписокОбъектов, Метаданные.ПланыВидовХарактеристик, "ПланВидовХарактеристик");
	
	Результат = Настройки.Скопировать(Новый Структура("Удален", Ложь));
	Результат.Сортировать("ПредставлениеСписка");
	
	Возврат Результат;
КонецФункции

Функция ОбъектыСПоискомДублей() Экспорт
	
	СписокОбъектов = Новый Соответствие;
	ИнтеграцияПодсистемБСП.ПриОпределенииОбъектовСПоискомДублей(СписокОбъектов);
	ПоискИУдалениеДублейПереопределяемый.ПриОпределенииОбъектовСПоискомДублей(СписокОбъектов);
	Возврат СписокОбъектов;

КонецФункции

Процедура ЗарегистрироватьКоллекциюМетаданных(Настройки, СписокОбъектов, КоллекцияМетаданных, Вид)
	
	Для Каждого ОбъектМетаданных Из КоллекцияМетаданных Цикл
		Если Не ПравоДоступа("Просмотр", ОбъектМетаданных)
			Или Не ОбщегоНазначения.ОбъектМетаданныхДоступенПоФункциональнымОпциям(ОбъектМетаданных) Тогда
			Продолжить; // Нет доступа, не выводим в список.
		КонецЕсли;
		
		СтрокаТаблицы = Настройки.Добавить();
		СтрокаТаблицы.Вид = Вид;
		СтрокаТаблицы.ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		СтрокаТаблицы.Удален = СтрНачинаетсяС(ОбъектМетаданных.Имя, "Удалить");
		СтрокаТаблицы.ПредставлениеЭлемента = ОбщегоНазначения.ПредставлениеОбъекта(ОбъектМетаданных);
		СтрокаТаблицы.ПредставлениеСписка = ОбщегоНазначения.ПредставлениеСписка(ОбъектМетаданных);
		
		События = СписокОбъектов[СтрокаТаблицы.ПолноеИмя];
		Если ТипЗнч(События) = Тип("Строка") Тогда
			Если ПустаяСтрока(События) Тогда
				СтрокаТаблицы.СобытиеПараметрыПоискаДублей      = Истина;
				СтрокаТаблицы.СобытиеПриПоискеДублей            = Истина;
				СтрокаТаблицы.СобытиеВозможностьЗаменыЭлементов = Истина;
			Иначе
				СтрокаТаблицы.СобытиеПараметрыПоискаДублей      = СтрНайти(События, "ПараметрыПоискаДублей") > 0;
				СтрокаТаблицы.СобытиеПриПоискеДублей            = СтрНайти(События, "ПриПоискеДублей") > 0;
				СтрокаТаблицы.СобытиеВозможностьЗаменыЭлементов = СтрНайти(События, "ВозможностьЗаменыЭлементов") > 0;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

// Представление подсистемы. Используется при записи в журнал регистрации и в других местах.
Функция НаименованиеПодсистемы(ДляПользователя) Экспорт
	КодЯзыка = ?(ДляПользователя, ОбщегоНазначения.КодОсновногоЯзыка(), "");
	Возврат НСтр("ru = 'Поиск и удаление дублей'", КодЯзыка);
КонецФункции

// Параметры:
//  ПравилаПоиска - ТаблицаЗначений - где:
//    ** Реквизит - Строка - 
//    ** Правило - Строка - 
//  КомпоновщикПредварительногоОтбора - КомпоновщикНастроекКомпоновкиДанных - 
//
// Возвращаемое значение:
//  Структура - где:
//    * ПравилаПоиска - ТаблицаЗначений - где:
//        ** Реквизит - Строка - 
//        ** Правило - Строка - 
//    * СравнениеСтрокНаПодобие - Структура, где:
//        ** ПроцентСовпаденияСтрок - Число - 
//        ** ПроцентСовпаденияНебольшихСтрок - Число - 
//        ** ДлинаНебольшихСтрок - Число - 
//        ** СловаИсключения - Массив - 
//    * КомпоновщикОтбора - КомпоновщикНастроекКомпоновкиДанных - 
//    * ОграниченияСравнения - Массив - 
//    * КоличествоЭлементовДляСравнения - Число -
//
Функция ПараметрыПоискаДублей(ПравилаПоиска, КомпоновщикПредварительногоОтбора) Экспорт
	
	СравнениеСтрокНаПодобие = Новый Структура;
	СравнениеСтрокНаПодобие.Вставить("ПроцентСовпаденияСтрок", 90);
	СравнениеСтрокНаПодобие.Вставить("ПроцентСовпаденияНебольшихСтрок", 80);
	СравнениеСтрокНаПодобие.Вставить("ДлинаНебольшихСтрок", 30);
	СравнениеСтрокНаПодобие.Вставить("СловаИсключения", Новый Массив);
	
	Результат = Новый Структура;
	Результат.Вставить("ПравилаПоиска",        ПравилаПоиска);
	Результат.Вставить("СравнениеСтрокНаПодобие", СравнениеСтрокНаПодобие);
	Результат.Вставить("КомпоновщикОтбора",    КомпоновщикПредварительногоОтбора);
	Результат.Вставить("ОграниченияСравнения", Новый Массив);
	Результат.Вставить("КоличествоЭлементовДляСравнения", 1500);
	Возврат Результат;
	
КонецФункции

#КонецОбласти