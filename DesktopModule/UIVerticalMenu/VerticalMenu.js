(function ($) {
    $.fn.VerticalMenu = function (options) {
        var params = { showsubfrom: 0, effectivetime: 0 };
        params = jQuery.extend(params, options);
        var main = $(this);
        main.find('.dropdown').hide();
        main.find('li').hover(
            function () { $(this).children('.dropdown').show(params.effectivetime); },
            function () { $(this).children('.dropdown').hide(); }
        );
    }
})(jQuery);