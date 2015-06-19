
var ready = function() {
    var docHeight = $(window).height();
    var footerHeight = $('#footer').height();
    var footerTop = $('#footer').position().top + footerHeight;

    if (footerTop < docHeight) {
        $('#footer').css('margin-top', 10+ (docHeight - footerTop) + 'px');
    }
};

$(document).on('page:load', ready);
$(document).ready(ready);