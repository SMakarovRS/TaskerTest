﻿
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьПоУмолчанию(Команда)
	ЗаполнитьПоУмолчаниюНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьПоУмолчаниюНаСервере()
	Справочники.СостоянияСобытий.ЗаполнитьСостоянияСобытийПриПервоначальномЗаполнении();
КонецПроцедуры

#КонецОбласти