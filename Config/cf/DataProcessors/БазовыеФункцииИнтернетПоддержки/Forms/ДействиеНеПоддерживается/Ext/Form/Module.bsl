﻿
#Область ОписаниеПеременных

// Хранение контекста взаимодействия с сервисом
&НаКлиенте
Перем КонтекстВзаимодействия Экспорт; // Контекст взаимодействия

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если КонтекстВзаимодействия.Свойство("СообщениеОНедоступностиДействия") Тогда
		Элементы.ДекорацияСообщение.Заголовок = КонтекстВзаимодействия.СообщениеОНедоступностиДействия;
	Иначе
		Элементы.ДекорацияСообщение.Заголовок = НСтр("ru = 'Выбранное действие недоступно для этой конфигурации.'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти