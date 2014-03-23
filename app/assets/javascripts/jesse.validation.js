function initializeValidation(){

    var spinner_opts = {
        lines: 13, // The number of lines to draw
        length: 20, // The length of each line
        width: 10, // The line thickness
        radius: 30, // The radius of the inner circle
        corners: 1, // Corner roundness (0..1)
        rotate: 0, // The rotation offset
        direction: 1, // 1: clockwise, -1: counterclockwise
        color: '#000', // #rgb or #rrggbb or array of colors
        speed: 1, // Rounds per second
        trail: 60, // Afterglow percentage
        shadow: false, // Whether to render a shadow
        hwaccel: false, // Whether to use hardware acceleration
        className: 'spinner', // The CSS class to assign to the spinner
        zIndex: 2e9, // The z-index (defaults to 2000000000)
        top: 'auto', // Top position relative to parent in px
        left: 'auto' // Left position relative to parent in px
    };

    $(function(){

        $('input#user_email').formance('format_email')
            .addClass('form-control')
            .wrap('<div class=\'form-group\' />')
            .parent()
            .append('<label class=\'control-label\'>Required!</label>');

        $('input#user_email').on('keyup', function () {
            return function () {
                $this = $(this);
                if ($this.formance('validate_email')) {
                    $("input[type='submit']").prop("disabled", false);
                    $this.parent()
                        .removeClass('has-success has-error')
                        .addClass('has-success')
                        .children(':last')
                        .text('');
                } else {
                    $("input[type='submit']").prop("disabled", true);
                    $this.parent()
                        .removeClass('has-success has-error')
                        .addClass('has-error')
                        .children(':last')
                        .text('Invalid');
                }
            }
        }());

        $('input#user_email').on('change blur', function() {
            $this = $(this);
            console.log('unique email check');
            $this.append('<div id=\'spinner\'></div>');
            var spinner = new Spinner(spinner_opts).spin($('#spinner'));
            setTimeout(function(){
                $.get("<%= validate_user_url %>", { email: $('#user_email').val() })
                    .done(function(){
                        spinner.stop();
                    });
            }, 5000);
        });

        $("#user_postal_code").blur( function() {
            $.getJSON("<%= find_riding_url %>", {search: $("#user_postal_code").val()})
                .done(function(data){
                    $("#riding_box").html(data.name);
                    $('#riding_id').val(data.riding_id);
                });
        });
    });

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