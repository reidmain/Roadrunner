/*
Code generated while going through the 'Access Control' chapter of Apple's Swift book.
*/

// Really no code worth writing for this one. Basically all the same stuff you would except from standard public, internal and private keywords. The most important thing to none is that private means can only be reference inside the same source file. So if you really want to silo code you'll need to create extensions in seperate Swift files so that you can be sure you aren't accessing anything that is private.
// Oh and that everything defaults to internal so you explicitly have to add public in order to expose something. Mainly to stop people from accidentally releasing something that they didn't mean to. Would have saved me tons of time at Uber.
// Not even default initializers are exposed publicly if the class is public. This is great because now you can have classes that aren't instantiable.
// Protocols automatically pass on their access level to their variables and members so it is impossible for you to publicly expose a protocol but hide some of the things it adheres to.