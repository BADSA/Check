/**
 # Instituto Tecnologico de Costa Rica
 # Curso: Introduccion al desarrollo de aplicaciones para web
 # IV Tarea Programada
 # Ruby on Rails/ Bootstrap/ TDD y BDD
 # Profesor: Erick Hernandez
 # Estudiantes:
 #     - Daniel Solis Mendez / 2013099996
 #     - Melvin Elizondo Perez / 2013099997
 # I Semestre 2015
 */

// Controls all the events and actions
// that involved the test.

var ready = function() {


    // To transform the element with .datetimepicher class in an animated element.
    $('.datetimepicker').datetimepicker({
        mask:true
    });

    $("body").on("click", ".close-alert", function() {
        $("#error-alert").hide();
    });

    // To request the server the template for a new question
    // when creating a test.
    $("#add-question").click(function(){
        var currQuestion = $("#current-question").text();
        $("#current-question").removeAttr("id");
        $.ajax({
            method: 'get',
            url: "/questions/new",
            data: {curr:currQuestion},
            async: false
        }).done(function(emptyQuestion){
            $("#questionary").append(emptyQuestion);
        }).fail(function(jqXHR, textStatus){
            alert("Ups accion no disponible.");
        });
    });


    function validateEmpty() {
        var someEmpty =  $('.new-test input').filter(function(){
                return $.trim(this.value).length === 0;
            }).length > 0;

        if ($("#test-begins").val() === "____/__/__ __:__"
        || $("#test-ends").val() === "____/__/__ __:__" ) return true;

        return someEmpty
    }

    // Creates a new test collecting the information given by the user.
    $("#create-test").click(function(){
        if (validateEmpty()){ alert("Existen campos en blanco!\n Por favor llene todos los campos."); return; }
        var name = $("#test-name").val();
        var description = $("#test-description").val();
        var beginsAt = $("#test-begins").val();
        var endsAt = $("#test-ends").val();
        var userID = $("#user-id").val();

        // Call the server and send it required information
        // for a test.
        var testID = createTest("/tests",
            {test:{name:name,description:description,begins_at:beginsAt, ends_at:endsAt,user_id:userID}});


        // Iterate over each of the questions and send
        // data to server.
        var idx=0;
        $("#questionary > li").each(function( index , li) { // Every li represents a question.
            var title   = $(this).find("input[name='title']").val();
            var type    = $(this).find("select[name='type']").val();
            var choice1 = $(this).find("input[name='choice1']").val();
            var choice2 = $(this).find("input[name='choice2']").val();
            var choice3 = $(this).find("input[name='choice3']").val();
            var choice4 = $(this).find("input[name='choice4']").val();

            var rightAnswer = "";
            idx = index + 1;
            // Get information of right answer
            $(this).find("input[name='right-answer"+idx+"']:checked").each(function() {
                rightAnswer += this.value+",";
            });
            // Get rid of last comma.
            rightAnswer = rightAnswer.substr(0,rightAnswer.length-1);

            // Add the question.
            $.ajax({
                method: 'post',
                url: "/questions",
                data: {question:{title:title,type:type,choice1:choice1,choice2:choice2,
                    choice3:choice3,choice4:choice4,right_answer:rightAnswer,test_id:testID}},
                async: false
            }).fail(function(jqXHR, textStatus){
                alert("Ups accion no disponible.");
            });

        });

        // Patch questions_amount to test.
        $.ajax({
            method: 'patch',
            url: "/tests/"+testID,
            data: {test:{questions_amount:idx}},
            async: false
        }).fail(function(jqXHR, textStatus){
            alert("Ups accion no disponible.");
        });

        window.location = "/"
    });





    // Handles the event to score a test
    // when the user has finished it.
    $("#score-test").click(function(){
        var userID = $("#user-id").val();
        var testID = $("#test-id").val();

        var userAnswers = [];
        // Iterate collecting user answers
        // to test questions.
        $(".answer-list").each(function( index , li) {
            var userAnswer = "";
            var idx = index + 1;
            $(this).find("input[name='user-answer"+idx+"']:checked").each(function() {
                userAnswer += this.value+",";
            });
            userAnswer = userAnswer.substr(0,userAnswer.length-1);
            userAnswers.push(userAnswer);
        });

        var score=null;
        // Send answers to server to
        // score test.
        $.ajax({
            method: 'get',
            url: "/tests/"+testID+"/score",
            data: {answers:userAnswers},
            async: false
        }).done(function(scr){
            score = scr;
        }).fail(function(jqXHR, textStatus){
            alert("Ups accion no disponible.");
        });

        // Create user exam and mark it as complete.
        var testAnswerID = createTest("/test_answers",
            {test_answer:{status:"complete",user_id:userID,test_id:testID,score:score}} );

        window.location = "/"
    });




    // Function to create a new test or a
    // test complete or incomplete solution.
    function createTest(url,data){
        var testID = null;
        $.ajax({
            method: 'post',
            url: url,
            data: data,
            async: false
        }).done(function(id){
            testID = id;
        }).fail(function(jqXHR, textStatus){
            alert("Ups accion no disponible.");
        });
        return testID;
    }


    $("#save-answers").click(function(){
        var testID = $("#test-id").val();
        var userID = $("#user-id").val();

        var userAnswers = [];
        // Iterate collecting user answers
        // to test questions.
        $(".answer-list").each(function( index , li) {
            var userAnswer = "";
            var idx = index + 1;
            $(this).find("input[name='user-answer"+idx+"']:checked").each(function() {
                userAnswer += this.value+",";
            });
            userAnswer = userAnswer.substr(0,userAnswer.length-1);

            userAnswers.push(userAnswer);
        });


        var testAnswerID = getPrevTestID(testID,userID);

        if (testAnswerID == "no"){
            alert("creatin' xq no exist");
            testAnswerID= createTest("/test_answers",
            {test_answer:{status:"incomplete",user_id:userID,test_id:testID}} );
        }

        var savedAt = null;
        $.ajax({
            method: 'get',
            url: "/test_answers/"+testAnswerID+"/save",
            data: {answers:userAnswers},
            async: false
        }).done(function(response){
            savedAt = response;
        }).fail(function(jqXHR, textStatus){
            alert("Ups accion no disponible.");
        });

        window.location = "/"
    });


    function getPrevTestID(testID,userID){
        var test = null;
        $.ajax({
            method: 'get',
            url: "/test_answers/find",
            data: {testID:testID,userID:userID},
            async: false
        }).done(function(response){
            test = response;
        }).fail(function(jqXHR, textStatus){
            alert("Ups accion no disponible.");
        });
        alert("Existe el test_answer "+test);
        return test;
    }


    $(".test-filter").click(function(){
        var value = $(this).children("a").attr('value');
        console.log(value);
        $.ajax({
            type: 'get',
            url: '/tests',
            data: {status: value}
        }).done(function(response){
            console.log(response);
            if (value == 'complete'){
                $("#tab1").html(response);
            }else if (value == 'incomplete'){
                $("#tab2").html(response);
            }else {
                $("#tab3").html(response);
            }
        });
    });
};



$(document).on('page:load', ready);
$(document).ready(ready);