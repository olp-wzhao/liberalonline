function initializeValidation(){
    $( function() {
        $("input[type='submit']").prop("disabled", true); // disable the submit button
        //$(".password_confirmation_error").hide();
        $(".help-block").hide();

        $("input#user_email") // setup the formatter
            .on( 'change blur', function (event) { // setup the event listeners to validate the field whenever the user takes an action
                if ( $(this).formance('validate_email') )
                    $("input[type='submit']").prop("disabled", false); // enable the submit button if valid phone number
                else
                    $("input[type='submit']").prop("disabled", true); // disable the submit button if invalid phone number
            });
//
//        $('input#user_password').on('keyup', function(){
//           console.log('test');
//        });
//
//        $('input#user_password').on('change blur', function(){
//            $('#user_password.help-block').hide();
//        });

        $('input#user_password_confirmation').on('change blur', function(event){
            if($(this).val() === $('input#user_password').val()){
                $(".password_confirmation_error").hide();
                $("input[type='submit']").prop("disabled", false); // enable the submit button if valid phone number
            }
            else{
                $(".password_confirmation_error").show();
                $("input[type='submit']").prop("disabled", true);
            }
        });

        $("input.phone_number").formance("format_phone_number") // setup the formatter
            .on( 'keyup change blur', function (event) { // setup the event listeners to validate the field whenever the user takes an action
                if ( $(this).formance('validate_phone_number') )
                    $("input[type='submit']").prop("disabled", false); // enable the submit button if valid phone number
                else
                    $("input[type='submit']").prop("disabled", true); // disable the submit button if invalid phone number
            });

        $("input.postal_code").formance("format_postal_code") // setup the formatter
            .on( 'keyup change blur', function (event) { // setup the event listeners to validate the field whenever the user takes an action
                if ( $(this).formance('validate_postal_code') )
                    $("input[type='submit']").prop("disabled", false); // enable the submit button if valid phone number
                else
                    $("input[type='submit']").prop("disabled", true); // disable the submit button if invalid phone number
            });

        $(function() {
            return $("input.datepicker").each(function(i) {
                return $(this).datepicker();
            });
        });

        $("input.datepicker").formance("format_dd_mm_yyyy") // setup the formatter
            .on( 'keyup change blur', function (event) { // setup the event listeners to validate the field whenever the user takes an action
                if ( $(this).formance('validate_dd_mm_yyyy') )
                    $("input[type='submit']").prop("disabled", false); // enable the submit button if valid phone number
                else
                    $("input[type='submit']").prop("disabled", true); // disable the submit button if invalid phone number
            });
    });
}