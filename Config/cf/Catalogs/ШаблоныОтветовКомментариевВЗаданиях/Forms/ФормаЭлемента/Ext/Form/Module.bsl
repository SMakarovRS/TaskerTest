﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Объект.Ссылка.Пустая() Тогда
		Пользователь 		= Пользователи.ТекущийПользователь();
		Объект.ВидимостьШаблона = Перечисления.ВидимостьШаблонов.Личный;
		Объект.ВладелецШаблона 	= Пользователь;
	КонецЕсли;                                   
	
	ОбновитьДоступностьВидимостиШаблона();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ШаблонОповещения = ТекущийОбъект.ШаблонОповещения.Получить();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.ШаблонОповещения = Новый ХранилищеЗначения(ШаблонОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидимостьШаблонаПриИзменении(Элемент)
	
	ОбновитьДоступностьВидимостиШаблона();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьДоступностьВидимостиШаблона()
	
	Если Объект.ВидимостьШаблона = Перечисления.ВидимостьШаблонов.Личный Тогда
		
		Элементы.ВладелецШаблона.Видимость = Истина;
		Элементы.ВладелецШаблона.Доступность = Истина;
		МассивТипов = Новый Массив;
		МассивТипов.Добавить(Тип("СправочникСсылка.Пользователи"));
		Элементы.ВладелецШаблона.ОграничениеТипа = Новый ОписаниеТипов(МассивТипов, Новый КвалификаторыСтроки(200));
		Элементы.ВладелецШаблона.КнопкаВыбора = Истина;	
		
		Если Объект.ВладелецШаблона <> Пользователи.ТекущийПользователь() Тогда
			Объект.ВладелецШаблона = Пользователи.ТекущийПользователь();
		КонецЕсли;
		Элементы.ВладелецШаблона.Доступность = Ложь;
		
	ИначеЕсли Объект.ВидимостьШаблона = Перечисления.ВидимостьШаблонов.ГруппыПользователей Тогда
		
		Элементы.ВладелецШаблона.Видимость = Истина;
		Элементы.ВладелецШаблона.Доступность = Истина;
		МассивТипов = Новый Массив;
		МассивТипов.Добавить(Тип("СправочникСсылка.ГруппыПользователей"));
		Элементы.ВладелецШаблона.ОграничениеТипа = Новый ОписаниеТипов(МассивТипов, Новый КвалификаторыСтроки(200));
		Элементы.ВладелецШаблона.КнопкаВыбора = Истина;	
		
	Иначе
		
		Элементы.ВладелецШаблона.Доступность = Истина;
		МассивТипов = Новый Массив;
		МассивТипов.Добавить(Тип("СправочникСсылка.ГруппыПользователей"));
		МассивТипов.Добавить(Тип("СправочникСсылка.Пользователи"));
		Элементы.ВладелецШаблона.ОграничениеТипа = Новый ОписаниеТипов(МассивТипов, Новый КвалификаторыСтроки(200));
		Элементы.ВладелецШаблона.КнопкаВыбора = Истина;	
		Элементы.ВладелецШаблона.Видимость = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти