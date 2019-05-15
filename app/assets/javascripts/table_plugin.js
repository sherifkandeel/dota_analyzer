$.extend( $.fn.dataTable.ext.type.order, {
    "num-html-pre": function ( a ) {
        if(!a.includes("%"))
            return a;
        var x = a.split(" ")[0].replace("%","")
        return parseFloat( x );
    },
 
    "num-html-asc": function ( a, b ) {
        return ((a < b) ? -1 : ((a > b) ? 1 : 0));
    },
 
    "num-html-desc": function ( a, b ) {
        return ((a < b) ? 1 : ((a > b) ? -1 : 0));
    }
} );