String j(String s) =>
        // build a string from an iterable
        String(
               // make an indexed version of the input string
               s.indexed
               // filter this by ...
                .filter(
                   // ... checking if each character is inside
                   // the string up to that index
                   (e)=>!e.item in s[0:e.key])
               // and now use only the characters, not the indexes.
                *.item);