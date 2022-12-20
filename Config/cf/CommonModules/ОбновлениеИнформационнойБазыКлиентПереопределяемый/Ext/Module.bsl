///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Вызывается при нажатии на гиперссылку или двойном щелчке на ячейке 
// табличного документа с описанием изменений системы (общий макет ОписаниеИзмененийСистемы).
//
// Параметры:
//   Область - ОбластьЯчеекТабличногоДокумента - область документа, на 
//             которой произошло нажатие.
//
Процедура ПриНажатииНаГиперссылкуВДокументеОписанияОбновлений(Знач Область) Экспорт
	
	//<< УИТ
	Если Область.Имя = "СтатьяКакСократитьКоличествоЗадач" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/promo/articles/75-tasksmalltask.html");
	ИначеЕсли Область.Имя = "ПоискКартинокКлассНеЗарегистрирован" Тогда
		ПерейтиПоНавигационнойСсылке(
			"https://softonit.ru/book/index.htm#page=Esli_ne_rabotaet_zagruzka_izobrazhenii.htm");
	ИначеЕсли Область.Имя = "СозданиеРегламентныхПовторяющихсяЗадачСтатья" Тогда
		ПерейтиПоНавигационнойСсылке(
			"https://softonit.ru/book/scr/Sozdanie_reglamentnykh_(povtoriaiushchikhsia)_zadach.htm");
	ИначеЕсли Область.Имя = "НастройкаВнешнегоВидаКонфигурацииИнтерфейсТакси" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/promo/articles/102-taxiuit.html");
	ИначеЕсли Область.Имя = "РаботаПоЗаявкамПользователемServiceDesk" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/T19NQnUjjSk");
	ИначеЕсли Область.Имя = "НастройкаШаблоновПравлЗаполненияЗаданий" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/wgqbNMk_MlA");
	ИначеЕсли Область.Имя = "ОбзорноеВидеоНовыхМеханизмовИИзменений3_0_27_6" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/oL4XhBygyF8");
	ИначеЕсли Область.Имя = "ЗагрузкаИзAD" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=18");	
	ИначеЕсли Область.Имя = "Версии_СТАНДАРТ_ПРОФ_КОРП" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/company/news/uit-stanstart-prof-corp/");	
	ИначеЕсли Область.Имя = "УдаленноеУправление" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=432");	
	ИначеЕсли Область.Имя = "ЗапросКоммерческогоПредложения" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/fastcommerceit/");
	ИначеЕсли Область.Имя = "УчетТрудозатрат" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=433");	
	ИначеЕсли Область.Имя = "ЛицензионноеПОКакСпособИзбежатьПроблемы" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/nelitsenzionnoe-po/?id=it3" 
			+ "&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.33");
	ИначеЕсли Область.Имя = "СобираемСтатистикуПечатиПользователей" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/obrabotka-pechati/?id=it3" 
			+ "&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.33");
	ИначеЕсли Область.Имя = "ОблакоДляУИТ30" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/cloud1c/?id=it3&"
			+ "referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.33");
	ИначеЕсли Область.Имя = "ОстаткиПоставщики" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/vneshniy-kontragent/?id=it3"
			+ "&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.33");
	ИначеЕсли Область.Имя = "УправлениеДоступом" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=441"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.33");
	ИначеЕсли Область.Имя = "smscru" Тогда
		ПерейтиПоНавигационнойСсылке("http://smsc.ru/?ppsoftonit");
	ИначеЕсли Область.Имя = "gsminform" Тогда
		ПерейтиПоНавигационнойСсылке("http://gsm-inform.ru/");
	ИначеЕсли Область.Имя = "smsuslugi" Тогда
		ПерейтиПоНавигационнойСсылке("https://sms-uslugi.ru");
	ИначеЕсли Область.Имя = "Профстандарты" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/profstandartit/?id=it3"
			+ "&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.34");
	ИначеЕсли Область.Имя = "ОбменДаннымиУИТ" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=445&id=it3"
			+ "&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.34");
	ИначеЕсли Область.Имя = "kontragent1c" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/kontragent1c/"
			+ "?referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.35");
	ИначеЕсли Область.Имя = "pravilasob" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0449" 
			+ "&LESSON_PATH=1.449&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.36");
	ИначеЕсли Область.Имя = "KanbanBoardFAQ" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0456"
			+ "&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.37");
	ИначеЕсли Область.Имя = "videokanban" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/cuJWk-YSOJU");
	ИначеЕсли Область.Имя = "СкладскойУчетКлиентов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=461"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.38");
	ИначеЕсли Область.Имя = "КакВернутьсяКСтаромуФорматуПисем" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=462"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.38");
	ИначеЕсли Область.Имя = "СтатусыКарточекНоменклатуры" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=465"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.38");
	ИначеЕсли Область.Имя = "ДобавитьКонтактнуюИнформациюВФормеСписка" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=466"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.39");
	ИначеЕсли Область.Имя = "БазаЗнанийРаздел" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0468"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.39");
	ИначеЕсли Область.Имя = "ЗагрузкаСтатейВБазуЗнанийИзMSOffice" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=472"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.40");
	ИначеЕсли Область.Имя = "ОтправкаСтатьиБазыЗнанийНаЭлектроннуюПочту" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=473"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.40");
	ИначеЕсли Область.Имя = "ЦветностьВСпискеЗаданий" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=474"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.40");
	ИначеЕсли Область.Имя = "СкрыватьКомплектующиеИлиНет" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=475"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.41");
	ИначеЕсли Область.Имя = "УправлениеПроблемами" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=476"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.41");
	ИначеЕсли Область.Имя = "СозданиеЗаданийНаОснованииЭлектронныхПисем" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=27"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.42");
	ИначеЕсли Область.Имя = "ДобавитьВЛюбуюФормуДинамическогоСпискаСтолбец" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=478"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.42");
	ИначеЕсли Область.Имя = "СхемаЖизниДокументаЗадание" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=479"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.42");
	ИначеЕсли Область.Имя = "АвтоматическоеВыполнениеЗаданий" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=28"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.42");
	ИначеЕсли Область.Имя = "АвтоматическоеЗавершениеЗаданий" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=480"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.42");
	ИначеЕсли Область.Имя = "МестоХраненияИМногоМОЛов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=481"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3.0.42");
	ИначеЕсли Область.Имя = "ВставкаВСтатьюИзображенияИлиТаблицы" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=482"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_0_43");
	ИначеЕсли Область.Имя = "ЗагрузкаСотрудников" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=13&id=it3"
			+ "&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_0_43");
	ИначеЕсли Область.Имя = "LESSON_ID484" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=484"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_0_43");
	ИначеЕсли Область.Имя = "ЗаполнениеЗаданийПоШаблонам" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=485"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_0_43");
	ИначеЕсли Область.Имя = "НастройкаТелефонии" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=488"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_0_43");
	ИначеЕсли Область.Имя = "РаботаСТелефониейВКонфигурации" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=489"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_0_43");
	ИначеЕсли Область.Имя = "РаботаСоСпецификациямиИНакладными" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=493"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_0");
	ИначеЕсли Область.Имя = "РаботаССерверомЛицензирования" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=494"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_0");
	ИначеЕсли Область.Имя = "УчетСотовойСвязи" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=495"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_1");
	// 3.1.1.2
	ИначеЕсли Область.Имя = "ОбзорОбновления3_1_1_2" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/7x4GyVS1Gsk");
	ИначеЕсли Область.Имя = "УстановкаМобильногоПриложения" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=500"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_1_2");
	ИначеЕсли Область.Имя = "МобильноеПриложениеСовместноСКонфигурацией" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=502"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_1_2");
	ИначеЕсли Область.Имя = "МобильноеПриложениеВАвтономномРежиме" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=501"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_1_2");
	ИначеЕсли Область.Имя = "МобильноеПриложениеСкачатьИзGoolePlay" Тогда
		ПерейтиПоНавигационнойСсылке("https://play.google.com/store/apps/details?id=ru.softonit.uitmobile");
	// 3.1.2.1
	ИначеЕсли Область.Имя = "ЛичныйКабинет" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=542"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_2_1");
	ИначеЕсли Область.Имя = "МобильноеПриложениеСкачатьИзAppStore" Тогда
		ПерейтиПоНавигационнойСсылке("https://itunes.apple.com/us/app/%D1%83%D0%BF%D1%80%D0%B0%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-it-%D0%BE%D1%82%D0%B4%D0%B5%D0%BB%D0%BE%D0%BC-8/id1458344514?l=ru&ls=1&mt=8&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_2_1");
	ИначеЕсли Область.Имя = "ЛКYouTube" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/yEjMlcnH3Vk");
	// 3.1.3.1
	ИначеЕсли Область.Имя = "ЧтоТакоеGTD" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=549"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "СборИнформацииОДелах" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=550"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "КакРаботатьСGTD" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=557"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "РеквизитыДел" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=555"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "АвтоматическоеНазначениеИсполнителя" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=558"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "ДелаОбзор" Тогда
	    ПерейтиПоНавигационнойСсылке("https://youtu.be/8QinXW9h8b8");
	ИначеЕсли Область.Имя = "ПроектнаяДеятельность" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=560"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "ИспользованиеМетрик" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=547"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "УправляемыйРабочийСтол" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=562"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "УстановкаЦенУслуг" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=563"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "СоглашениеSLA" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=33"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "УровниРеакцииИВыполнения" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=564"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "Тарифы" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=565"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "ВычисляемыеCроки" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=566"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "ПричиныОтклоненияОтГрафика" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=567"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_1");
	ИначеЕсли Область.Имя = "ВидеоОбзор3_1_3_1" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/Ah2Lz9ifrbs");
	// 3.1.3.8
	ИначеЕсли Область.Имя = "УчетКанцелярскихПринадлежностей" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=571"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_8");
	ИначеЕсли Область.Имя = "ОценкаПроизводительности" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=572"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_8");
    // 3.1.3.14
	ИначеЕсли Область.Имя = "МетрикиKPIСтатья" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/metriki-i-kpi/"
			+ "?referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_14");
	ИначеЕсли Область.Имя = "ApacheSSL" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/apache-ssl-1c/"
			+ "?referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_14");
	ИначеЕсли Область.Имя = "МетрикиKPIвидео" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/ZTQqghYECKU");
	ИначеЕсли Область.Имя = "ПервичныеДокументы" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=575"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_14");
	ИначеЕсли Область.Имя = "ОбзорПервичныхДокументов" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/OiOZQ7HHke8");	
	// 3.1.3.15
	ИначеЕсли Область.Имя = "ЗаработнаяПлата" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0670"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_15");
	ИначеЕсли Область.Имя = "ДинамическиеПриоритеты" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0674"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_15");
	ИначеЕсли Область.Имя = "ОчередьВыполненияЗаданий" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0675"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_3_15");	
	// 3.1.4.2
	ИначеЕсли Область.Имя = "СозданиеИНастройкаTelegramБота" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=679"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_2");
	ИначеЕсли Область.Имя = "ОписаниеРаботыПодсистемыTelegram" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=683"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_2");
	ИначеЕсли Область.Имя = "ПредопределенныеКомандыTelegramБота" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=681"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_2");
	ИначеЕсли Область.Имя = "ДобавлениеСобственныхКомандTelegramБота" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=682"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_2");
	ИначеЕсли Область.Имя = "ОтправкаУведомленийTelegramБотуЧерезПравилаСобытий" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=680"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_2");
	ИначеЕсли Область.Имя = "ИнтеграцияСTelegramБотом" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/7_6f-oOueSo");
	// 3.1.4.3
	ИначеЕсли Область.Имя = "РаботаСЗаказамиКлиентов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0699"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_3");
	ИначеЕсли Область.Имя = "СозданиеНовогоПроцесса" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=690"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_3");
	ИначеЕсли Область.Имя = "ВозвратыВЗаказах" Тогда	
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=703"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_3");
	ИначеЕсли Область.Имя = "ЛогиныИПароли" Тогда	
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=93"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_3");
	// 3.1.4.4
	ИначеЕсли Область.Имя = "КонтрольСроковЭЦП" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=708"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_4");
		
	// 3.1.4.5
	ИначеЕсли Область.Имя = "УчетДополнительныхРасходов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=711"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_5");
	ИначеЕсли Область.Имя = "НастройкаИнтерфейсаOData" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=712"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_5");		
		
	// 3.1.4.6
	ИначеЕсли Область.Имя = "РассылкиОтчетов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=713"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_6");	
    ИначеЕсли Область.Имя = "НастраиваемГруппыНаКанбанДоске" Тогда 
        ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=714"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_4_6");	
	ИначеЕсли Область.Имя = "УстановкаПроцессаЗадания" Тогда 
        ПерейтиПоНавигационнойСсылке("https://youtu.be/3LGMZWlZ0Ig");	
	ИначеЕсли Область.Имя = "МастерРегистрации" Тогда 
        ПерейтиПоНавигационнойСсылке("https://youtu.be/nYL1djb9KR0");
	ИначеЕсли Область.Имя = "НастройкаКанбанДоски" Тогда 
        ПерейтиПоНавигационнойСсылке("https://youtu.be/4y9E4W8NEG8");
		
	// 3.1.5.1
	ИначеЕсли Область.Имя = "СборЗаявок" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/uit/collection_applications/"
			+ "?referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_5_1");	
		
	// 3.1.6.1
	ИначеЕсли Область.Имя = "ТемыЭтапов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=716"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_6_1");
	ИначеЕсли Область.Имя = "ПроксиСервера" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=717"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_6_1");
		                              
	// 3.1.6.2
	ИначеЕсли Область.Имя = "АвтоматическийРасчетSLA" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=718"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_6_2");
	ИначеЕсли Область.Имя = "РаботаСОценками" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/Hn07tk_mvXU");
	ИначеЕсли Область.Имя = "ОценкаЛояльностиПользователей" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=719"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_6_2");
		
	// 3.1.7.0
	ИначеЕсли Область.Имя = "СсылкиВТонкомКлиенте" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/uit/otkrytie-vneshnikh-ssylok-na-obekt/"
			+ "?referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_0");

	// 3.1.7.1
	ИначеЕсли Область.Имя = "МетодикиПравилСобытий" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&CHAPTER_ID=0722"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_1");
    ИначеЕсли Область.Имя = "ЗаполнениеИнициатораКлиент" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=731"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_1");
		
	// 3.1.7.5
	ИначеЕсли Область.Имя = "УчетПроектов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=560"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_5");
	ИначеЕсли Область.Имя = "ПланированиеПроекта" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=739"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_5");
	ИначеЕсли Область.Имя = "РесурсыПроекта" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=740"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_5");
	ИначеЕсли Область.Имя = "КалендарноеПланирование" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=741"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_5");
	ИначеЕсли Область.Имя = "ОтчетностьПроекта" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=742"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_5");
	ИначеЕсли Область.Имя = "ЗатратыПоПроекту" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=743"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_5");
	ИначеЕсли Область.Имя = "ВставкаИсходногоКодаВБазуЗнаний" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=753"
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_5");

	// 3.1.7.8		
	ИначеЕсли Область.Имя = "ОткрытиеЗадачВGitlab" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/uit/taskgitlabuit/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_8");
	ИначеЕсли Область.Имя = "СтильОформления" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=756" 
			+ "&id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_8");

	// 3.1.7.9		
	ИначеЕсли Область.Имя = "GoogleForms" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/other/Google-Forms-at-service-of-tech-support/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_9");
	ИначеЕсли Область.Имя = "МатрицаRACI" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/it/RACI-matrix-determine-in-incidents-who-is-responsible-for-what/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_9");
	ИначеЕсли Область.Имя = "ПорядокУправленияИнцидентами" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/it/procedure-managing-incidents-call-centers/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_9");
	ИначеЕсли Область.Имя = "ШаблоныОтветовДляКлиентов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/other/answer-templates-clients-support/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_9");
	ИначеЕсли Область.Имя = "ИспользованиеТегов" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/uit/Using-tags/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_7_9");
			
	// 3.1.8.1
	ИначеЕсли Область.Имя = "МетодЛюбищева" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/gtd/granin-strange-life/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_8_1");
	
	ИначеЕсли Область.Имя = "УчетРасходныхМатериаловДляОргтехники" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/uit/uchet-raskhodnykh-materialov-dlya-o/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_8_1");
	
	ИначеЕсли Область.Имя = "СобственнаяАвторизацияЛК" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/FAQ/courses/?COURSE_ID=1&LESSON_ID=792/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_8_1");

	// 3.1.8.3
	ИначеЕсли Область.Имя = "ПубликацияБазНаIIS" Тогда
		ПерейтиПоНавигационнойСсылке("https://softonit.ru/articles/it/publishing-1C-databases-on-the-IIS-web-server/"
			+ "?id=it3&referrer=utm_source&utm_campaign=from1c_itnews&utm_content=3_1_8_3");
	ИначеЕсли Область.Имя = "ПодключениеКМобильному" Тогда
		ПерейтиПоНавигационнойСсылке("https://youtu.be/DRv5KRTfZK8");		
		
	КонецЕсли;
	//>>	

КонецПроцедуры

// Вызывается в обработчике ПередНачаломРаботыСистемы, проверяет возможность
// обновления на текущую версию программы.
//
// Параметры:
//  ВерсияДанных - Строка - версия данных основной конфигурации, с которой выполняется обновление
//                          (из регистра сведений ВерсииПодсистем).
//
//@skip-warning
Процедура ПриОпределенииВозможностиОбновления(Знач ВерсияДанных) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти
