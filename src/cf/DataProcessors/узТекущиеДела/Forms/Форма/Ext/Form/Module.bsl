﻿
&НаКлиенте
Процедура КомандаОбновить(Команда)
	ОбновитьТекущиеДелаНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбновитьТекущиеДелаНаСервере()
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.ОбновитьНаСервере();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");	
КонецПроцедуры 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Объект.НаДату = ТекущаяДата();
	ЗаполнитьТекущиеДелаНаСервере();
	УстановитьВидимостьДоступность();
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность()
	Элементы.ТЧТекущиеДелаДопСведения.Видимость = Ложь;
	Если ПоказыватьДопСведения Тогда
		Элементы.ТЧТекущиеДелаДопСведения.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры 

&НаСервере
Процедура ЗаполнитьТекущиеДелаНаСервере()
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.ЗаполнитьТекущиеДела();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры 

&НаСервере
Процедура СохранитьТекущиеДелаНаСервере()
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.СохранитьТекущиеДела();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры 

&НаКлиенте
Процедура ПриЗакрытии()
	ПриЗакрытииНаСервере();
КонецПроцедуры


&НаСервере
Процедура ПриЗакрытииНаСервере()
	СохранитьТекущиеДелаНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура ТЧТекущиеДелаПриИзменении(Элемент)
	СтрокаТЧТекущиеДела = Элемент.ТекущиеДанные;
	СтрокаТЧТекущиеДела.Порядок = СтрокаТЧТекущиеДела.НомерСтроки;
КонецПроцедуры


&НаКлиенте
Процедура НаДатуПриИзменении(Элемент)
	ЗаполнитьТекущиеДелаНаСервере();
КонецПроцедуры


&НаСервере
Процедура ТЧТекущиеДелаПередУдалениемНаСервере(МассивТекущихДел)
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.УбратьТекущееДело(МассивТекущихДел);
КонецПроцедуры


&НаКлиенте
Процедура ТЧТекущиеДелаПередУдалением(Элемент, Отказ)
	МассивВыделенныхСтрок = Элемент.ВыделенныеСтроки;
	МассивТекущихДел = ПолучитьМассивТекущихДелПоВыделеннымСтрокам(МассивВыделенныхСтрок);
	ТЧТекущиеДелаПередУдалениемНаСервере(МассивТекущихДел);
КонецПроцедуры

&НаКлиенте
Функция ПолучитьМассивТекущихДелПоВыделеннымСтрокам(МассивВыделенныхСтрок)
	МассивТекущихДел = Новый Массив();
	Для каждого ЭлМассиваВыделенныхСтрок из МассивВыделенныхСтрок цикл
		ИдентификаторСтроки = ЭлМассиваВыделенныхСтрок;
		
		СтрокаТЧТекущиеДела = Объект.ТЧТекущиеДела.НайтиПоИдентификатору(ИдентификаторСтроки);
		пТекущееДело = СтрокаТЧТекущиеДела.ТекущееДело;
		МассивТекущихДел.Добавить(пТекущееДело);
	Конеццикла;	
	Возврат МассивТекущихДел;
КонецФункции


&НаКлиенте
Процедура КомандаВыполнил(Команда)
	МассивВыделенныхСтрок = Элементы.ТЧТекущиеДела.ВыделенныеСтроки;
	Для каждого ЭлМассиваВыделенныхСтрок из МассивВыделенныхСтрок цикл
	    ИдентификаторСтроки = ЭлМассиваВыделенныхСтрок;
		
		СтрокаТЧТекущиеДела = Объект.ТЧТекущиеДела.НайтиПоИдентификатору(ИдентификаторСтроки);			
		СтрокаТЧТекущиеДела.ДатаВыполнения = ТекущаяДата();
		СтрокаТЧТекущиеДела.Выполнено = Истина;
	Конеццикла;	
	
	Объект.ТЧТекущиеДела.Сортировать("Выполнено, ДатаВыполнения УБЫВ");
КонецПроцедуры


&НаКлиенте
Процедура КомандаПоказатьДопСведения(Команда)
	ПоказыватьДопСведения = НЕ ПоказыватьДопСведения;
	Элементы.ТЧТекущиеДелаКомандаПоказатьДопСведения.Пометка = ПоказыватьДопСведения;
	УстановитьВидимостьДоступность();
КонецПроцедуры


&НаКлиенте
Процедура ТЧТекущиеДелаТекстСодержанияПриИзменении(Элемент)
		
КонецПроцедуры

&НаКлиенте
Процедура КомандаПредыдущийПериод(Команда)
	НаДатуНовая = ПолучитьНаДатуНовая(-1);
	ИзменитьНаДату(НаДатуНовая);
КонецПроцедуры

&НаКлиенте
Процедура КомандаНаДату(Команда)
	НаДатуНовая = НачалоДня(ТекущаяДата());
	ИзменитьНаДату(НаДатуНовая);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗаголовокКомандаНаДату()
	пЗаголовок = "";
	Если НачалоДня(Объект.НаДату) = НачалоДня(ТекущаяДата()) Тогда
		пЗаголовок = "Сегодня";
	Иначе
		пЗаголовок = Формат(Объект.НаДату,"ДФ='dd.MM ддд'");
	Конецесли;
	Элементы.ТЧТекущиеДелаКомандаНаДату.Заголовок = пЗаголовок;
КонецПроцедуры 

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьЗаголовокКомандаНаДату();
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьНаДату(НаДатуНовая)
	Объект.НаДату = НаДатуНовая;
	ОбновитьТекущиеДелаНаСервере();
	ОбновитьЗаголовокКомандаНаДату();	
КонецПроцедуры 

&НаКлиенте
Функция ПолучитьНаДатуНовая(Сдвиг) 
	Если Сдвиг =  1 Тогда
		НаДатуНовая = НачалоДня(КонецДня(Объект.НаДату) + 1);
	Иначе
		НаДатуНовая = НачалоДня(Объект.НаДату - 1);
	Конецесли;
	//Если НаДатуНовая > ТекущаяДата() Тогда
	//	НаДатуНовая = Объект.НаДату;	
	//Конецесли;
	
	Возврат НаДатуНовая;
КонецФункции 

&НаКлиенте
Процедура КомандаСледующийПериод(Команда)
	НаДатуНовая = ПолучитьНаДатуНовая(1);
	ИзменитьНаДату(НаДатуНовая);
КонецПроцедуры

&НаКлиенте
Процедура ТЧТекущиеДелаПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока Тогда
		СтрокаТЧТекущиеДела = Элемент.ТекущиеДанные;
		СтрокаТЧТекущиеДела.ДатаСоздания = ТекущаяДата();
		СтрокаТЧТекущиеДела.ДатаТекущегоДела = СтрокаТЧТекущиеДела.ДатаСоздания;
		СтрокаТЧТекущиеДела.Порядок = СтрокаТЧТекущиеДела.НомерСтроки;
	Конецесли;
КонецПроцедуры
