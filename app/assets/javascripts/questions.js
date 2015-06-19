/**
 * Created by melalonso on 06/06/15.
 */
var ready = function() {

    $("body").on('change', ".select-qtype", function(){
        var type = $(this).val();
        var qNumber = $(this).attr("question");
        $(".answer-q"+qNumber).attr("type",type);
    });

};

$(document).on('page:load', ready);
$(document).ready(ready);