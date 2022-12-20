﻿#Область КлиентскиеПроцедурыИФункцииСофтФон

// Функция выполняет подключение к серверу СофтФона
//
// Параметры:
//	ПоказыватьСообщения - Булево - Показывать ли сообщения об ошибках подключения пользователю
//
// Возвращаемое значение:
//	Булево	- Результат подключения
//
Функция сфпПодключитьсяНативнаяКомпонента(ПоказыватьСообщения = Ложь) Экспорт
	
	#Если ВебКлиент Тогда
		
	ПоказатьПредупреждение(,НСтр("ru = 'Панель Софтфона не работает в web-клиенте'"));
	Возврат Ложь;
	
	#Иначе

	// Новый алгоритм получения пути установки
	Оболочка = Новый COMОбъект("WScript.Shell");
	КаталогДанныхПользователя = Оболочка.ExpandEnvironmentStrings("%APPDATA%");
	КаталогСофтфона = КаталогДанныхПользователя + "\1C-Rarus\1C-Rarus SoftPhone\";
	ПроверитьФайл = Новый Файл(КаталогСофтфона);
	Если НЕ ПроверитьФайл.Существует() Тогда
		Если ПоказыватьСообщения Тогда
			ПоказатьПредупреждение(,Нстр("ru = 'Не установлена панель Софтфона!'"));
		КонецЕсли;
		Возврат Ложь;
	КонецЕсли;					
	ФайлСофтфона = Новый ЧтениеТекста(КаталогСофтфона + "SoftPhoneClient.ini");
	ТекстФайла = ФайлСофтфона.Прочитать(1000);
	
	НомерСимволаПутиКПанели = Найти(ТекстФайла, "[ClientPath]");
	// проверка
	Если НомерСимволаПутиКПанели = 0 Тогда
		Если ПоказыватьСообщения Тогда
			ПоказатьПредупреждение(,Нстр("ru = 'Не удалось найти установленную панель Софтфона. Пожалуйста, переустановите панель!'"));
		КонецЕсли;
		Возврат Ложь;
	КонецЕсли;		
	ТекНомерСимвола = НомерСимволаПутиКПанели + 12;
	ПутьККомпоненте = "";
	Пока Сред(ТекстФайла,ТекНомерСимвола,1) <> "[" Цикл
		ПутьККомпоненте = ПутьККомпоненте + Сред(ТекстФайла,ТекНомерСимвола,1);
		ТекНомерСимвола = ТекНомерСимвола + 1;
	КонецЦикла;		
	
	СистемнаяИнформация = Новый СистемнаяИнформация;	
	ТипСистемы = СистемнаяИнформация.ТипПлатформы;
	Если ТипСистемы = ТипПлатформы.Linux_x86_64 
		ИЛИ ТипСистемы = ТипПлатформы.MacOS_x86_64 
		ИЛИ ТипСистемы = ТипПлатформы.Windows_x86_64 Тогда
		// 64 бита
		ИмяКаталогаКомпоненты = "x64";
	Иначе
		// 32 бита
		ИмяКаталогаКомпоненты = "x32";
	КонецЕсли;
	
	ФайлСофтфона.Закрыть();	

	ПутьККомпоненте = СокрЛП(ПутьККомпоненте);
	ПутьККомпоненте = СтрЗаменить(ПутьККомпоненте, "SPPanel=", "");
	ПутьККомпоненте = СтрЗаменить(ПутьККомпоненте, "SPPanel3.exe", "NativeComponent\" + ИмяКаталогаКомпоненты + "\SP_ClientNative.dll");
	// +Дополнительная проверка на нужную версию СФ
	ПроверитьФайл = Новый Файл(ПутьККомпоненте);
	Если НЕ ПроверитьФайл.Существует() Тогда
		Если ПоказыватьСообщения Тогда
			ПоказатьПредупреждение(,Нстр("ru = 'Не найдена компонента для работы с Софтфоном. Версия панели Софтфона устарела!'"));
		КонецЕсли;
		Возврат Ложь;
	КонецЕсли;				
	КудаКопировать = КаталогВременныхФайлов() + "SP_ClientNative_"+ ИмяКаталогаКомпоненты + ".dll";
	Попытка
		КопироватьФайл(ПутьККомпоненте, КудаКопировать); 
	Исключение
	КонецПопытки;		
	
	РезультатПодключения = ПодключитьВнешнююКомпоненту(КудаКопировать, "SP_ClientNative", ТипВнешнейКомпоненты.Native);
	Если НЕ РезультатПодключения Тогда 
		Если ПоказыватьСообщения Тогда
			ПоказатьПредупреждение(, НСтр("ru='Не удалось подключить компоненту Софтфона! Проверьте правильность её установки и наличия на диске.'"), 5);
		КонецЕсли;
		Возврат Ложь; 
	КонецЕсли;
	сфпПанельУправления	= Новый("AddIn.SP_ClientNative.SPPanelNative");
	сфпНужнаАвторизация = сфпСофтФонПроСервер.сфпПолучитьЗначениеНастройкиПользователя("сфпПривязатьВнутреннийНомер");
	Если сфпНужнаАвторизация Тогда
		ЛогинСофтфон 	= сфпСофтФонПроСервер.сфпПолучитьЗначениеНастройкиПользователя("сфпЛогинНаСерверСофтФон");
		ПарольСофтфон 	= сфпСофтФонПроСервер.сфпПолучитьЗначениеНастройкиПользователя("сфпПарольНаСерверСофтФон");
		сфпПанельУправления.Autorization(ЛогинСофтфон, ПарольСофтфон, 1);
	КонецЕсли;
	
	СтрокаДоступныхДействий	= "";
	МассивДоступныхДействий = сфпСофтФонПроСерверПереопределяемый.сфпПолучитьМассивДоступныхДействий();
	КоличествоДействий		= МассивДоступныхДействий.Количество() - 1;
	Для НомерДействия = 2 По КоличествоДействий Цикл
		ЭлементМассива = МассивДоступныхДействий[НомерДействия];
		СтрокаДоступныхДействий	= СтрокаДоступныхДействий + Формат(НомерДействия, "ЧГ=0") + "=" 
			+ СтрЗаменить(ЭлементМассива.Наименование, " ", Символы.НПП) + ";";
	КонецЦикла;	
	сфпПанельУправления.RegistrationEvents(СтрокаДоступныхДействий);
	Возврат Истина;
	#КонецЕсли
	
КонецФункции // сфпПодключитьсяНативнаяКомпонента()

// Процедура заполняет префиксы и настройки
//
// Параметры:
//	Нет.
//
Процедура сфпЗаполнитьПрефиксыИНастройкиНативнаяКомпонента() Экспорт
	сфпСтрокаНастроек = "";
	Попытка
		сфпПанельУправления.GetSettingsJSON(сфпСтрокаНастроек);
	Исключение	
	КонецПопытки;
	Если ПустаяСтрока(сфпСтрокаНастроек) Тогда Возврат; КонецЕсли;
	// Получим текущие настройки
	сфпПараметрыСервера		= сфпСофтФонПроСервер.сфпПараметрыСервера();
	// Запишем настройки сервера СофтФона
	сфпСтруктураНастроек	= сфпСофтФонПроСервер.сфпUnJSON(сфпСофтФонПроКлиент.сфпЗаменитьНедопустимыеСимволыXML(сфпСтрокаНастроек));
	Если сфпСтруктураНастроек.Количество() = 0 Тогда Возврат; КонецЕсли;
	СтруктураДанных = Новый Структура();
	Для Каждого ЭлементМассива Из сфпСтруктураНастроек Цикл
		СтруктураДанных.Вставить(ЭлементМассива.Ключ, ЭлементМассива.Значение); 
	КонецЦикла;	
	сфпСофтФонПроСервер.сфпЗаписатьПараметрыСервераНативнаяКомпонента(СтруктураДанных);
	// Если изменилось количество последних цифр, то перезаполним регистр поиска по номерам
	Если НЕ (СтруктураДанных["LastNumberCount"] = сфпПараметрыСервера.ПоследниеЦифрыТелефонногоНомера) Тогда
		сфпСофтФонПроКлиент.сфпПерезаполнитьРегистрПоискаПоНомерам();
	КонецЕсли;
	// Если пользователь авторизовался
	Если НЕ ПустаяСтрока(СтруктураДанных["LocalPhoneNum"]) Тогда
		// Если изменился текущий внутренний номер пользователя
		Если НЕ (СтруктураДанных["LocalPhoneNum"] = сфпСофтФонПроСервер.сфпТекущийВнутреннийНомер()) Тогда
			// Запишем внутренний номер для текущего пользователя
			ТекущийПользователь	= сфпСофтФонПроСервер.сфпТекущийПользователь();
			МассивПользователей = сфпСофтФонПроСервер.сфпЗаписатьНомерПользователю(СтруктураДанных["LocalPhoneNum"], ТекущийПользователь);
			Если сфпСофтФонПроСервер.сфпИспользоватьМаршрутизацию() и Не сфпСофтФонПроСервер.сфпИспользоватьМаршрутизациюПоНомеруИзКИПользователя() Тогда
				// Изменим маршрутизацию в АТС
				СтарыйНабор	= сфпСофтФонПроСервер.сфпПолучитьТаблицуМаршрутизации(, ТекущийПользователь);
				Для Каждого ПользовательМассива Из МассивПользователей Цикл
					НаборПользователя	= сфпСофтФонПроСервер.сфпПолучитьТаблицуМаршрутизации(, ПользовательМассива);
					Для Каждого СтрокаНабора Из НаборПользователя Цикл
						СтарыйНабор.Добавить(СтрокаНабора);
					КонецЦикла;	
				КонецЦикла;	
				НовыйНабор	= сфпСофтФонПроСервер.сфпПолучитьТаблицуМаршрутизации(, ТекущийПользователь);
				// Изменяем внутренний номер на новый
				Для Каждого СтрокаНабора Из НовыйНабор Цикл
					СтрокаНабора.ВнутреннийНомер = СтруктураДанных["LocalPhoneNum"];
				КонецЦикла;	
				СписокМаршрутизации = сфпСофтФонПроСервер.сфпСформироватьСписокМаршрутизации(СтарыйНабор, НовыйНабор);
				сфпСофтФонПроСервер.сфпИзменитьМаршрутизациюВАТС(СписокМаршрутизации);
				сфпСофтФонПроСервер.сфпПерезаписатьНомерЛинииТекущегоПользователяВРегистреПоиска(ТекущийПользователь, СтруктураДанных["LocalPhoneNum"]); 											
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	// Проверяем необходимость обновления интерфейса
	Если НЕ (СтруктураДанных["UseRouter"] = Неопределено) Тогда
		Если НЕ (СтруктураДанных["UseRouter"] = сфпПараметрыСервера.ИспользоватьМаршрутизацию) Тогда
			ОбновитьИнтерфейс();	
		КонецЕсли;	
	ИначеЕсли НЕ (СтруктураДанных["HistoryOn"] = Неопределено) Тогда
		// Если изменилась видимость отчетов
		Если НЕ (СтруктураДанных["HistoryOn"] = сфпПараметрыСервера.ИспользоватьИсториюЗвонков) Тогда
			ОбновитьИнтерфейс();	
		КонецЕсли;	
	ИначеЕсли НЕ (СтруктураДанных["UseHistory"] = Неопределено) Тогда
		Если НЕ (СтруктураДанных["UseHistory"] = сфпПараметрыСервера.ИспользоватьИсториюЗвонков) Тогда
			ОбновитьИнтерфейс();	
		КонецЕсли;	
	КонецЕсли;		
КонецПроцедуры // сфпЗаполнитьПрефиксыИНастройкиНативнаяКомпонента()	

// Динамически подключаемый обработчик события "OnAllLinesInfo" внешней панели
// Отсутствие ссылок на процедуру не является ошибкой!
//
// Параметры:
//	SA	- COMSafeArray	- Массив описания состояния линий
//
Процедура сфпOnAllLinesInfoНативнаяКомпонента(МассивСтатусов) Экспорт
	МассивЛиний = Новый Массив;
	Для Каждого ЭлементМассива Из МассивСтатусов Цикл
		СтруктураЛинии = Новый Структура;
		СтруктураЛинии.Вставить("hLine",		ЭлементМассива.Получить("hLine"));
		СтруктураЛинии.Вставить("LineName",		ЭлементМассива.Получить("LineName"));
		СтруктураЛинии.Вставить("Number",		ЭлементМассива.Получить("Number"));
		СтруктураЛинии.Вставить("LineType",		ЭлементМассива.Получить("LineType"));
		СтруктураЛинии.Вставить("Provider",		ЭлементМассива.Получить("Provider"));
		СтруктураЛинии.Вставить("LineState",	ЭлементМассива.Получить("LineState"));
		МассивЛиний.Добавить(СтруктураЛинии);
	КонецЦикла;
	
	// формы больше оповещать не надо
	//сфпСофтФонПроКлиент.сфпПерезаполнитьСоответствиеСостоянияЛиний(МассивЛиний);
	Оповестить("СофтФон_OnAllLinesInfo", МассивЛиний);
	
КонецПроцедуры // сфпOnAllLinesInfoНативнаяКомпонента()

#КонецОбласти
