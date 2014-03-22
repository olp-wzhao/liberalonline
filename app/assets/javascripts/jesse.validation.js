function initializeValidation(){

    $("input[type='submit']").prop("disabled", true); // disable the submit button

    $("input#user_password_confirmation") // setup the formatter
        .addClass('form-control')
        .wrap('<div class=\'form-group\' />')
        .parent()
        .append('<label class=\'control-label\'>Required!</label>');

    $('input#user_password_confirmation').on('keypress keyup change blur', function(event){
        $this = $(this);
        if( ($this.val() === $('input#user_password').val()) && ($this.val() != "") ){
            $("input[type='submit']").prop("disabled", false);
            $this.parent()
                .removeClass('has-success has-error')
                .addClass('has-success')
                .children(':last')
                .text('');
        }
        else{
            $("input[type='submit']").prop("disabled", true);
            $this.parent()
                .removeClass('has-success has-error')
                .addClass('has-error')
                .children(':last')
                .text('Password must match and not be empty');
        }
    });

    //Set all
    $(function() {
        return $("input.datepicker").each(function(i) {
            return $(this).datepicker( { dateFormat: 'dd/mm/yy' } );
        });
    });

//Datepicker or Birthday field
    $("input.datepicker").formance("format_dd_mm_yyyy") // setup the formatter
        .addClass('form-control')
        .wrap('<div class=\'form-group\' />')
        .parent()
        .append('<label class=\'control-label\'>Required!</label>');

    $("input.datepicker").on( 'keyup change blur', function () { // setup the event listeners to validate the field whenever the user takes an action
            $this = $(this);
            var birthday = moment($this.val(), "DD-MM-YYYY");
            var thirteen_year_ago = moment().subtract("years", 13);
            if ( $this.formance('validate_dd_mm_yyyy') && birthday.isBefore(thirteen_year_ago)){
                $("input[type='submit']").prop("disabled", false);
                $this.parent()
                    .removeClass('has-success has-error')
                    .addClass('has-success')
                    .children(':last')
                    .text('');
            }
            else{
                $("input[type='submit']").prop("disabled", true);
                $this.parent()
                    .removeClass('has-success has-error')
                    .addClass('has-error')
                    .children(':last')
                    .text('Must be at least 13 years old to register');
            }
        });

    //Password Strength
    $("input.datepicker").formance("format_dd_mm_yyyy") // setup the formatter
        .addClass('form-control')
        .wrap('<div class=\'form-group\' />')
        .parent()
        .append('<label class=\'control-label\'>Required!</label>');

//    $("input#user_password").on( 'keyup change blur', function () { // setup the event listeners to validate the field whenever the user takes an action
//        $this = $(this);
//        if ( $this.formance('validate_password_strength')){
//            $("input[type='submit']").prop("disabled", false);
//            $this.parent()
//                .removeClass('has-success has-error')
//                .addClass('has-success')
//                .children(':last')
//                .text('');
//        }
//        else{
//            $("input[type='submit']").prop("disabled", true);
//            $this.parent()
//                .removeClass('has-success has-error')
//                .addClass('has-error')
//                .children(':last')
//                .text('Password must be a minimum of 8 characters');
//        }
//    });
}