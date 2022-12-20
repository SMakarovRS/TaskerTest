﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Определение цветов выделения результатов проверки контрагентов.
//
// Возвращаемое значение:
//  Структура - Имена ключей - это названия цветов, которые необходимо определить.
//
Функция ЦветаРезультатовПроверки() Экспорт
	
	Возврат ПроверкаКонтрагентов.ЦветаРезультатовПроверки();
	
КонецФункции

// Свойства справочника контрагенты.
// Предназначена для определения имени справочника, имени реквизитов ИНН и КПП.
//
// Возвращаемое значение:
//  Соответствие - Соответствие с ключами Имя, ИНН и КПП справочника контрагенты.
//
Функция СвойстваСправочниковКонтрагенты() Экспорт
	
	Возврат ПроверкаКонтрагентов.СвойстваСправочниковКонтрагенты();
	
КонецФункции

#КонецОбласти