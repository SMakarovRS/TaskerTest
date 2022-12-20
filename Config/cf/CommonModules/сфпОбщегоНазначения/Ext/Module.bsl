﻿////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Позволяет определить, есть ли среди реквизитов объекта реквизит с переданным именем.
//
// Параметры:
//  ИмяРеквизита - Строка - имя реквизита;
//  МетаданныеОбъекта - ОбъектМетаданных - объект, в котором требуется проверить наличие реквизита.
//
// Возвращаемое значение:
//  Булево.
//
Функция сфпЕстьРеквизитОбъекта(ИмяРеквизита, МетаданныеОбъекта) Экспорт

	Возврат НЕ (МетаданныеОбъекта.Реквизиты.Найти(ИмяРеквизита) = Неопределено);

КонецФункции

// Возвращает структуру, содержащую значения реквизитов прочитанные из информационной базы
// по ссылке на объект.
// 
//  Если доступа к одному из реквизитов нет, возникнет исключение прав доступа.
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
// 
// Функция не предназначена для получения значений реквизитов пустых ссылок.
//
// Параметры:
//  Ссылка    - ЛюбаяСсылка - объект, значения реквизитов которого необходимо получить.
//
//  Реквизиты - Строка - имена реквизитов, перечисленные через запятую, в формате
//              требований к свойствам структуры.
//              Например, "Код, Наименование, Родитель".
//            - Структура, ФиксированнаяСтруктура - в качестве ключа передается
//              псевдоним поля для возвращаемой структуры с результатом, а в качестве
//              значения (опционально) фактическое имя поля в таблице.
//              Если значение не определено, то имя поля берется из ключа.
//            - Массив, ФиксированныйМассив - имена реквизитов в формате требований
//              к свойствам структуры.
//
// Возвращаемое значение:
//  Структура - содержит имена (ключи) и значения затребованных реквизитов.
//              Если строка затребованных реквизитов пуста, то возвращается пустая структура.
//              Если в качестве объекта передана пустая ссылка, то все реквизиты вернутся со значением Неопределено.
//
Функция сфпЗначенияРеквизитовОбъекта(Ссылка, Знач Реквизиты) Экспорт
	
	Если ТипЗнч(Реквизиты) = Тип("Строка") Тогда
		Если ПустаяСтрока(Реквизиты) Тогда
			Возврат Новый Структура;
		КонецЕсли;
		Реквизиты = сфпРазложитьСтрокуВМассивПодстрок(Реквизиты, ",", Ложь);
	КонецЕсли;
	
	СтруктураРеквизитов = Новый Структура;
	Если ТипЗнч(Реквизиты) = Тип("Структура") Или ТипЗнч(Реквизиты) = Тип("ФиксированнаяСтруктура") Тогда
		СтруктураРеквизитов = Реквизиты;
	ИначеЕсли ТипЗнч(Реквизиты) = Тип("Массив") Или ТипЗнч(Реквизиты) = Тип("ФиксированныйМассив") Тогда
		Для Каждого Реквизит Из Реквизиты Цикл
			СтруктураРеквизитов.Вставить(СтрЗаменить(Реквизит, ".", ""), Реквизит);
		КонецЦикла;
	Иначе
		ВызватьИсключение сфпПодставитьПараметрыВСтроку(НСтр("ru = 'Неверный тип второго параметра Реквизиты: %1'"), Строка(ТипЗнч(Реквизиты)));
	КонецЕсли;
	
	ТекстПолей = "";
	Для Каждого КлючИЗначение Из СтруктураРеквизитов Цикл
		ИмяПоля   = ?(ЗначениеЗаполнено(КлючИЗначение.Значение),
		              СокрЛП(КлючИЗначение.Значение),
		              СокрЛП(КлючИЗначение.Ключ));
		
		Псевдоним = СокрЛП(КлючИЗначение.Ключ);
		
		ТекстПолей  = ТекстПолей + ?(ПустаяСтрока(ТекстПолей), "", ",") + "
		|	" + ИмяПоля + " КАК " + Псевдоним;
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст =
	"ВЫБРАТЬ
	|" + ТекстПолей + "
	|ИЗ
	|	" + Ссылка.Метаданные().ПолноеИмя() + " КАК ПсевдонимЗаданнойТаблицы
	|ГДЕ
	|	ПсевдонимЗаданнойТаблицы.Ссылка = &Ссылка
	|";
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	
	Результат = Новый Структура;
	Для Каждого КлючИЗначение Из СтруктураРеквизитов Цикл
		Результат.Вставить(КлючИЗначение.Ключ);
	КонецЦикла;
	ЗаполнитьЗначенияСвойств(Результат, Выборка);
	
	Возврат Результат;
	
КонецФункции

// Возвращает значение реквизита, прочитанного из информационной базы по ссылке на объект.
// 
//  Если доступа к реквизиту нет, возникнет исключение прав доступа.
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
//
// Функция не предназначена для получения значений реквизитов пустых ссылок.
// 
// Параметры:
//  Ссылка       - ссылка на объект, - элемент справочника, документ, ...
//  ИмяРеквизита - Строка, например, "Код".
// 
// Возвращаемое значение:
//  Произвольный    - зависит от типа значения прочитанного реквизита.
// 
Функция сфпЗначениеРеквизитаОбъекта(Ссылка, ИмяРеквизита) Экспорт
	
	Результат = сфпЗначенияРеквизитовОбъекта(Ссылка, ИмяРеквизита);
	Возврат Результат[СтрЗаменить(ИмяРеквизита, ".", "")];
	
КонецФункции 

// Проверка того, что переданный тип является ссылочным типом данных.
// Для типа "Неопределено" возвращается Ложь.
//
// Возвращаемое значение:
//  Булево.
//
Функция сфпЭтоСсылка(Тип) Экспорт
	
	Возврат Тип <> Тип("Неопределено") 
		И (Справочники.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ Документы.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ Перечисления.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыВидовХарактеристик.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыСчетов.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыВидовРасчета.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ БизнесПроцессы.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ БизнесПроцессы.ТипВсеСсылкиТочекМаршрутаБизнесПроцессов().СодержитТип(Тип)
		ИЛИ Задачи.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыОбмена.ТипВсеСсылки().СодержитТип(Тип));
	
КонецФункции

// Отключает напоминание, если оно есть. Если напоминание периодическое, подключает его на ближайшую дату по расписанию.
Процедура сфпОтключитьНапоминание(ПараметрыНапоминания, ПодключатьПоРасписанию = Истина) Экспорт
	
	// ищем существующую запись
	Запрос = Новый Запрос;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	НапоминанияПользователя.Пользователь,
	|	НапоминанияПользователя.ВремяСобытия,
	|	НапоминанияПользователя.Источник,
	|	НапоминанияПользователя.СрокНапоминания,
	|	НапоминанияПользователя.Описание,
	|	НапоминанияПользователя.СпособУстановкиВремениНапоминания,
	|	НапоминанияПользователя.Расписание,
	|	НапоминанияПользователя.ИнтервалВремениНапоминания,
	|	НапоминанияПользователя.ИмяРеквизитаИсточника
	|ИЗ
	|	РегистрСведений.НапоминанияПользователя КАК НапоминанияПользователя
	|ГДЕ
	|	НапоминанияПользователя.Пользователь = &Пользователь
	|	И НапоминанияПользователя.ВремяСобытия = &ВремяСобытия
	|	И НапоминанияПользователя.Источник = &Источник";
	
	Запрос.УстановитьПараметр("Пользователь", ПараметрыНапоминания.Пользователь);
	Запрос.УстановитьПараметр("ВремяСобытия", ПараметрыНапоминания.ВремяСобытия);
	Запрос.УстановитьПараметр("Источник", ПараметрыНапоминания.Источник);
	
	Запрос.Текст = ТекстЗапроса;
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	Напоминание = Неопределено;
	Если РезультатЗапроса.Количество() > 0 Тогда
		Напоминание = РезультатЗапроса[0];
	КонецЕсли;
	
	// Удаляем существующую запись.
	НаборЗаписей = РегистрыСведений["НапоминанияПользователя"].СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Пользователь.Установить(ПараметрыНапоминания.Пользователь);
	НаборЗаписей.Отбор.Источник.Установить(ПараметрыНапоминания.Источник);
	НаборЗаписей.Отбор.ВремяСобытия.Установить(ПараметрыНапоминания.ВремяСобытия);
	
	НаборЗаписей.Очистить();
	НаборЗаписей.Записать();
	
	СледующаяДатаПоРасписанию = Неопределено;
	ОпределенаСледующаяДатаПоРасписанию = Ложь;
	
	// Подключаем следующее напоминание по расписанию.
	Если ПодключатьПоРасписанию И Напоминание <> Неопределено Тогда
		Расписание = Напоминание.Расписание.Получить();
		Если Расписание <> Неопределено Тогда
			Если Расписание.ПериодПовтораДней > 0 Тогда
				СледующаяДатаПоРасписанию = сфпПолучитьБлижайшуюДатуСобытияПоРасписанию(Расписание, ПараметрыНапоминания.ВремяСобытия + 1);
			КонецЕсли;
			ОпределенаСледующаяДатаПоРасписанию = СледующаяДатаПоРасписанию <> Неопределено;
		КонецЕсли;
		
		Если ОпределенаСледующаяДатаПоРасписанию Тогда
			Напоминание.ВремяСобытия = СледующаяДатаПоРасписанию;
			Напоминание.СрокНапоминания = Напоминание.ВремяСобытия - Напоминание.ИнтервалВремениНапоминания;
			сфпПодключитьНапоминание(Напоминание);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Создает напоминание пользователя. Если по объекту уже есть напоминание, то перезаписывает его.
Процедура сфпПодключитьНапоминание(ПараметрыНапоминания, ОбновитьСрокНапоминания = Ложь) Экспорт
	
	НаборЗаписей = РегистрыСведений["НапоминанияПользователя"].СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Пользователь.Установить(ПараметрыНапоминания.Пользователь);
	НаборЗаписей.Отбор.Источник.Установить(ПараметрыНапоминания.Источник);
	
	Если ОбновитьСрокНапоминания Тогда
		НаборЗаписей.Отбор.ВремяСобытия.Установить(ПараметрыНапоминания.ВремяСобытия);
		НаборЗаписей.Прочитать();
		Если НаборЗаписей.Количество() = 0 Тогда
			Возврат;
		КонецЕсли;
		Для Каждого Запись Из НаборЗаписей Цикл
			ЗаполнитьЗначенияСвойств(Запись, ПараметрыНапоминания);
		КонецЦикла;
	Иначе
		НаборЗаписей.Прочитать();
		Если НаборЗаписей.Количество() > 0 Тогда
			ЗанятоеВремя = НаборЗаписей.Выгрузить(,"ВремяСобытия").ВыгрузитьКолонку("ВремяСобытия");
			Пока ЗанятоеВремя.Найти(ПараметрыНапоминания.ВремяСобытия) <> Неопределено Цикл
				ПараметрыНапоминания.ВремяСобытия = ПараметрыНапоминания.ВремяСобытия + 1;
			КонецЦикла;
		КонецЕсли;
		НоваяЗапись = НаборЗаписей.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяЗапись, ПараметрыНапоминания);
	КонецЕсли;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры

// Проверяет физическое наличие записи в информационной базе данных о переданном значении ссылки.
//
// Параметры:
//  ЛюбаяСсылка - значение любой ссылки информационной базы данных.
// 
// Возвращаемое значение:
//  Булево.
//
Функция сфпСсылкаСуществует(ЛюбаяСсылка) Экспорт
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Ссылка КАК Ссылка
	|ИЗ
	|	[ИмяТаблицы]
	|ГДЕ
	|	Ссылка = &Ссылка
	|";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "[ИмяТаблицы]", сфпИмяТаблицыПоСсылке(ЛюбаяСсылка));
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("Ссылка", ЛюбаяСсылка);
	
	УстановитьПривилегированныйРежим(Истина);
	
	Возврат НЕ Запрос.Выполнить().Пустой();
	
КонецФункции

// Возвращает доступность хотя бы одной из указанных ролей или полноправность
// пользователя (текущего или указанного) без учета привилегированного режима.
//
// Параметры:
//  ИменаРолей   - Строка - имена ролей, разделенные запятыми, доступность которых проверяется.
//
//  Пользователь - Неопределено - проверяется текущий пользователь ИБ;
//                 СправочникСсылка.Пользователи,
//                 СправочникСсылка.ВнешниеПользователи - осуществляется поиск
//                    пользователя ИБ по уникальному идентификатору,
//                    заданному в реквизите ИдентификаторПользователяИБ
//                    Прим.: если пользователь ИБ не найден, возвращается Ложь.
//                 ПользовательИнформационнойБазы - проверяется указанный
//                    пользователь ИБ
//
// Возвращаемое значение:
//  Булево - Истина, если хотя бы одна из указанных ролей доступна,
//           или функция ЭтоПолноправныйПользователь(Пользователь) возвращает Истина.
//
Функция сфпРолиДоступны(Знач ИменаРолей, Пользователь = Неопределено) Экспорт
	
	Если сфпЭтоПолноправныйПользователь(Пользователь, , Ложь) Тогда
		Возврат Истина;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Пользователь = Неопределено ИЛИ Пользователь = сфпАвторизованныйПользователь() Тогда
		ПользовательИБ = ПользователиИнформационнойБазы.ТекущийПользователь();
		
	ИначеЕсли ТипЗнч(Пользователь) = Тип("ПользовательИнформационнойБазы") Тогда
		ПользовательИБ = Пользователь;
		
	Иначе
		// Указан не текущий пользователь.
		ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(
			сфпЗначениеРеквизитаОбъекта(Пользователь, "ИдентификаторПользователяИБ"));
		
		Если ПользовательИБ = Неопределено Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	
	УказанТекущийПользовательИБ = ПользовательИБ.УникальныйИдентификатор = ПользователиИнформационнойБазы.ТекущийПользователь().УникальныйИдентификатор;
	
	МассивИменРолей = сфпОбщегоНазначенияКлиентСервер.сфпРазложитьСтрокуВМассивПодстрок(ИменаРолей);
	Для каждого ИмяРоли Из МассивИменРолей Цикл
		
		Если УказанТекущийПользовательИБ Тогда
			Если РольДоступна(СокрЛП(ИмяРоли)) Тогда
				Возврат Истина;
			КонецЕсли;
		Иначе
			Если ПользовательИБ.Роли.Содержит(Метаданные.Роли.Найти(СокрЛП(ИмяРоли))) Тогда
				Возврат Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

// Подставляет параметры в строку. Максимально возможное число параметров - 9.
// Параметры в строке задаются как %<номер параметра>. Нумерация параметров начинается с единицы.
//
// Параметры:
//  СтрокаПодстановки  - Строка - шаблон строки с параметрами (вхождениями вида "%ИмяПараметра");
//  Параметр<n>        - Строка - подставляемый параметр.
//
// Возвращаемое значение:
//  Строка   - текстовая строка с подставленными параметрами.
//
// Пример:
//  ПодставитьПараметрыВСтроку(НСтр("ru='%1 пошел в %2'"), "Вася", "Зоопарк") = "Вася пошел в Зоопарк".
//
// Примечание:
//  В случаях, когда число используемых параметров в строке совпадает с числом переданных для подстановки параметров,
//  рекомендуется использовать функцию платформы СтрШаблон.
Функция сфпПодставитьПараметрыВСтроку(Знач СтрокаПодстановки,
	Знач Параметр1, Знач Параметр2 = Неопределено, Знач Параметр3 = Неопределено,
	Знач Параметр4 = Неопределено, Знач Параметр5 = Неопределено, Знач Параметр6 = Неопределено,
	Знач Параметр7 = Неопределено, Знач Параметр8 = Неопределено, Знач Параметр9 = Неопределено) 
	
	ИспользоватьАльтернативныйАлгоритм = 
		Найти(Параметр1, "%")
		Или Найти(Параметр2, "%")
		Или Найти(Параметр3, "%")
		Или Найти(Параметр4, "%")
		Или Найти(Параметр5, "%")
		Или Найти(Параметр6, "%")
		Или Найти(Параметр7, "%")
		Или Найти(Параметр8, "%")
		Или Найти(Параметр9, "%");
		
	Если ИспользоватьАльтернативныйАлгоритм Тогда
		СтрокаПодстановки = сфпПодставитьПараметрыВСтрокуАльтернативныйАлгоритм(СтрокаПодстановки, Параметр1,
			Параметр2, Параметр3, Параметр4, Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	Иначе
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%1", Параметр1);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%2", Параметр2);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%3", Параметр3);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%4", Параметр4);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%5", Параметр5);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%6", Параметр6);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%7", Параметр7);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%8", Параметр8);
		СтрокаПодстановки = СтрЗаменить(СтрокаПодстановки, "%9", Параметр9);
	КонецЕсли;
	
	Возврат СтрокаПодстановки;
КонецФункции

// Функция - аналог платформенной функции СтрРазделить (см. Справку)
//
Функция сфпРазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",",
	Знач ПропускатьПустыеСтроки = Неопределено)
	
	Результат = Новый Массив;
	
	// для обеспечения обратной совместимости
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
	//
	
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Результат.Добавить(Строка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции  

// Вставляет параметры в строку, учитывая, что в параметрах могут использоваться подстановочные слова %1, %2 и т.д.
Функция сфпПодставитьПараметрыВСтрокуАльтернативныйАлгоритм(Знач СтрокаПодстановки,
	Знач Параметр1, Знач Параметр2 = Неопределено, Знач Параметр3 = Неопределено,
	Знач Параметр4 = Неопределено, Знач Параметр5 = Неопределено, Знач Параметр6 = Неопределено,
	Знач Параметр7 = Неопределено, Знач Параметр8 = Неопределено, Знач Параметр9 = Неопределено)
	
	Результат = "";
	Позиция = Найти(СтрокаПодстановки, "%");
	Пока Позиция > 0 Цикл 
		Результат = Результат + Лев(СтрокаПодстановки, Позиция - 1);
		СимволПослеПроцента = Сред(СтрокаПодстановки, Позиция + 1, 1);
		ПодставляемыйПараметр = "";
		Если СимволПослеПроцента = "1" Тогда
			ПодставляемыйПараметр =  Параметр1;
		ИначеЕсли СимволПослеПроцента = "2" Тогда
			ПодставляемыйПараметр =  Параметр2;
		ИначеЕсли СимволПослеПроцента = "3" Тогда
			ПодставляемыйПараметр =  Параметр3;
		ИначеЕсли СимволПослеПроцента = "4" Тогда
			ПодставляемыйПараметр =  Параметр4;
		ИначеЕсли СимволПослеПроцента = "5" Тогда
			ПодставляемыйПараметр =  Параметр5;
		ИначеЕсли СимволПослеПроцента = "6" Тогда
			ПодставляемыйПараметр =  Параметр6;
		ИначеЕсли СимволПослеПроцента = "7" Тогда
			ПодставляемыйПараметр =  Параметр7
		ИначеЕсли СимволПослеПроцента = "8" Тогда
			ПодставляемыйПараметр =  Параметр8;
		ИначеЕсли СимволПослеПроцента = "9" Тогда
			ПодставляемыйПараметр =  Параметр9;
		КонецЕсли;
		Если ПодставляемыйПараметр = "" Тогда
			Результат = Результат + "%";
			СтрокаПодстановки = Сред(СтрокаПодстановки, Позиция + 1);
		Иначе
			Результат = Результат + ПодставляемыйПараметр;
			СтрокаПодстановки = Сред(СтрокаПодстановки, Позиция + 2);
		КонецЕсли;
		Позиция = Найти(СтрокаПодстановки, "%");
	КонецЦикла;
	Результат = Результат + СтрокаПодстановки;
	
	Возврат Результат;
КонецФункции

// Возвращает ближайшую дату по расписанию относительно даты, переданной в параметре.
//
// Параметры:
//  Расписание - РасписаниеРегламентногоЗадания - любое расписание.
//  ПредыдущаяДата - Дата - дата предыдущего события по расписанию.
//
// Возвращаемое значение:
//   Дата - дата и время следующего события по расписанию.
//
Функция сфпПолучитьБлижайшуюДатуСобытияПоРасписанию(Расписание, ПредыдущаяДата = '000101010000') 

	Результат = Неопределено;
	ТекущаяДатаСеанса = ТекущаяДатаСеанса();
	
	ДатаОтсчета = ПредыдущаяДата;
	Если Не ЗначениеЗаполнено(ДатаОтсчета) Тогда
		ДатаОтсчета = ТекущаяДатаСеанса;
	КонецЕсли;
	ДатаОтсчета = Макс(ДатаОтсчета, ТекущаяДатаСеанса);
	
	Календарь = сфпПолучитьКалендарьНаБудущее(365*4+1, ДатаОтсчета, Расписание.ДатаНачала, Расписание.ПериодПовтораДней, Расписание.ПериодНедель);
	
	ДниНедели = Расписание.ДниНедели;
	Если ДниНедели.Количество() = 0 Тогда
		ДниНедели = Новый Массив;
		Для День = 1 По 7 Цикл
			ДниНедели.Добавить(День);
		КонецЦикла;
	КонецЕсли;
	
	Месяцы = Расписание.Месяцы;
	Если Месяцы.Количество() = 0 Тогда
		Месяцы = Новый Массив;
		Для Месяц = 1 По 12 Цикл
			Месяцы.Добавить(Месяц);
		КонецЦикла;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Текст = "ВЫБРАТЬ * ПОМЕСТИТЬ Календарь ИЗ &Календарь КАК Календарь";
	Запрос.УстановитьПараметр("Календарь", Календарь);
	Запрос.Выполнить();
	
	Запрос.УстановитьПараметр("ДатаНачала",			Расписание.ДатаНачала);
	Запрос.УстановитьПараметр("ДатаКонца",			Расписание.ДатаКонца);
	Запрос.УстановитьПараметр("ДниНедели",			ДниНедели);
	Запрос.УстановитьПараметр("Месяцы",				Месяцы);
	Запрос.УстановитьПараметр("ДеньВМесяце",		Расписание.ДеньВМесяце);
	Запрос.УстановитьПараметр("ДеньНеделиВМесяце",	Расписание.ДеньНеделиВМесяце);
	Запрос.УстановитьПараметр("ПериодПовтораДней",	?(Расписание.ПериодПовтораДней = 0,1,Расписание.ПериодПовтораДней));
	Запрос.УстановитьПараметр("ПериодНедель",		?(Расписание.ПериодНедель = 0,1,Расписание.ПериодНедель));
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Календарь.Дата,
	|	Календарь.НомерМесяца,
	|	Календарь.НомерДняНеделиВМесяце,
	|	Календарь.НомерДняНеделиСКонцаМесяца,
	|	Календарь.НомерДняВМесяце,
	|	Календарь.НомерДняВМесяцеСКонцаМесяца,
	|	Календарь.НомерДняВНеделе,
	|	Календарь.НомерДняВПериоде,
	|	Календарь.НомерНеделиВПериоде
	|ИЗ
	|	Календарь КАК Календарь
	|ГДЕ
	|	ВЫБОР
	|			КОГДА &ДатаНачала = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ Календарь.Дата >= &ДатаНачала
	|		КОНЕЦ
	|	И ВЫБОР
	|			КОГДА &ДатаКонца = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ Календарь.Дата <= &ДатаКонца
	|		КОНЕЦ
	|	И Календарь.НомерДняВНеделе В(&ДниНедели)
	|	И Календарь.НомерМесяца В(&Месяцы)
	|	И ВЫБОР
	|			КОГДА &ДеньВМесяце = 0
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ ВЫБОР
	|					КОГДА &ДеньВМесяце > 0
	|						ТОГДА Календарь.НомерДняВМесяце = &ДеньВМесяце
	|					ИНАЧЕ Календарь.НомерДняВМесяцеСКонцаМесяца = -&ДеньВМесяце
	|				КОНЕЦ
	|		КОНЕЦ
	|	И ВЫБОР
	|			КОГДА &ДеньНеделиВМесяце = 0
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ ВЫБОР
	|					КОГДА &ДеньНеделиВМесяце > 0
	|						ТОГДА Календарь.НомерДняНеделиВМесяце = &ДеньНеделиВМесяце
	|					ИНАЧЕ Календарь.НомерДняНеделиСКонцаМесяца = -&ДеньНеделиВМесяце
	|				КОНЕЦ
	|		КОНЕЦ
	|	И Календарь.НомерДняВПериоде = &ПериодПовтораДней
	|	И Календарь.НомерНеделиВПериоде = &ПериодНедель";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		БлижайшаяДата = Выборка.Дата;
		ВремяОтсчета = '00010101';
		Если НачалоДня(БлижайшаяДата) = НачалоДня(ДатаОтсчета) Тогда
			ВремяОтсчета = ВремяОтсчета + (ДатаОтсчета-НачалоДня(ДатаОтсчета));
		КонецЕсли;
		
		БлижайшееВремя = сфпПолучитьБлижайшееВремяИзРасписания(Расписание, ВремяОтсчета);
		Если БлижайшееВремя <> Неопределено Тогда
			Результат = БлижайшаяДата + (БлижайшееВремя - '00010101');
		Иначе
			Если Выборка.Следующий() Тогда
				Время = сфпПолучитьБлижайшееВремяИзРасписания(Расписание);
				Результат = Выборка.Дата + (Время - '00010101');
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция сфпПолучитьКалендарьНаБудущее(КоличествоДнейКалендаря, ДатаОтсчета, Знач ДатаНачалаПериодичности = Неопределено, Знач ПериодДней = 1, Знач ПериодНедель = 1) 
	
	Если ПериодНедель = 0 Тогда 
		ПериодНедель = 1;
	КонецЕсли;
	
	Если ПериодДней = 0 Тогда
		ПериодДней = 1;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ДатаНачалаПериодичности) Тогда
		ДатаНачалаПериодичности = ДатаОтсчета;
	КонецЕсли;
	
	Календарь = Новый ТаблицаЗначений;
	Календарь.Колонки.Добавить("Дата", Новый ОписаниеТипов("Дата",,,Новый КвалификаторыДаты()));
	Календарь.Колонки.Добавить("НомерМесяца", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(2,0,ДопустимыйЗнак.Неотрицательный)));
	Календарь.Колонки.Добавить("НомерДняНеделиВМесяце", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(1,0,ДопустимыйЗнак.Неотрицательный)));
	Календарь.Колонки.Добавить("НомерДняНеделиСКонцаМесяца", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(1,0,ДопустимыйЗнак.Неотрицательный)));
	Календарь.Колонки.Добавить("НомерДняВМесяце", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(2,0,ДопустимыйЗнак.Неотрицательный)));
	Календарь.Колонки.Добавить("НомерДняВМесяцеСКонцаМесяца", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(2,0,ДопустимыйЗнак.Неотрицательный)));
	Календарь.Колонки.Добавить("НомерДняВНеделе", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(2,0,ДопустимыйЗнак.Неотрицательный)));	
	Календарь.Колонки.Добавить("НомерДняВПериоде", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(3,0,ДопустимыйЗнак.Неотрицательный)));	
	Календарь.Колонки.Добавить("НомерНеделиВПериоде", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(3,0,ДопустимыйЗнак.Неотрицательный)));
	
	Дата = НачалоДня(ДатаОтсчета);
	ДатаНачалаПериодичности = НачалоДня(ДатаНачалаПериодичности);
	НомерДняВПериоде = 0;
	НомерНеделиВПериоде = 0;
	
	Если ДатаНачалаПериодичности <= Дата Тогда
		КоличествоДней = (Дата - ДатаНачалаПериодичности)/60/60/24;
		НомерДняВПериоде = КоличествоДней - Цел(КоличествоДней/ПериодДней)*ПериодДней;
		
		КоличествоНедель = Цел(КоличествоДней / 7);
		НомерНеделиВПериоде = КоличествоНедель - Цел(КоличествоНедель/ПериодНедель)*ПериодНедель;
	КонецЕсли;
	
	Если НомерДняВПериоде = 0 Тогда 
		НомерДняВПериоде = ПериодДней;
	КонецЕсли;
	
	Если НомерНеделиВПериоде = 0 Тогда 
		НомерНеделиВПериоде = ПериодНедель;
	КонецЕсли;
	
	Для Счетчик = 0 По КоличествоДнейКалендаря - 1 Цикл
		
		Дата = НачалоДня(ДатаОтсчета) + Счетчик * 60*60*24;
		НоваяСтрока = Календарь.Добавить();
		НоваяСтрока.Дата = Дата;
		НоваяСтрока.НомерМесяца = Месяц(Дата);
		НоваяСтрока.НомерДняНеделиВМесяце = Цел((Дата - НачалоМесяца(Дата))/60/60/24/7) + 1;
		НоваяСтрока.НомерДняНеделиСКонцаМесяца = Цел((КонецМесяца(НачалоДня(Дата)) - Дата)/60/60/24/7) + 1;
		НоваяСтрока.НомерДняВМесяце = День(Дата);
		НоваяСтрока.НомерДняВМесяцеСКонцаМесяца = День(КонецМесяца(НачалоДня(Дата))) - День(Дата) + 1;
		НоваяСтрока.НомерДняВНеделе = ДеньНедели(Дата);
		
		Если ДатаНачалаПериодичности <= Дата Тогда
			НоваяСтрока.НомерДняВПериоде = НомерДняВПериоде;
			НоваяСтрока.НомерНеделиВПериоде = НомерНеделиВПериоде;
			
			НомерДняВПериоде = ?(НомерДняВПериоде+1 > ПериодДней, 1, НомерДняВПериоде+1);
			
			Если НоваяСтрока.НомерДняВНеделе = 1 Тогда
				НомерНеделиВПериоде = ?(НомерНеделиВПериоде+1 > ПериодНедель, 1, НомерНеделиВПериоде+1);
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Календарь;
	
КонецФункции

Функция сфпПолучитьБлижайшееВремяИзРасписания(Расписание, Знач ВремяОтсчета = '000101010000')
	
	Результат = Неопределено;
	
	СписокЗначений = Новый СписокЗначений;
	
	Если Расписание.ДетальныеРасписанияДня.Количество() = 0 Тогда
		СписокЗначений.Добавить(Расписание.ВремяНачала);
	Иначе
		Для Каждого РасписаниеДня Из Расписание.ДетальныеРасписанияДня Цикл
			СписокЗначений.Добавить(РасписаниеДня.ВремяНачала);
		КонецЦикла;
	КонецЕсли;
	
	СписокЗначений.СортироватьПоЗначению(НаправлениеСортировки.Возр);
	
	Для Каждого ВремяДня Из СписокЗначений Цикл
		Если ВремяОтсчета <= ВремяДня.Значение Тогда
			Результат = ВремяДня.Значение;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Возвращает полное имя объекта метаданных по переданному значению ссылки.
// Примеры:
//  "Справочник.Номенклатура";
//  "Документ.ПриходнаяНакладная".
//
// Параметры:
//  Ссылка - ЛюбаяСсылка - объект, для которого необходимо получить имя таблицы ИБ.
// 
// Возвращаемое значение:
//  Строка - полное имя объекта метаданных для указанного объекта.
//
Функция сфпИмяТаблицыПоСсылке(Ссылка) Экспорт
	
	Возврат Ссылка.Метаданные().ПолноеИмя();
	
КонецФункции

Функция сфпАвторизованныйПользователь()
	
	Возврат сфпОбщегоНазначенияКлиентСервер.сфпАвторизованныйПользователь();
	
КонецФункции

// Проверяет, является ли текущий или указанный пользователь полноправным.
// 
// Полноправным считается пользователь, который
// а) при не пустом списке пользователей информационной базы:
// - в локальном режиме работы (без разделения данных) имеет роль ПолныеПрава и
//   роль для администрирования системы,
// - в модели сервиса (с разделением данных) имеет роль ПолныеПрава;
// б) при пустом списке пользователей информационной базы
//    основная роль конфигурации не задана или ПолныеПрава.
//
// Параметры:
//  Пользователь - Неопределено - проверяется текущий пользователь ИБ;
//                 СправочникСсылка.Пользователи,
//                 СправочникСсылка.ВнешниеПользователи - осуществляется поиск
//                    пользователя ИБ по уникальному идентификатору,
//                    заданному в реквизите ИдентификаторПользователяИБ.
//                    Прим.: если пользователь ИБ не найден, возвращается Ложь.
//                 ПользовательИнформационнойБазы - проверяется указанный
//                    пользователь ИБ.
//
//  ПроверятьПраваАдминистрированияСистемы - Булево - если задано Истина, тогда
//                 проверяется наличие роли для администрирования системы.
//                 Начальное значение: Ложь.
//
//  УчитыватьПривилегированныйРежим - Булево - если задано Истина, тогда
//                 функция возвращает Истина, когда установлен привилегированный режим.
//                 Начальное значение: Истина.
//
// Возвращаемое значение:
//  Булево.
//
Функция сфпЭтоПолноправныйПользователь(Пользователь = Неопределено,
                                    ПроверятьПраваАдминистрированияСистемы = Ложь,
                                    УчитыватьПривилегированныйРежим = Истина) Экспорт
	
	Если УчитыватьПривилегированныйРежим И ПривилегированныйРежим() Тогда
		Возврат Истина;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	ТекущийПользовательИБ = ПользователиИнформационнойБазы.ТекущийПользователь();
	
	Если ТипЗнч(Пользователь) = Тип("ПользовательИнформационнойБазы") Тогда
		ПользовательИБ = Пользователь;
		
	ИначеЕсли Пользователь = Неопределено ИЛИ Пользователь = сфпАвторизованныйПользователь() Тогда
		ПользовательИБ = ТекущийПользовательИБ;
	Иначе
		
		Если Не ЗначениеЗаполнено(Пользователь) Тогда
			Возврат Ложь;
		КонецЕсли;
		
		// Задан не текущий пользователь.
		Если Не ЗначениеЗаполнено(Пользователь) Тогда
			Возврат Ложь;
		КонецЕсли;
		
		ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(
			сфпЗначениеРеквизитаОбъекта(Пользователь, "ИдентификаторПользователяИБ"));
		
		Если ПользовательИБ = Неопределено Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	
	ПроверитьРольПолныеПрава = Истина;
	ПроверитьРольАдминистратораСистемы = Истина;
	
	Если сфпОбщегоНазначенияПовтИсп.сфпРазделениеВключено() Тогда
		Если ПроверятьПраваАдминистрированияСистемы Тогда
			ПроверитьРольПолныеПрава = Ложь;
		Иначе
			ПроверитьРольАдминистратораСистемы = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	Если ПользовательИБ.УникальныйИдентификатор <> ТекущийПользовательИБ.УникальныйИдентификатор Тогда
		// Для не текущего пользователя ИБ проверяются роли в записанном пользователе ИБ.
		Если ПроверитьРольПолныеПрава
		   И НЕ ПользовательИБ.Роли.Содержит(Метаданные.Роли["ПолныеПрава"]) Тогда
			Возврат Ложь;
		КонецЕсли;
		Если ПроверитьРольАдминистратораСистемы
		   И НЕ ПользовательИБ.Роли.Содержит(сфпРольАдминистратораСистемы()) Тогда
			Возврат Ложь;
		КонецЕсли;
		Возврат Истина;
	Иначе
		Если сфпОбщегоНазначенияПовтИсп.сфпПривилегированныйРежимУстановленПриЗапуске() Тогда
			// Когда клиентское приложение запущено с параметром UsePrivilegedMode, тогда
			// пользователь является полноправным, если привилегированный режим установлен.
			Возврат Истина;
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(ПользовательИБ.Имя) И Метаданные.ОсновныеРоли.Количество() = 0 Тогда
			// Когда основная роль не указана, тогда у неуказанного пользователя
			// есть все права (как в привилегированном режиме).
			Возврат Истина;
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(ПользовательИБ.Имя)
		   И ПривилегированныйРежим()
		   И ПравоДоступа("Администрирование", Метаданные, ПользовательИБ) Тогда
			// Когда у неуказанного пользователя есть право Администрирование,
			// тогда привилегированный режим учитывается всегда для поддержки
			// параметра запуска UsePrivilegedMode у не клиентских приложений.
			Возврат Истина;
		КонецЕсли;
		
		// Для текущего пользователя ИБ проверяются роли не в записанном пользователе ИБ,
		// а роли в текущем сеансе.
		Если ПроверитьРольПолныеПрава
		   И НЕ РольДоступна("ПолныеПрава") Тогда
			Возврат Ложь;
		КонецЕсли;
		Если ПроверитьРольАдминистратораСистемы
		   И НЕ РольДоступна(сфпРольАдминистратораСистемы()) Тогда
			Возврат Ложь;
		КонецЕсли;
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

// Возвращает роль, предоставляющую права администрирования системы.
//
// Возвращаемое значение:
//  ОбъектМетаданных: Роль.
//
Функция сфпРольАдминистратораСистемы() Экспорт
	
	Если Метаданные.Роли.Найти("АдминистраторСистемы") = Неопределено Тогда
		РольАдминистратораСистемы = Метаданные.Роли["ПолныеПрава"];
		Если ПравоДоступа("Администрирование", Метаданные, РольАдминистратораСистемы) Тогда
			Возврат РольАдминистратораСистемы;
		Иначе
			Возврат Метаданные.Роли.Получить(1);
		КонецЕсли;
	Иначе
		Если ПравоДоступа("Администрирование", Метаданные, Метаданные.Роли["ПолныеПрава"]) Тогда
			Возврат Метаданные.Роли["ПолныеПрава"];
		Иначе
			Возврат Метаданные.Роли["АдминистраторСистемы"];
		КонецЕсли;
	КонецЕсли;	
	  
КонецФункции

