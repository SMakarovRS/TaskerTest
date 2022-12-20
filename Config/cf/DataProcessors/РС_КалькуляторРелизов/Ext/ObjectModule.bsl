﻿
Процедура ПолучитьСписокРелизов() Экспорт
	
	Этап = 0;
	
	ТаблицаПереходов = Новый ТаблицаЗначений;
	ТаблицаПереходов.Колонки.Добавить("Версия", Новый ОписаниеТипов("СправочникСсылка.РС_ВерсииКонфигураций"));
	ТаблицаПереходов.Колонки.Добавить("ПереходНаВерсию", Новый ОписаниеТипов("СправочникСсылка.РС_ВерсииКонфигураций"));
	
	КЧ = Новый КвалификаторыЧисла(12,2);
	Массив = Новый Массив;
	Массив.Добавить(Тип("Число"));
	ОписаниеТиповЧ = Новый ОписаниеТипов(Массив, , ,КЧ);
	ТаблицаПереходов.Колонки.Добавить("Этап", ОписаниеТиповЧ);
	
	НоваяСтрокаТаблицыПереходов = ТаблицаПереходов.Добавить();
	НоваяСтрокаТаблицыПереходов.Версия = ТребуемаяВерсия;
	НоваяСтрокаТаблицыПереходов.Этап = Этап;
	
	ЗаполнитьТаблицуПереходовРекурсивно(ТаблицаПереходов, Этап);
	
	СписокРелизов.Загрузить(ТаблицаПереходов);
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуПереходовРекурсивно(ТаблицаПереходов, Этап)
	
	Запрос = Новый Запрос;
	Запрос.Текст = ПолучитьТекстЗапроса_ТаблицаПереходов();
	
	Запрос.УстановитьПараметр("Конфигурация", Конфигурация);
	Запрос.УстановитьПараметр("ТекущаяВерсия", ТекущаяВерсия);
	Запрос.УстановитьПараметр("Этап", Этап);
	Запрос.УстановитьПараметр("ТаблицаПереходов", ТаблицаПереходов);
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	
	ТаблицаПереходов = РезультатЗапроса[РезультатЗапроса.Количество() - 2].Выгрузить();
	ВыборкаПоследнийЭтап = РезультатЗапроса[РезультатЗапроса.Количество() - 1].Выбрать();
	
	Если ВыборкаПоследнийЭтап.Следующий() 
		И Не ВыборкаПоследнийЭтап.ЭтоПоследнийЭтап Тогда
		
		Этап = Этап + 1;
		ЗаполнитьТаблицуПереходовРекурсивно(ТаблицаПереходов, Этап);
		
	Иначе
		
		ОчиститьТаблицуПереходовОтЛишнихВерсий(ТаблицаПереходов);
		
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьТекстЗапроса_ТаблицаПереходов()
	
	Возврат "ВЫБРАТЬ
	|	ТаблицаПереходов.Версия КАК Версия,
	|	ТаблицаПереходов.ПереходНаВерсию КАК ПереходНаВерсию,
	|	ТаблицаПереходов.Этап КАК Этап
	|ПОМЕСТИТЬ ТЗ_ТаблицаПереходов
	|ИЗ
	|	&ТаблицаПереходов КАК ТаблицаПереходов
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТЗ_ТаблицаПереходов.Версия КАК Версия,
	|	ТЗ_ТаблицаПереходов.ПереходНаВерсию КАК ПереходНаВерсию,
	|	ТЗ_ТаблицаПереходов.Этап КАК Этап
	|ПОМЕСТИТЬ ВТ_ТекущийЭтап
	|ИЗ
	|	ТЗ_ТаблицаПереходов КАК ТЗ_ТаблицаПереходов
	|ГДЕ
	|	ТЗ_ТаблицаПереходов.Этап = &Этап
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РС_ПереходыВерсийКонфигураций.СтараяВерсия КАК Версия,
	|	РС_ПереходыВерсийКонфигураций.НоваяВерсия КАК ПереходНаВерсию
	|ПОМЕСТИТЬ ВТ_НовыйЭтап
	|ИЗ
	|	РегистрСведений.РС_ПереходыВерсийКонфигураций КАК РС_ПереходыВерсийКонфигураций
	|ГДЕ
	|	РС_ПереходыВерсийКонфигураций.Конфигурация = &Конфигурация
	|	И РС_ПереходыВерсийКонфигураций.НоваяВерсия В
	|			(ВЫБРАТЬ
	|				ВТ_ТекущийЭтап.Версия КАК Версия
	|			ИЗ
	|				ВТ_ТекущийЭтап КАК ВТ_ТекущийЭтап)
	|	И НЕ РС_ПереходыВерсийКонфигураций.СтараяВерсия В
	|				(ВЫБРАТЬ
	|					ТЗ_ТаблицаПереходов.Версия КАК Версия
	|				ИЗ
	|					ТЗ_ТаблицаПереходов КАК ТЗ_ТаблицаПереходов)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТЗ_ТаблицаПереходов.Версия КАК Версия,
	|	ТЗ_ТаблицаПереходов.ПереходНаВерсию КАК ПереходНаВерсию,
	|	ТЗ_ТаблицаПереходов.Этап КАК Этап
	|ИЗ
	|	ТЗ_ТаблицаПереходов КАК ТЗ_ТаблицаПереходов
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВТ_НовыйЭтап.Версия,
	|	ВТ_НовыйЭтап.ПереходНаВерсию,
	|	&Этап + 1
	|ИЗ
	|	ВТ_НовыйЭтап КАК ВТ_НовыйЭтап
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЕСТЬNULL(МАКСИМУМ(ВТ_НовыйЭтап.Версия = &ТекущаяВерсия), ИСТИНА) КАК ЭтоПоследнийЭтап
	|ИЗ
	|	ВТ_НовыйЭтап КАК ВТ_НовыйЭтап";
	
КонецФункции

Процедура ОчиститьТаблицуПереходовОтЛишнихВерсий(ТаблицаПереходов)
	
	ИскомаяВерсия = ТекущаяВерсия;
	
	ТаблицаПереходовСжатая = ТаблицаПереходов.СкопироватьКолонки();
	
	Пока ЗначениеЗаполнено(ИскомаяВерсия) Цикл
		
		НайденнаяСтрока = ТаблицаПереходов.Найти(ИскомаяВерсия);
		Если НайденнаяСтрока = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		НоваяСтрока = ТаблицаПереходовСжатая.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, НайденнаяСтрока);
		
		ИскомаяВерсия = НайденнаяСтрока.ПереходНаВерсию;
		
	КонецЦикла;
	
	ТаблицаПереходов = ТаблицаПереходовСжатая;
	
КонецПроцедуры

