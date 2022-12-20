////////////////////////////////////////////////////////////////////////////////
// Модуль управления CSS таблицами выводимых в HTML данных.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// ПУБЛИЧНЫЕ МЕТОДЫ

Функция ПолучитьТаблицуСтилей() Экспорт
	
	Возврат СформироватьТаблицуСтилей();
	
КонецФункции

Функция ПолучитьТаблицуСтилейПоиска() Экспорт
	
	Возврат 
		"<style type='text/css'>
		|
		|" + ТаблицаСтилей_common() + "
		|
		|/*СТИЛИ ДЛЯ ОФОРМЛЕНИЯ ПОИСКА*/
		|.main{overflow:auto;margin-bottom:15px}
		|.presentation{font-size:12px;padding:2px 0 0 0;}
	    |.textPortion{font-size:11px;padding:2px 0 5px 0;border-bottom:1px dotted #666;}	
	    |.bold{font-weight:bold;}
		|.high1{background-color:#FFFF99;}
		|.high2{background-color:#CCFFCC;}
		|.high3{background-color:#CCFEFE;}
		|.high4{background-color:#98CCFE;}
		|.high5{background-color:#FEE4E0;}
		|.high6{background-color:#D8BED8;}
		|</style>";
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// ФОРМИРОВАНИЕ ТАБЛИЦЫ СТИЛЕЙ CSS

Функция СформироватьТаблицуСтилей()
	
	СтрокаТаблицыСтилей = 
		"<style type='text/css'>	
		|
		|" + ТаблицаСтилей_common() + "
		|
		|" + ТаблицаСтилей_menu() + "
		|
		|" + ТаблицаСтилей_content_footer() + "
		|
		|" + ТаблицаСтилей_page_path() + "
		|
		|" + ТаблицаСтилей_categories() + "
		|
		|" + ТаблицаСтилей_articles() + "
		|
		|" + ТаблицаСтилей_news() + "
		|
		|" + ТаблицаСтилей_article() + "
		|
		|" + ТаблицаСтилей_news_item() + "
		|
		|" + ТаблицаСтилей_user() + "
		|
		|" + ТаблицаСтилей_command_panel() + "
		|
		|" + ТаблицаСтилей_tags() + "
		|
		|" + ТаблицаСтилей_comments() + "
		|
		|" + ТаблицаСтилей_tasks() + "
		|
		|" + ТаблицаСтилей_prism() + "
		|	
		|.pictureblock {float:none;text-align:center;font-family:sans-serif;font-size:11px;margin:0;padding:2px;background-color:#ffffff;}
		|.pictureblock a img {background-color:#ffffff;border:0;padding:0;margin:0;}
		|.tableblock {border:none;background:#ffffff;margin:0;text-align:center;}
		|.t_text {font-size:9px}
		|.marker {background-color:#ffff00}
		|
		|/*ДОПОЛНИТЕЛЬНО*/
		|</style>";
	
	Возврат СтрокаТаблицыСтилей;
	
КонецФункции

Функция ТаблицаСтилей_common()
	
	Возврат 
		"/*General styles*/
		|html {width:100%;}
		|body {background:#fff;font-family:Tahoma, Arial, sans-serif;font-size:13px;margin:0;}
		|a {color:#0066bb;text-decoration:none;}
		|a:hover {color:#00437a;text-decoration:none;}
		|abbr {border-bottom:1px dotted #666;cursor:help;}
        |.tag{margin-right:3px;margin-top:3px;margin-bottom:3px;display:inline-block;padding:0.25em 0.4em;line-height:1;text-align:center;white-space:nowrap;vertical-align:baseline;}
		|
		|.flt_l {float:left;}
		|.flt_r {float:right;}";
	
КонецФункции

Функция ТаблицаСтилей_menu()
	
	Возврат
		"/*МЕНЮ*/
		|.menu {margin:0 25px 10px 25px;padding: 5px 5px 5px 0;border:1px solid #a4d8ff;}
		|.menu img {line-height:40px;float:left;}
		|.menu li {display:inline;padding-bottom:5px;}";
	
КонецФункции

Функция ТаблицаСтилей_content_footer()
	
	Возврат
		"/*КОНТЕНТ ОБЕРТКА*/
		|.content_main {padding: 10px 15px; overflow:hidden;}
		|.content_main h1 {font-size:20px; border-bottom: 1px solid #f4f4f4; padding-bottom:3px; margin-bottom: 15px;}
		|.content_main h2 {font-size:17px; border-bottom: 1px solid #f4f4f4; padding-bottom:3px; margin: 15px 0;}
		|.content_main h3 h4 h5{font-size:13px; border-bottom: 1px solid #f4f4f4; padding-bottom:3px; margin: 15px 0;}
		|.content_main h6 {font-size:13px; border-bottom: 1px solid #f4f4f4; padding-bottom:3px; margin-bottom: 5px;}
		|.content_main ul {list-style-type: disc; margin-left:20px;}
		|
		|#footer {padding: 10px 15px;}
		|
		|/*НАВИГАЦИЯ В КОНТЕНТЕ*/
		|.content_menu_header {float:right; position:absolute;}";
	
КонецФункции

Функция ТаблицаСтилей_page_path()
	
	Возврат
		"/*ПУТЬ К СТРАНИЦЕ*/
		|#page_path {font-size:12px; color:#000; line-height:20px; border-bottom:1px dotted #666; margin-bottom:5px;
		|padding-bottom:2px;} 
		|#page_path img {color:#0066bb; height:16px; margin: 0 2px 0 0;}";
	
КонецФункции

Функция ТаблицаСтилей_categories()
	
	Возврат  
		"/*СПИСОК КАТЕГОРИЙ*/
		|#categories {margin-bottom:10px;}
		|#categories table {border-collapse:separate;}
		|#categories table tr {vertical-align:top;}
		|#categories table td {padding:0 5px; width:1%;}
		|#categories h1 {font-size:18px; font-weight:400; border-bottom:1px solid #9DB6C9; padding:3px; margin:0;}
		|#categories h1 a {color:#26587E; text-decoration:none;}
		|
		|/*ОПИСАНИЕ КАТЕГОРИИ*/
		|.category {padding:8px 5px; margin:8px 0 0 0; border:1px solid #9DB6C9; border-radius:5px; background-color:#F7FBFF;}
		|.category .title {color:#0066bb; font-size:14px; border:0;}
		|.category .title img {margin: 0 5px 0 0; width:16px; height:16px;}
		|.category .title h2 {padding:0 0 0 2px; margin: 0 0 2px 21px; font-size:13px; border:0; font-weight:400;}
		|.category .title h2 a {color:#26587e; text-decoration:none;}
		|.category .title h2 a:hover {color:#4296d6;}
		|.category .title .stat {color:#687580; font-size:11px; border:1px solid #9DB6C9; border-radius:50%; padding:1px 5px;
		|text-align:center;}
		|.category .title .stat img {width:16px; height:16px;}
		|.category .title .stat .text {display:table-cell; vertical-align:middle;}
		|.category .info {color:#666; font-size:11px; text-align:justify; margin:5px 0 0 0;}
		|";
	
КонецФункции

Функция ТаблицаСтилей_articles()
	
	Возврат
		"/*СТАТЬИ*/
		|#articles {padding:0 0 10px 0; margin: 0 0 10px 0; * width:100%;}
		|#articles table {border-collapse:separate;}
		|#articles table tr {vertical-align:top;}
		|#articles table td {padding:0 5px;}
		|#articles h1 {color:#3f5e20; font-size:16px; border-bottom:1px solid #3f5e20; padding:5px 3px; margin:0;
		|font-weight:400;}
		|#articles h1 a {color:#3f5e20;}
		|#articles h1 a:hover {color:#00b907;}
		|
		|/*СТАТЬЯ (КРАТКО)*/
		|.article_s {border-bottom:1px dashed #669933; padding:5px;}
		|.article_s:hover {background-color:#E4FFCB}
		|.article_s .head {padding-right:2px;}
		|.article_s .head h2 {padding:0 0 0 2px; margin: 0 0 4px 0; font-size:13px; border:0;}
		|.article_s .head h2 a {color:#3f5e20; font-weight:400; text-decoration:none; font-size:13px; line-height:18px;}
		|.article_s .head h2 a:hover {color:#00b907;}
		|.article_s .head .info {padding:0 0 0 2px; color:#666; font-weight:normal; font-size:11px; text-align:justify;}
		|.article_s .head .stat {float:right; display:inline;}
		|.article_s .head .stat img {float:left; height:16px; width:16px; margin:0 3px;}
		|.article_s .head .stat .text {display:table-cell; vertical-align:middle; font-size:11px; float:left; margin:0;
		|line-height:16px;}
		|.article_s .text {color:#333; font-size:13px; text-align:justify; margin:3px 0 8px 0; padding:2px;
		|line-height:18px;}";
	
КонецФункции

Функция ТаблицаСтилей_news()
	
	Возврат
		"/*НОВОСТНАЯ ЛЕНТА*/
		|#news {margin-bottom:10px;}
		|#news h1 {font-size:18px; font-weight:400; color:#ca2d2d; border-bottom:1px solid #ca2d2d; padding:3px; margin:0 0 8px 0;}
		|#news h1 a {color:#ca2d2d; text-decoration:none;}
		|#news h1 a:hover {color:#ff1818;}
		|
		|.news {padding:0 0 5px 8px; line-height:15px;}
		|.news .descr {display:table-cell; font-size:13px; vertical-align:middle; padding-right:3px;}
		|.news .descr img {width:16px; height:16px; margin:0 5px 0 0;}
		|.news .descr a {color:#ca2d2d;}
		|.news .descr a:hover {color:#ff1818;}
		|.news .info {color:#666; font-size:11px; display:table-cell; vertical-align:middle;}
		|.news .text {margin:3px 0 8px 0; color:#333; font-size:13px; text-align:justify; padding:2px 2px 5px 2px; line-height:18px; border-bottom:1px dashed #666;}";
	
КонецФункции

Функция ТаблицаСтилей_article()
	
	Возврат
		"/*СТАТЬЯ (ПОЛНОСТЬЮ)*/
		|.article {border:1px solid #c5f8ac; border-radius:5px; padding:5px 5px 10px 5px; margin-bottom:15px;}
		|
		|.article h1 {color:#669933; font-size:15px; font-weight:400; padding:3px; border-bottom:1px solid #ccc; margin:8px 0; height:22px;}
		|.article .info {border:1px solid #9DB6C9; border-radius:5px; padding:5px; background-color:#F7FBFF; margin-bottom:6px;}
		|.article .text {font-size:13px; margin:0 5px 15px 5px; line-height:1.2}
		|.article .text a {text-decoration:none;}
		|.article .text a:hover {text-decoration:underline;}
		|.article .text p {margin:5px 0 2px 0}
		|.article .text ul {margin:5px 0 2px 0; padding-left:10px; list-style-position:inside;}
		|.article .text li {}
		|.article .text h1 {color:#000; font-size:20px; border-bottom: 1px solid #f4f4f4; padding-bottom:3px; margin-bottom: 15px;}
		|.article .text h2 h3 {color:#000; font-size:17px; border-bottom: 1px solid #f4f4f4; padding-bottom:3px; margin: 12px 0;}
		|.article .text h4 h5 h6 {color:#000; font-size:14px; border-bottom: 1px solid #f4f4f4; padding-bottom:3px; margin: 10px 0;}
		|
		|.article .contents {background: #fff; border:1px solid #D5E2F1; border-radius:5px; padding:5px; width:350px; margin-bottom:10px;}
		|.article .contents ul {padding: 0 0 0 25px;}
		|.article .contents li {padding: 3px 0 3px 0;}
		|
		|.article .sup {font-size:9px; vertical-align:super;}
		|.article .references {margin-bottom:15px;}
		|.article .references li {list-style-type:none;}
		|
		|.article .tableblock {clear:both;}
		|
		|#article_tags {border:1px solid #ffa300; padding:3px; margin:0;}
		|#article_tags ul {display:inline; list-style-type:none; padding:0; margin:0;}
		|#article_tags li {display:inline; margin:0 2px;}
		|/*ОписаниеМетатегов*/";
	
КонецФункции

Функция ТаблицаСтилей_news_item()
	
	Возврат
		"/*НОВОСТЬ*/
		|#newsitem {border:1px solid #cea9a9; border-radius:5px; padding:5px 5px 10px 5px; margin-bottom:15px;}
		|
		|#newsitem h1 {font-size:18px; font-weight:400; color:#ca2d2d; border-bottom:1px solid #ca2d2d; padding:3px; margin:0 0 8px 0;}
		|#newsitem .info {border:1px solid #9db6c9; border-radius:5px; padding:5px; background-color:#f7fbff; margin-bottom:6px;}
		|#newsitem .text {font-size:13px; margin:0 5px 15px 5px; line-height:1.2}
		|#newsitem .text a {text-decoration:none;}
		|#newsitem .text a:hover {text-decoration:underline;}";
	
КонецФункции

Функция ТаблицаСтилей_user()
	
	Возврат 
		"/*ПРОФИЛЬ*/
		|.kbuser {padding:10px 0; background-color:#f1f5f8; margin-bottom:10px; border:1px solid #d5e2f1; border-radius:5px;}
		|.user_head img {width:42px; height:42px; float:left; margin:0 5px;}
		|.user_head h1 {margin:0 0 5px 55px; font-size:16px; border:0; font-weight:normal;}
		|.user_head h1 a {color:#0066bb; text-decoration:none; font-weight:400;}
		|
		|#panel_button ul {list-style-type:none; margin:0; padding:0;}
		|#panel_button li {display:inline; padding:2px 5px; margin-left:7px; border:1px solid #c5f8ac; background-color:#e5ffd8; border-radius:5px; border-bottom-left-radius:0; border-bottom-right-radius:0;}
		|#panel_button li a {font-weight:normal; text-decoration:none; color:#000;}
		|
		|#panel_content {margin:2px 0; padding:8px 5px; border:1px solid #c5f8ac; border-radius:5px;}";
	
КонецФункции

Функция ТаблицаСтилей_command_panel()
	
	Возврат
		"/*КОМАНДНАЯ ПАНЕЛЬ*/
		|#command_panel {display:inline; border:0; margin:2px 0 0 5px; font-size:12px; font-weight:normal; color:#ccc;}
		|#command_panel ul {display:inline; list-style-type:none; padding:0; margin:0;}
		|#command_panel li {float:left; display:table-cell; vertical-align:middle; padding:0 2px;}
		|#command_panel img {border:0; margin:0 5px; height:16px; vertical-align:middle;}
		|#command_panel a {text-decoration:none; padding:2px 0;}
		|
		|#command_panel .first_page {font-size:12px; padding:0 2px 0 6px; border-left:1px solid #ccc;}
		|#command_panel .prev_page {font-size:12px; padding:0;}
		|#command_panel .next_page {font-size:12px; padding:0;}
		|#command_panel .page_info {font-size:12px; padding:0 2px 0 4px; color:#26587e;}";
	
КонецФункции

Функция ТаблицаСтилей_tags()
	
	Возврат
		"/*ОБЛАКО ТЕГОВ*/
		|#tags {font-size:13px;border-bottom:1px dashed #e4f2fb;border-top:1px dashed #e4f2fb;margin-bottom:10px;padding:0 5px;min-height:20px;width:100%;}
		|#tags ul {text-align:center; padding:1px 10px 1px 10px;}	
		|#tags li {display:inline;vertical-align:middle;list-style-type:none;margin: 0 3px;}
		|#tags li a {color:#0066bb;text-decoration:none;}
		|#tags li a:hover {color:#84adff;}
		|#tags .tag1 {font-size:80%;}
		|#tags .tag2 {font-size:90%;}
		|#tags .tag3 {font-size:105%;}
		|#tags .tag4 {font-size:120%;}
		|#tags .tag5 {font-size:140%;}";
	
КонецФункции

Функция ТаблицаСтилей_comments()
	
	Стиль = "/*КОММЕНТАРИИ*/";
	
	// Отображаем картинки или нет в комментариях.
	Если УправлениеITОтделом8УФПовтИсп.ПолучитьКонстанту("ИспользоватьИзображенияПользователейВКомментариях") Тогда
		Стиль = Стиль + "			
			|#comments{margin: 10px 0 0 0;line-height:18px;verical-align:middle;}
			|.comment h1{margin:6px 0 6px 0;padding:0;font-size:12px; font-weight:bold;border:0;height:16px;color:black;}";			
	Иначе
		Стиль = Стиль + "			
			|#comments{margin: 10px 0 0 0;line-height:18px;verical-align:middle;}
			|.comment h1{margin:0 0 0 0;padding:0;font-size:12px;font-weight:bold;border:0;color:black;}";
	КонецЕсли;
	
	Стиль = Стиль + "
		|#comments .h1{color:#555; font-size:15px; margin:10px 0 0 0; padding:5px 0;}
		|#comments_panel{float:right; padding:2px 5px; font-size:12px; font-weight:normal;}
		|#comments_panel a{color:#0066bb; text-decoration:none; border-left:1px solid #f4f4f4; border-right:1px solid #666; padding: 0 5px;}
		|.comment{margin:0 0 2px 0; padding-top:8px; border-bottom:1px solid #f4f4f4;}
		|.comment h1 .date{font-size:12px; font-weight:normal; color:#818181;}
		|.comment h1 .answer{background:url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAABl0RVh0U29mdHdhcmUAcGFpbnQubmV0IDQuMC4yMfEgaZUAAACySURBVDhPpZI7EoQgEES9upmEhtzAkNDQI5gREhISEs7SVOnKbFO1lMFD7OkePjqJyCuoOAIVNTnn8uA1Kmq899Jr8iMwjuMQay1t0rz02Pdd5nmuTVJKRfrWGuMFVsKq67rW4BNjjMQYi63TAEWYdPDJsiz3cYbD4DzPGgZNA2wZ3bdtq0eAMYQgzjkaBvcEARjZTaPGwqAxXXPNtRutgzroT6Pp/USAiiNQcQQq/o9MH3qP/quXxrf5AAAAAElFTkSuQmCC') center left no-repeat;height:16px;width:16px;margin-left:5px;}
		|.comment h1 a{color:#0066bb;text-decoration:none;}		
		|.photo{width:24px;float:left;margin-right:8px;}		
		|.comment_body{margin:8px 0 0 0;}		
		|.comment_h1{margin:2px 0 8px 0px;color:#888888;font-weight:bold;}
		|.comment_body_text{margin:0;}
		|.comment_body_text p{margin:3px 0 2px 0;}
		|.comment_body_files{margin:0px 0 0px 0;font-size:11px;}
		|.comment_body_files a{color:#0066bb;}
		|.comment_body_files img{float:left;border:0;width:16px;height:16px;}
		|.comment_body_panel{margin:5px 0 0px 0;color:#aaa;font-size:11px;}
		|.comment_body_panel a{color:#aaa;font-size:11px;}
		|code{display:block;padding:9.5px;margin:0 0 10px;font-size:13px;line-height:1.42857143;color:#333;word-break:break-all;word-wrap:break-word;background-color:#f5f5f5;border:1px solid #ccc;border-radius:4px;font-family:Menlo,Monaco,Consolas,""Courier New"",monospace;}";
	
#Если ТонкийКлиент ИЛИ ВебКлиент ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда 
	Стиль = Стиль + "
		|quote{display:block;padding:10px 10px;margin:10px 0 10px 10px;border-left:5px solid #eee;position:relative;}
		|blockquote{display:block;padding:10px 10px;margin:10px 0 10px 10px;border-left:5px solid #eee;position:relative;}";
#Иначе
	Стиль = Стиль + "
		|quote{display:block;padding:0px 4px;margin:5px 0 5px 0px;border-left:5px solid #eee;position:relative;}
		|blockquote{display:block;padding:10px 10px;margin:10px 0 10px 10px;border-left:5px solid #eee;position:relative;}";
#КонецЕсли
	
	Возврат Стиль;
	
КонецФункции

Функция ТаблицаСтилей_prism() Экспорт
	
	Возврат
		"
		|/* PrismJS 1.21.0
		|https://prismjs.com/download.html#themes=prism&languages=markup+css+clike+javascript+bash+batch+bsl+c+csharp+cpp+cmake+ini+java+json+makefile+nginx+pascal+powershell+python+regex+sql */
		|/**
		| * prism.js default theme for JavaScript, CSS and HTML
		| * Based on dabblet (http://dabblet.com)
		| * @author Lea Verou
		| */
		|
		|code[class*=""language-""],
		|pre[class*=""language-""] {
		|	color: black;
		|	background: none;
		|	text-shadow: 0 1px white;
		|	font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
		|	font-size: 1em;
		|	text-align: left;
		|	white-space: pre;
		|	word-spacing: normal;
		|	word-break: normal;
		|	word-wrap: normal;
		|	line-height: 1.5;
		|
		|	-moz-tab-size: 4;
		|	-o-tab-size: 4;
		|	tab-size: 4;
		|
		|	-webkit-hyphens: none;
		|	-moz-hyphens: none;
		|	-ms-hyphens: none;
		|	hyphens: none;
		|}
		|
		|pre[class*=""language-""]::-moz-selection, pre[class*=""language-""] ::-moz-selection,
		|code[class*=""language-""]::-moz-selection, code[class*=""language-""] ::-moz-selection {
		|	text-shadow: none;
		|	background: #b3d4fc;
		|}
		|
		|pre[class*=""language-""]::selection, pre[class*=""language-""] ::selection,
		|code[class*=""language-""]::selection, code[class*=""language-""] ::selection {
		|	text-shadow: none;
		|	background: #b3d4fc;
		|}
		|
		|@media print {
		|	code[class*=""language-""],
		|	pre[class*=""language-""] {
		|		text-shadow: none;
		|	}
		|}
		|
		|/* Code blocks */
		|pre[class*=""language-""] {
		|	padding: 1em;
		|	margin: .5em 0;
		|	overflow: auto;
		|}
		|
		|:not(pre) > code[class*=""language-""],
		|pre[class*=""language-""] {
		|	background: #f5f2f0;
		|}
		|
		|/* Inline code */
		|:not(pre) > code[class*=""language-""] {
		|	padding: .1em;
		|	border-radius: .3em;
		|	white-space: normal;
		|}
		|
		|.token.comment,
		|.token.prolog,
		|.token.doctype,
		|.token.cdata {
		|	color: slategray;
		|}
		|
		|.token.punctuation {
		|	color: #999;
		|}
		|
		|.token.namespace {
		|	opacity: .7;
		|}
		|
		|.token.property,
		|.token.tag,
		|.token.boolean,
		|.token.number,
		|.token.constant,
		|.token.symbol,
		|.token.deleted {
		|	color: #905;
		|}
		|
		|.token.selector,
		|.token.attr-name,
		|.token.string,
		|.token.char,
		|.token.builtin,
		|.token.inserted {
		|	color: #690;
		|}
		|
		|.token.operator,
		|.token.entity,
		|.token.url,
		|.language-css .token.string,
		|.style .token.string {
		|	color: #9a6e3a;
		|	/* This background color was intended by the author of this theme. */
		|	background: hsla(0, 0%, 100%, .5);
		|}
		|
		|.token.atrule,
		|.token.attr-value,
		|.token.keyword {
		|	color: #07a;
		|}
		|
		|.token.function,
		|.token.class-name {
		|	color: #DD4A68;
		|}
		|
		|.token.regex,
		|.token.important,
		|.token.variable {
		|	color: #e90;
		|}
		|
		|.token.important,
		|.token.bold {
		|	font-weight: bold;
		|}
		|.token.italic {
		|	font-style: italic;
		|}
		|
		|.token.entity {
		|	cursor: help;
		|}
		|";
		
КонецФункции

Функция ТаблицаСтилей_tasks()
	
	Возврат
		"/*ОПИСАНИЕ ЗАДАЧ*/
		|.kanbangroup{overflow:hidden;position:relative;font-size:14px;white-space:nowrap;font-weight:500;}
		|.tasks{position: absolute;width:100%;overflow:hidden;}
		|.tasks h1{font-size:12px;border-bottom: 1px solid #f4f4f4;padding-bottom:3px;margin-bottom:15px;}
		|.task{padding:8px 5px; margin:8px 0 0 0;border:1px solid #E6E6E6;border-radius:5px;background-color:white;border-left-width:2px;border-left-color:red;}
		|.task .title{font-size:12px; border:0}
		|.task .title img{margin: 0 5px 0 0;width:16px; height:16px;border-width: 0;}
		|.task .title h2{padding:0 0 0 2px;margin: 0 0 2px 21px;font-size:13px; border:0;font-weight:400;}
		|.task .title h2 a{color:#26587e; text-decoration:none;}
		|.task .title h2 a:hover{color:#4296d6;}
		|.task .title .stat{color:#687580;font-size:11px;border:1px solid #9DB6C9;border-radius:50%;padding:1px 5px;text-align:center;}
		|.task .title .stat img{width:16px;height:16px;}
		|.task .title .stat .text{display:table-cell;vertical-align:middle;}
		|.task .taskbody{font-size:12px;border:0;text-align:justify;margin:5px 0 0 0;}
		|.task .text{display:table-cell;}
		|.task .info{display:table-cell;color:#666;font-size:11px;margin:5px 0 0 0;}
		|.task .info .expired{float:right;color:red;font-size:11px;}
		|.task .info img{height:16px;width:16px;margin:0 1px;border:0;}
		|.task .info .text{vertical-align:1px;}
		|.task .info .imgtext{display:inline;}
		|.task .tags{position:relative;}
		|.task .tag{margin-right:3px;margin-top:3px;margin-bottom:3px;display:inline-block;padding:0.25em 0.4em;font-size:75%;line-height:1;text-align:center;white-space:nowrap;vertical-align:baseline;}
		|.scrollvalue{display:none}
		|";
	
КонецФункции

#КонецОбласти