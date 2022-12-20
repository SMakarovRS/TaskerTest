﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик команды формы.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма, из которой выполняется команда.
//   Команда - КомандаФормы - Выполняемая команда.
//   Источник - ТаблицаФормы, ДанныеФормыСтруктура - Объект или список формы с полем "Ссылка".
//
Процедура НачатьВыполнениеКоманды(Форма, Команда, Источник) Экспорт
	ИмяКоманды = Команда.Имя;
	АдресНастроек = Форма.ПараметрыПодключаемыхКоманд.АдресТаблицыКоманд;
	ОписаниеКоманды = ПодключаемыеКомандыКлиентПовтИсп.ОписаниеКоманды(ИмяКоманды, АдресНастроек);
	
	Контекст = ПодключаемыеКомандыКлиентСервер.ШаблонПараметровВыполненияКоманды();
	Контекст.ОписаниеКоманды = Новый Структура(ОписаниеКоманды);
	Контекст.Форма           = Форма;
	Контекст.Источник        = Источник;
	Контекст.ЭтоФормаОбъекта = ТипЗнч(Источник) = Тип("ДанныеФормыСтруктура");
	
	Контекст.Вставить("ТребуетсяЗапись", Контекст.ЭтоФормаОбъекта И ОписаниеКоманды.РежимЗаписи <> "НеЗаписывать");
	Контекст.Вставить("ТребуетсяПроведение", ОписаниеКоманды.РежимЗаписи = "Проводить");
	Контекст.Вставить("ТребуетсяРаботаСФайлами", ОписаниеКоманды.ТребуетсяРаботаСФайлами);
	Контекст.Вставить("ВызовСервераЧерезОбработкуОповещения");
	
	ПродолжитьВыполнениеКоманды(Контекст);
КонецПроцедуры

// Обработчик команды формы.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма, из которой выполняется команда.
//   Команда - КомандаФормы - Выполняемая команда.
//   Источник - ТаблицаФормы, ДанныеФормыСтруктура, Ссылка, Массив - Объект или список формы с полем "Ссылка",
//                                                                   Ссылка или массив ссылок.
//
Процедура ВыполнитьКоманду(Форма, Команда, Источник) Экспорт
	ИмяКоманды = Команда.Имя;
	АдресНастроек = Форма.ПараметрыПодключаемыхКоманд.АдресТаблицыКоманд;
	ОписаниеКоманды = ПодключаемыеКомандыКлиентПовтИсп.ОписаниеКоманды(ИмяКоманды, АдресНастроек);
	
	Контекст = ПодключаемыеКомандыКлиентСервер.ШаблонПараметровВыполненияКоманды();
	Контекст.ОписаниеКоманды = Новый Структура(ОписаниеКоманды);
	Контекст.Форма           = Форма;
	Контекст.Источник        = Источник;
	Контекст.ЭтоФормаОбъекта = ТипЗнч(Источник) = Тип("ДанныеФормыСтруктура");
	
	Контекст.Вставить("ТребуетсяЗапись", Контекст.ЭтоФормаОбъекта И ОписаниеКоманды.РежимЗаписи <> "НеЗаписывать");
	Контекст.Вставить("ТребуетсяПроведение", ОписаниеКоманды.РежимЗаписи = "Проводить");
	Контекст.Вставить("ТребуетсяРаботаСФайлами", ОписаниеКоманды.ТребуетсяРаботаСФайлами);
	
	ПродолжитьВыполнениеКоманды(Контекст);
КонецПроцедуры

// Запускает отложенный процесс обновления команд печати на форме.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма, на которой необходимо обновить команды печати.
//
Процедура НачатьОбновлениеКоманд(Форма) Экспорт
	Форма.ОтключитьОбработчикОжидания("Подключаемый_ОбновитьКоманды");
	Форма.ПодключитьОбработчикОжидания("Подключаемый_ОбновитьКоманды", 0.2, Истина);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Выполняет команду, подключенную к форме.
Процедура ПродолжитьВыполнениеКоманды(Контекст)
	Источник = Контекст.Источник;
	ОписаниеКоманды = Контекст.ОписаниеКоманды;
	
	// Установка расширения работы с файлами.
	Если Контекст.ТребуетсяРаботаСФайлами Тогда
		Контекст.ТребуетсяРаботаСФайлами = Ложь;
		Обработчик = Новый ОписаниеОповещения("ПродолжитьВыполнениеКомандыПослеУстановкиРасширенияРаботыСФайлами", ЭтотОбъект, Контекст);
		ТекстСообщения = НСтр("ru = 'Для продолжения необходимо установить расширение для работы с 1С:Предприятием.'");
		ФайловаяСистемаКлиент.ПодключитьРасширениеДляРаботыСФайлами(Обработчик, ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	// Запись в форме объекта.
	Если Контекст.ТребуетсяЗапись Тогда
		Контекст.ТребуетсяЗапись = Ложь;
		Если Источник.Ссылка.Пустая()
			Или (ОписаниеКоманды.РежимЗаписи <> "ЗаписыватьТолькоНовые" И Контекст.Форма.Модифицированность) Тогда
			
			Кнопки = Новый СписокЗначений;
			Если Контекст.ТребуетсяПроведение Тогда
				ШаблонВопроса = НСтр("ru = 'Для выполнения команды ""%1""
					|документ будет проведен. Продолжить?'");
				Кнопки.Добавить(КодВозвратаДиалога.ОК, НСтр("ru = 'Провести и продолжить'"));
			Иначе
				ШаблонВопроса = НСтр("ru = 'Для выполнения команды ""%1""
					|данные будут записаны. Продолжить?'");
				Кнопки.Добавить(КодВозвратаДиалога.ОК, НСтр("ru = 'Записать и продолжить'"));
			КонецЕсли;
			Кнопки.Добавить(КодВозвратаДиалога.Отмена);
			
			ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонВопроса, ОписаниеКоманды.Представление);
			Обработчик = Новый ОписаниеОповещения("ПродолжитьВыполнениеКомандыПослеПодтвержденияЗаписи", ЭтотОбъект, Контекст);
			
			ПоказатьВопрос(Обработчик, ТекстВопроса, Кнопки);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Если Не Контекст.Свойство("МассивСсылок") Тогда
		Контекст.Вставить("МассивСсылок", ВыбранныеОбъекты(Источник, ОписаниеКоманды));
	КонецЕсли;
	
	// Проведение документов.
	Если Контекст.ТребуетсяПроведение Тогда
		Контекст.ТребуетсяПроведение = Ложь;
		ИнформацияОДокументах = ПодключаемыеКомандыВызовСервера.ИнформацияОДокументах(Контекст.МассивСсылок);
		Если ИнформацияОДокументах.Непроведенные.Количество() > 0 Тогда
			Если ИнформацияОДокументах.ДоступноПравоПроведения Тогда
				Если ИнформацияОДокументах.Непроведенные.Количество() = 1 Тогда
					ТекстВопроса = НСтр("ru = 'Для выполнения команды необходимо предварительно провести документ. Выполнить проведение документа и продолжить?'");
				Иначе
					ТекстВопроса = НСтр("ru = 'Для выполнения команды необходимо предварительно провести документы. Выполнить проведение документов и продолжить?'");
				КонецЕсли;
				Контекст.Вставить("НепроведенныеДокументы", ИнформацияОДокументах.Непроведенные);
				Обработчик = Новый ОписаниеОповещения("ПродолжитьВыполнениеКомандыПослеПодтверждениеПроведения", ЭтотОбъект, Контекст);
				Кнопки = Новый СписокЗначений;
				Кнопки.Добавить(КодВозвратаДиалога.Да, НСтр("ru = 'Продолжить'"));
				Кнопки.Добавить(КодВозвратаДиалога.Отмена);
				ПоказатьВопрос(Обработчик, ТекстВопроса, Кнопки);
			Иначе
				Если ИнформацияОДокументах.Непроведенные.Количество() = 1 Тогда
					ТекстПредупреждения = НСтр("ru = 'Для выполнения команды необходимо предварительно провести документ. Недостаточно прав для проведения документа.'");
				Иначе
					ТекстПредупреждения = НСтр("ru = 'Для выполнения команды необходимо предварительно провести документы. Недостаточно прав для проведения документов.'");
				КонецЕсли;
				ПоказатьПредупреждение(, ТекстПредупреждения);
			КонецЕсли;
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	// Выполнение команды.
	Если ОписаниеКоманды.МножественныйВыбор Тогда
		ПараметрКоманды = Контекст.МассивСсылок;
	ИначеЕсли Контекст.МассивСсылок.Количество() = 0 Тогда
		ПараметрКоманды = Неопределено;
	Иначе
		ПараметрКоманды = Контекст.МассивСсылок[0];
	КонецЕсли;
	Если ОписаниеКоманды.Серверная Тогда
		Результат = Новый Структура;
		
		СерверныйКонтекст = Новый Структура;
		СерверныйКонтекст.Вставить("ПараметрКоманды", ПараметрКоманды);
		СерверныйКонтекст.Вставить("ИмяКомандыВФорме", ОписаниеКоманды.ИмяВФорме);
		СерверныйКонтекст.Вставить("Результат", Результат);
		
		Если Контекст.Свойство("ВызовСервераЧерезОбработкуОповещения") Тогда
			ОписаниеОповещения = Новый ОписаниеОповещения("Подключаемый_ПродолжитьВыполнениеКомандыНаСервере", Контекст.Форма);
			ВыполнитьОбработкуОповещения(ОписаниеОповещения, СерверныйКонтекст);
			Результат = СерверныйКонтекст.Результат;
		Иначе
			Контекст.Форма.Подключаемый_ВыполнитьКомандуНаСервере(СерверныйКонтекст, Результат);
		КонецЕсли;
		Если ЗначениеЗаполнено(Результат.Текст) Тогда
			ПоказатьПредупреждение(, Результат.Текст);
		Иначе
			ОбновитьФорму(Контекст);
		КонецЕсли;
	Иначе
		Если ЗначениеЗаполнено(ОписаниеКоманды.Обработчик) Тогда
			МассивПодстрок = СтрРазделить(ОписаниеКоманды.Обработчик, ".");
			Если МассивПодстрок.Количество() = 1 Тогда
				ПараметрыФормы = ПараметрыФормы(Контекст, ПараметрКоманды);
				КлиентскийМодуль = ПолучитьФорму(ОписаниеКоманды.ИмяФормы, ПараметрыФормы, Контекст.Форма, Истина);
				ИмяПроцедуры = ОписаниеКоманды.Обработчик;
			Иначе
				КлиентскийМодуль = ОбщегоНазначенияКлиент.ОбщийМодуль(МассивПодстрок[0]);
				ИмяПроцедуры = МассивПодстрок[1];
			КонецЕсли;
			Обработчик = Новый ОписаниеОповещения(ИмяПроцедуры, КлиентскийМодуль, Контекст);
			ВыполнитьОбработкуОповещения(Обработчик, ПараметрКоманды);
		ИначеЕсли ЗначениеЗаполнено(ОписаниеКоманды.ИмяФормы) Тогда
			ПараметрыФормы = ПараметрыФормы(Контекст, ПараметрКоманды);
			ОткрытьФорму(ОписаниеКоманды.ИмяФормы, ПараметрыФормы, Контекст.Форма, Истина);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

// Ветка процедуры, возникающая после диалога подтверждения записи.
Процедура ПродолжитьВыполнениеКомандыПослеПодтвержденияЗаписи(Ответ, Контекст) Экспорт
	Если Ответ = КодВозвратаДиалога.ОК Тогда
		ОчиститьСообщения();
		
		РежимЗаписи = РежимЗаписиДокумента.Запись;
		Если Контекст.ТребуетсяПроведение Тогда
			РежимЗаписи = РежимЗаписиДокумента.Проведение;
		КонецЕсли;
		
		Контекст.Форма.Записать(Новый Структура("РежимЗаписи", РежимЗаписи));
		
		Если Контекст.Источник.Ссылка.Пустая() Или Контекст.Форма.Модифицированность Тогда
			Возврат; // Запись не удалась, сообщения о причинах выводит платформа.
		КонецЕсли;
	ИначеЕсли Ответ = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	КонецЕсли;
	ПродолжитьВыполнениеКоманды(Контекст)
КонецПроцедуры

// Ветка процедуры, возникающая после диалога подтверждения проведения.
Процедура ПродолжитьВыполнениеКомандыПослеПодтверждениеПроведения(Ответ, Контекст) Экспорт
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ОчиститьСообщения();
	ДанныеОНепроведенныхДокументах = ОбщегоНазначенияВызовСервера.ПровестиДокументы(Контекст.НепроведенныеДокументы);
	ШаблонСообщения = НСтр("ru = 'Документ %1 не проведен: %2'");
	НепроведенныеДокументы = Новый Массив;
	Для Каждого ИнформацияОДокументе Из ДанныеОНепроведенныхДокументах Цикл
		ОбщегоНазначенияКлиент.СообщитьПользователю(
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ШаблонСообщения,
				Строка(ИнформацияОДокументе.Ссылка),
				ИнформацияОДокументе.ОписаниеОшибки),
				ИнформацияОДокументе.Ссылка);
		НепроведенныеДокументы.Добавить(ИнформацияОДокументе.Ссылка);
	КонецЦикла;
	Контекст.Вставить("НепроведенныеДокументы", НепроведенныеДокументы);
	
	Контекст.МассивСсылок = ОбщегоНазначенияКлиентСервер.РазностьМассивов(Контекст.МассивСсылок, НепроведенныеДокументы);
	
	// Оповещаем открытые формы о том, что были проведены документы.
	ТипыПроведенныхДокументов = Новый Соответствие;
	Для Каждого ПроведенныйДокумент Из Контекст.МассивСсылок Цикл
		ТипыПроведенныхДокументов.Вставить(ТипЗнч(ПроведенныйДокумент));
	КонецЦикла;
	Для Каждого Тип Из ТипыПроведенныхДокументов Цикл
		ОповеститьОбИзменении(Тип.Ключ);
	КонецЦикла;
	
	// Если команда была вызвана из формы, то зачитываем в форму актуальную (проведенную) копию из базы.
	Если ТипЗнч(Контекст.Форма) = Тип("ФормаКлиентскогоПриложения") Тогда
		Если Контекст.ЭтоФормаОбъекта Тогда
			Контекст.Форма.Прочитать();
		КонецЕсли;
		Контекст.Форма.ОбновитьОтображениеДанных();
	КонецЕсли;
	
	Если НепроведенныеДокументы.Количество() > 0 Тогда
		// Спрашиваем пользователя о необходимости продолжения создания на основании при наличии непроведенных документов.
		ТекстДиалога = НСтр("ru = 'Не удалось провести один или несколько документов.'");
		
		КнопкиДиалога = Новый СписокЗначений;
		Если Контекст.МассивСсылок.Количество() = 0 Тогда
			КнопкиДиалога.Добавить(КодВозвратаДиалога.Отмена, НСтр("ru = 'ОК'"));
		Иначе
			ТекстДиалога = ТекстДиалога + " " + НСтр("ru = 'Продолжить?'");
			КнопкиДиалога.Добавить(КодВозвратаДиалога.Пропустить, НСтр("ru = 'Продолжить'"));
			КнопкиДиалога.Добавить(КодВозвратаДиалога.Отмена);
		КонецЕсли;
		
		Обработчик = Новый ОписаниеОповещения("ПродолжитьВыполнениеКомандыПослеПодтверждениеПродолжения", ЭтотОбъект, Контекст);
		ПоказатьВопрос(Обработчик, ТекстДиалога, КнопкиДиалога);
		Возврат;
	КонецЕсли;
	
	ПродолжитьВыполнениеКоманды(Контекст);
КонецПроцедуры

// Ветка процедуры, возникающая после диалога подтверждения продолжения когда есть непроведенные документы.
Процедура ПродолжитьВыполнениеКомандыПослеПодтверждениеПродолжения(Ответ, Контекст) Экспорт
	Если Ответ <> КодВозвратаДиалога.Пропустить Тогда
		Возврат;
	КонецЕсли;
	ПродолжитьВыполнениеКоманды(Контекст);
КонецПроцедуры

// Ветка процедуры, возникающая после установки расширения работы с файлами.
Процедура ПродолжитьВыполнениеКомандыПослеУстановкиРасширенияРаботыСФайлами(РасширениеРаботыСФайламиПодключено, Контекст) Экспорт
	Если Не РасширениеРаботыСФайламиПодключено Тогда
		Возврат;
	КонецЕсли;
	ПродолжитьВыполнениеКоманды(Контекст);
КонецПроцедуры

// Получает ссылку из строки таблицы, проверяет что ссылка соответствует типу и добавляет в массив.
Процедура ДобавитьСсылкуВСписок(ДанныеФормыСтруктура, МассивСсылок, ТипПараметра)
	Ссылка = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(ДанныеФормыСтруктура, "Ссылка");
	Если ТипПараметра <> Неопределено И Не ТипПараметра.СодержитТип(ТипЗнч(Ссылка)) Тогда
		Возврат;
	ИначеЕсли Не ЗначениеЗаполнено(Ссылка) Или ТипЗнч(Ссылка) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
		Возврат;
	КонецЕсли;
	МассивСсылок.Добавить(Ссылка);
КонецПроцедуры

// Формирует параметры формы подключенного объекта в контексте выполняемой команды.
Функция ПараметрыФормы(Контекст, ПараметрКоманды)
	Результат = Контекст.ОписаниеКоманды.ПараметрыФормы;
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		Результат = Новый Структура;
	КонецЕсли;
	Контекст.ОписаниеКоманды.Удалить("ПараметрыФормы");
	Результат.Вставить("ОписаниеКоманды", Контекст.ОписаниеКоманды);
	Если ПустаяСтрока(Контекст.ОписаниеКоманды.ИмяПараметраФормы) Тогда
		Результат.Вставить("ПараметрКоманды", ПараметрКоманды);
	Иначе
		МассивИмен = СтрРазделить(Контекст.ОписаниеКоманды.ИмяПараметраФормы, ".", Ложь);
		Узел = Результат;
		ВГраница = МассивИмен.ВГраница();
		Для Индекс = 0 По ВГраница-1 Цикл
			Имя = СокрЛП(МассивИмен[Индекс]);
			Если Не Узел.Свойство(Имя) Или ТипЗнч(Узел[Имя]) <> Тип("Структура") Тогда
				Узел.Вставить(Имя, Новый Структура);
			КонецЕсли;
			Узел = Узел[Имя];
		КонецЦикла;
		Узел.Вставить(МассивИмен[ВГраница], ПараметрКоманды);
	КонецЕсли;
	Возврат Результат;
КонецФункции

// Обновляет форму целевого объекта после окончания выполнения команды.
Процедура ОбновитьФорму(Контекст)
	Если Контекст.ЭтоФормаОбъекта И Контекст.ОписаниеКоманды.РежимЗаписи <> "НеЗаписывать" И Не Контекст.Форма.Модифицированность Тогда
		Попытка
			Контекст.Форма.Прочитать();
		Исключение
			// Если метода Прочитать нет, значит печать выполнена не из формы объекта.
		КонецПопытки;
	КонецЕсли;
	Если Контекст.ОписаниеКоманды.РежимЗаписи <> "НеЗаписывать" Тогда
		ТипыИзмененныхОбъектов = Новый Массив;
		Для Каждого Ссылка Из Контекст.МассивСсылок Цикл
			Тип = ТипЗнч(Ссылка);
			Если ТипыИзмененныхОбъектов.Найти(Ссылка) = Неопределено Тогда
				ТипыИзмененныхОбъектов.Добавить(Ссылка);
			КонецЕсли;
		КонецЦикла;
		Для Каждого Тип Из ТипыИзмененныхОбъектов Цикл
			ОповеститьОбИзменении(Тип);
		КонецЦикла;
	КонецЕсли;
	Контекст.Форма.ОбновитьОтображениеДанных();
КонецПроцедуры

Функция ВыбранныеОбъекты(Источник, ОписаниеКоманды)
	
	Результат = Новый Массив;
	ДопустимыеТипы = ОписаниеКоманды.ТипПараметра;
	
	Если ТипЗнч(Источник) = Тип("ДанныеФормыСтруктура") Тогда
		ДобавитьСсылкуВСписок(Источник, Результат, ДопустимыеТипы);
	ИначеЕсли ДопустимыеТипы <> Неопределено И ДопустимыеТипы.СодержитТип(ТипЗнч(Источник)) Тогда
		Результат.Добавить(Источник);
	ИначеЕсли ТипЗнч(Источник) = Тип("Массив") Тогда
		Если ДопустимыеТипы = Неопределено Тогда
			Результат = Источник;
		Иначе
			Для Каждого Ссылка Из Источник Цикл
				Если ДопустимыеТипы.СодержитТип(ТипЗнч(Ссылка)) Тогда
					Результат.Добавить(Ссылка);
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	ИначеЕсли Не ОписаниеКоманды.МножественныйВыбор Тогда
		Если ДопустимыеТипы <> Неопределено И ДопустимыеТипы.СодержитТип(ТипЗнч(Источник.ТекущаяСтрока)) Тогда
			Результат.Добавить(Источник.ТекущаяСтрока);
		Иначе
			ДобавитьСсылкуВСписок(Источник.ТекущиеДанные, Результат, ДопустимыеТипы);
		КонецЕсли;
	Иначе
		Для Каждого Идентификатор Из Источник.ВыделенныеСтроки Цикл
			Если ДопустимыеТипы <> Неопределено И ДопустимыеТипы.СодержитТип(ТипЗнч(Идентификатор)) Тогда
				Результат.Добавить(Идентификатор);
			Иначе
				ДобавитьСсылкуВСписок(Источник.ДанныеСтроки(Идентификатор), Результат, ДопустимыеТипы);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Результат) И ОписаниеКоманды.РежимЗаписи <> "НеЗаписывать" Тогда
		ВызватьИсключение НСтр("ru = 'Команда не может быть выполнена для указанного объекта.'");
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
