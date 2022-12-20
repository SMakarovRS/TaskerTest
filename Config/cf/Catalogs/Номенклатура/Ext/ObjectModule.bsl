﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// См. описание в комментарии к одноименной процедуре в модуле УправлениеДоступом.
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	// Логика ограничения:
	// Чтения:                Без ограничения.
	// Изменения:             Без ограничения.
	
	// Чтение, Добавление, Изменение: набор №0.
	Строка = Таблица.Добавить();
	Строка.ЗначениеДоступа = Перечисления.ДополнительныеЗначенияДоступа.ДоступРазрешен;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

// Для внутреннего использования.
// 
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	// Проверка на наличие дублей по наименованию и виду номенклатуры.
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Режим",  "КонтрольПоНаименованию");
	ДополнительныеПараметры.Вставить("Ссылка", Ссылка);
	
	Дубли = ПоискИУдалениеДублей.НайтиДублиЭлемента("Справочник.Номенклатура", ЭтотОбъект, ДополнительныеПараметры);
	Если Дубли.Количество() > 0 Тогда
		Ошибка = НСтр("ru = 'Номенклатура с таким наименованием и видом уже существует.'");
		ОбщегоНазначения.СообщитьПользователю(Ошибка, , "Объект.Наименование", , Отказ);
	КонецЕсли;
	
КонецПроцедуры
	
Процедура ПередЗаписью(Отказ)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Ошибки = Неопределено;
	
	// Проверка, можно ли менять ВидНоменклатуры (если уже есть документы по данной номенклатуре).
	Если НЕ ЭтоНовый() Тогда
		Если ВидНоменклатуры <> Ссылка.ВидНоменклатуры Тогда
			Запрос = Новый Запрос();
			Запрос.Текст =
				"ВЫБРАТЬ
				|	Количество(Номенклатура.Ссылка) КАК КоличествоДокументов
				|ИЗ
				|	КритерийОтбора.Номенклатура(&Номенклатура) КАК Номенклатура";
				
			Запрос.УстановитьПараметр("Номенклатура", Ссылка);
			Выборка = Запрос.Выполнить().Выбрать();
			Выборка.Следующий();
			
			Если Выборка.КоличествоДокументов > 0 Тогда
				// Документы уже есть, поэтому отказываемся сохранять.
				ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "Объект.ВидНоменклатуры", НСтр("ru = 'Номенклатура уже использована в документах. Для нее нельзя изменить реквизит ""Вид номенклатуры""'"), "");
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
КонецПроцедуры

#КонецОбласти

#КонецЕсли