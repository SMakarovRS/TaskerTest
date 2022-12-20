﻿
// Добавляет команду создания документа "Занятость - Планерка".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОснованииЗаданиеПланерки(КомандыСозданияНаОсновании) Экспорт
	//++РС Консалт: Минаков А.С.
	Если ПравоДоступа("Добавление", Метаданные.Документы.РС_Занятость) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РС_Занятость.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = "Планерка";
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;

	Возврат Неопределено;
	//++РС Консалт: Минаков А.С.
КонецФункции

// Добавляет команду создания документа "Занятость - Отгул".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОснованииЗаданиеОтгулы(КомандыСозданияНаОсновании) Экспорт
	//++РС Консалт: Минаков А.С.
	Если ПравоДоступа("Добавление", Метаданные.Документы.РС_Занятость) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РС_Занятость.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = "Отгул";
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;

	Возврат Неопределено;
	//++РС Консалт: Минаков А.С.
КонецФункции

// Добавляет команду создания документа "Занятость - Внутренние работы".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОснованииЗаданиеВнутрРаботы(КомандыСозданияНаОсновании) Экспорт
	//++РС Консалт: Минаков А.С.
	Если ПравоДоступа("Добавление", Метаданные.Документы.РС_Занятость) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РС_Занятость.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = "Внутренние работы(занятости)";
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;

	Возврат Неопределено;
	//++РС Консалт: Минаков А.С.
КонецФункции

// Добавляет команду создания документа "Занятость - Обучение".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОснованииЗаданиеОбучение(КомандыСозданияНаОсновании) Экспорт
	//++РС Консалт: Минаков А.С.
	Если ПравоДоступа("Добавление", Метаданные.Документы.РС_Занятость) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РС_Занятость.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = "Обучение";
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;

	Возврат Неопределено;
	//++РС Консалт: Минаков А.С.
КонецФункции

