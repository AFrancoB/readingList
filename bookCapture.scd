// Book Capture page

// Theory:

// Anthony Faramelli: "Resistance, Revolution and Fascism Zapatismo and Assemblage Politics",
//                    "Digital Resistance"


~path = thisProcess.nowExecutingPath.dirname;


~notes = {|name, author, zone, units, pages, biblio, links, list, notes|

	var path = ~path;
	var file = File(path++"/notes/"++name++".txt", "w");
	var lista = File(path++"/laLista.csv","a");

	file.write(
		"Reading: "++name.asString ++"\n"++"\n"++
		"Author: "++author.asString++"\n"++"\n"++
		"Units: "++units.asString++
		", Zone:"++zone.asString++"\n"++"\n"++
		"Bibliography:"++biblio.asString++"\n"++"\n"++
		"Links:"++links.asString++"\n"++"\n"++"\n"++
		"Notes:"++"\n"++ notes.asString
	);
	file.close;

	if(list== True, {
		lista.write(
			name.asString.tr($, , $ ) ++ ", " ++
			author.asString ++ ", " ++
			units.asString ++ ", " ++
			pages.asString ++ ", " ++
			zone.asString ++ "\n"
		); lista.close;
		(name.asString++" has been included in the reading list").postln
	},
	{"not included in the reading list".postln});



};

