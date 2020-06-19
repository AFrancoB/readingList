(// for individual entries
~biblio= "Couldry, Nick, and Ulises A. Mejias. 2019. 'Data colonialism: Rethinking big data’s relation to the contemporary subject'. Television & New Media 20, no. 4. pp. 336-349";

~notes.(
	"Data colonialism: Rethinking big data’s relation to the contemporary subject",
	"Nick Couldry & Ulises A. Mejias",
	"network technology",
	~idPages.(~biblio),
	~biblio, // biblio
	"", // url
	True,
	"

"
)
)


McMahon, Rob. "From digital divides to the first mile: Indigenous peoples and the network society in Canada." International Journal of Communication 8 (2014): 25.




(// for book chapters
~chapters= [
	["Introduction", "Introduction", "pp. 1-43"],
	[4, "Tactic shadows and new media", "pp. 284-321"]
];

~chapters.collect({|item|

	~notes.(
		item[1].asString,
		"Caleb Kelly",
		"sound studies",
		~countPages.(item[2].asString),
		"Kelly, Caleb. 2009."++ item[1].asString ++"Chapter "++ item[0].asString++ "Cracked Media: The sounds of malfunction. MIT Press"++" " ++item[2].asString, // biblio
		"https://docs.google.com/viewer?a=v&pid=sites&srcid=ZGVmYXVsdGRvbWFpbnxlbGluc3RhbnRlZGVzaXNpZm8zfGd4OjZiMmVmNzI0MmVmMmFhMTE", // url
		True,
		"
cracked media

"
)

})
)
~order.("listaOrdenada");

~query.("live coding")  // 25 units for network and live coding music  // 5 units to spare in something else
~query.("network music")

~query.("sound studies")

~lookFor.("Building on the", "reading")


~query.("live coding").collect({|item|  item[1].postln})

~query.("network music").collect({|item|  item[1].postln})


~query.("network technology").collect({|item|  item[1].postln})


// meeting

// scope of the field survay and topic paper.

// talk a little bit in depth about my phd work. conferences, concerts, etc.

// talk about the list and how to make it more accurate.




// nime proceedings check for lc and nm

// isea proceedings telematics

// audible empire!!!

// less ascott and more stuff for telematic art

// internet art and net art!!!!!!


// virtual reality in relationship with VR.






















