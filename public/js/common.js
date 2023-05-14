$(function () {
    const ham = $('#js-ham');
    const nav = $('#js-nav');
    ham.on('click', function () {
        ham.toggleClass('active');
        nav.toggleClass('active');
    });
});