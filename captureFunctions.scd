
~path = thisProcess.nowExecutingPath.dirname;

// function to count units read
/*~count*/


/*// function to scratch readings
~out = {};*/



~defListEntries = { |listName|

	var path = ~path;
	var list = CSVFileReader.read(path++"/"++listName++".csv"); // extract the name of the notes from a list

	var getName = list.collect({|item|   item[0][1..]   })[1..];

	var extractFromNotes;

	extractFromNotes = getName.collect({|item, iter|

		var fromFile = TabFileReader.read(path++"/notes/"++item.asString++".txt");

		fromFile[0]++"\n"++fromFile[2]++"\n"++fromFile[4]++"\n"++fromFile[6];
	});

	extractFromNotes
};

//~defListWriter.(~defListEntries.("listaOrdenada"), "definitiveList_AFB");

~defListWriter = {|listOfEntries, nameOfList|

	var path = ~path;
	var filePath = path++"/"++nameOfList++".txt";
	var newFile = File(filePath,"w");
	var defList = newFile.write("Reading list - Alejandro Franco Briones" ++ "\n" ++ "\n");

	defList.close;

	listOfEntries.collect({|item,iter|


		var orderedFile= File(filePath, "a");
		orderedFile.write((iter+1).asString ++ " " ++ item.asString.replace("[", "- ").tr($],$\n)++"\n");
		orderedFile.close


	})


};



~notes = {|name, author, zone, pages, biblio, links, list, notes|

	var path = ~path;
	var file = File(path++"/notes/"++name++".txt", "w");
	var lista = File(path++"/laLista.csv","a");
	var units = (pages/30);

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

~order = {|newFile|
	var path, list, orderedList, ordered, orderedFile, theory, netTech, lcNm, timeSoundStudies;

	path= ~path;
	list= CSVFileReader.read(~path++"/laLista.csv");
	newFile= path++"/"++newFile++".csv";
	orderedList= Array.newClear(list.size);

	(list.size-1).do{|i|
		orderedList.put(i, [list[i+1][0],list[i+1][1],list[i+1][2],list[i+1][3], list[i+1][4], list[i+1][1].split($ )[2]]);
	};
	orderedList= orderedList[0..(list.size-2)];
	orderedList= orderedList.sort({|a,b| a[5].asString > b[5] }).reverse;

	ordered= orderedList.collect({|item|  item[0..4] });

	theory= ordered.select({|item|  item[4].contains("theory")  });
	theory.postln;
	netTech= ordered.select({|item|  item[4].contains("network technology")  });
	netTech.postln;
	lcNm= ordered.select({|item|  item[4].contains("live coding") || item[4].contains("network music") });
	lcNm.postln;
	timeSoundStudies= ordered.select({|item|  item[4].contains("time studies") || item[4].contains("sound studies") });
	timeSoundStudies.postln;

	ordered= theory ++ netTech ++ lcNm ++ timeSoundStudies;

	// create file;
	orderedFile= File(newFile, "w");
	orderedFile.write("Reading Name, Author, Units, Pages"++"\n");
	orderedFile.close;

	ordered.collect({|item|
		orderedFile= File(newFile, "a");
		orderedFile.write(item.asString.replace("[", "").tr($],$\n));
		orderedFile.close
	})

};

~query = {|zoneString|
	var path, list, orderedList, ordered, orderedFile, theory, netTech, lc, nm, ts, ss, zone;

	path= ~path;
	list= CSVFileReader.read(~path++"/laLista.csv");
//	newFile= path++"/"++newFile++".csv";
	orderedList= Array.newClear(list.size);

	(list.size-1).do{|i|
		orderedList.put(i, [list[i+1][0],list[i+1][1],list[i+1][2],list[i+1][3], list[i+1][4], list[i+1][1].split($ )[2]]);
	};
	orderedList= orderedList[0..(list.size-2)];
	orderedList= orderedList.sort({|a,b| a[5].asString > b[5] }).reverse;

	ordered= orderedList.collect({|item|  item[0..4] });

	theory= ordered.select({|item|  item[4].contains("theory")  });
	netTech= ordered.select({|item|  item[4].contains("network technology")  });
	lc= ordered.select({|item|  item[4].contains("live coding") });
	nm= ordered.select({|item|  item[4].contains("network music") });
	ts= ordered.select({|item|  item[4].contains("time studies") });
	ss= ordered.select({|item|  item[4].contains("sound studies") });

	zone = switch(zoneString,
		"theory", theory,
		"network technology", netTech,
		"live coding", lc,
		"network music", nm,
		"time studies", ts,
		"sound studies", ss
	);

	(
		"The zone" + zoneString + "has:" ++ "\n" ++
	// how many items for this zone?
		"Items:" + zone.size.asString ++ "\n" ++

	// how many units?
		"Units:" + zone.collect({|item| item[2].asFloat }).sum.asString ++ "\n" ++

	// how many pages?

		"Pages:" + zone.collect({|item| item[3].asFloat }).sum.asString;
	).postln;

	zone

};


// extract from the bibliography the part of it that starts with pp. And then counts the number of pages of given article
~idPages= {|bibliostring|
	var index= bibliostring.find("pp.");
	var getPagesIndexes = bibliostring[index..(bibliostring.size)];
	if( index == nil, {"There are no page numbers or they are not formatted correctly. Consider modifying the bibliography before inputting it into thr system".postln}, {~countPages.(getPagesIndexes)});
};

~countPages= {|string|  ( 1 + string.split($.)[1].split($-)[1].asFloat) - string.split($.)[1].split($-)[0].asFloat   };


~lookFor= {|string, whereToLook|
	var path, list, look, whatZone;

	path= ~path;
	list= CSVFileReader.read(~path++"/laLista.csv");
	whatZone = switch(whereToLook,
		"author", list.select({|item|  item[1].asString.containsi(string)    }),
		"reading", list.select({|item|  item[0].asString.containsi(string)    }),
		"zone", list.select({|item|  item[4].asString.containsi(string)    })
	)
}



// function to look for key words from notes

/*~lookFor= {|keyWords, manyNotes, zone, whichList|
	var path = ~path
	var notes = path++"/notes/"
	var list = path++"whichList"++".csv";

	// choose the books from the list according to area
	// access each note and look for set of keywords
	// books that contain this words choose the top manyNotes of books containing this words

}*/



