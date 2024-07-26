$(document).bind('keypress', function(e) {
    if(e.code == "Space"){
        if(allowed) emit('richrp:afterloading')
    }
});