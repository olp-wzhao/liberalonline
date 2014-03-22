jQuery(function($){
    fields = ['credit_card_number',
        'credit_card_expiry',
        'credit_card_cvc',
        //'dd_mm_yyyy',
        //'yyyy_mm_dd',
        'number',
        'phone_number',
        'postal_code',
        'alpha_length']

    $.each( fields, function (index, value) {
        $('input.'+value).formance('format_'+value)
            .addClass('form-control')
            .wrap('<div class=\'form-group\' />')
            .parent()
            .append('<label class=\'control-label\'>Required!</label>');

        $('input.'+value).on('keyup change blur', function (value) {
            return function (event) {
                $this = $(this);
                if ($this.formance('validate_'+value)) {
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
        }(value));
    });
});
