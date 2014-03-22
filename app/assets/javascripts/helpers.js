/**
 * Created by jesse on 04/03/14.
 */
//function isEmailUnique(validate_user_url){
//    $.get(validate_user_url, { email: $('#user_email').val() })
//};

function findRiding(find_riding_url){
    $.getJSON(find_riding_url, {search: $('#user_postal_code').val()})
        .done(function(data){
            $('#riding_box').html(data.name);
            $('#user_riding_id').val(data.riding_id);
        });
};