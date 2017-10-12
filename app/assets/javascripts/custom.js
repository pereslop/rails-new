/**
 * Created by mkaba on 10/12/17.
 */
    $('.close-modal').click( function () {
        $('#gallery').css('display', 'none');
    });
$('.img-responsive.post').click(function () {
    $('#gallery').css('display', 'block');
    $('.pagination').css('display', 'none');
})
