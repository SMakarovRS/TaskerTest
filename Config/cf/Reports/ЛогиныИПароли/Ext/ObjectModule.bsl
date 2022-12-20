﻿#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	Настройки = КомпоновщикНастроек.Настройки;	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ТекущийПользователь", ТекущийПользователь);
	Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("СписокГруппТекущегоПользователя", 
		УправлениеITОтделом8УФ.СписокПодчиненныхИГруппПользователя(ТекущийПользователь));
	
	СтандартнаяОбработка = Ложь;

	// Подготовим и выведем отчет.
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	
	НастройкиКомпоновкиДанных	= КомпоновщикНастроек.ПолучитьНастройки();
	МакетКомпоновки				= КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных,	ДанныеРасшифровки);
	
	ПроцессорКомпоновки			= Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ,	ДанныеРасшифровки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	ПроцессорВывода.НачатьВывод();
	ПроцессорВывода.Вывести(ПроцессорКомпоновки, Истина);
	ПроцессорВывода.ЗакончитьВывод();
	
	ОтчетПустой		= ОтчетыСервер.ОтчетПустой(ЭтотОбъект, ПроцессорКомпоновки);
	КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ОтчетПустой", ОтчетПустой);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли