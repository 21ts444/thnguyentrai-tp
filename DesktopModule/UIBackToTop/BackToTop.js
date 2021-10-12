
    jQuery(document).ready(function () {
        var offset = 50;
        var duration = 300;
        var button = $('.UIBackTopTopControl');
        button.hide();
        jQuery(window).scroll(function () {
            if (jQuery(this).scrollTop() > offset) {
                button.fadeIn(duration);
            } else {
                button.fadeOut(duration);
            }
        });

        button.click(function (event) {
            event.preventDefault();
            jQuery('html, body').animate({ scrollTop: 0 }, duration);
            return false;
        })
    });