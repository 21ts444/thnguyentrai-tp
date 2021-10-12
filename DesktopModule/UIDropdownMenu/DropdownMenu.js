﻿/// <reference path="/Scripts/jquery-1.7.1.min.js" />

(function ($) {
    $.fn.DropdownMenu = function (options) {
        var params = { menushow: 200, aticleshow: 4000 };
        params = jQuery.extend(options, params);
        var main = $(this);
        var menulist = main.children('.MenuList');
        var menuitems = menulist.find('li').hover(
        function () { $(this).children('ul').show(500); },
        function () { $(this).children('ul').hide(); }
        );

        var advancebar = main.children('.AdvanceBar');
        var articles = advancebar.children('.NewsBar').children('.item');
        var interval;

        var selectedArticle;
        var articleRun = function () {
            i++;
            if (i == articles.length) i = 0;
            selectedArticle.hide('blind', 200, function () { selectedArticle = $(articles[i]).show('slide', params.menushow); })
        };

        if (articles) {
            selectedArticle = $(articles[0]).show();
            var i = 0;
            if (articles.length > 1) {

                articles.hover(
                function () { clearInterval(interval); },
                function () { interval = setInterval(function () { articleRun() }, params.aticleshow); }
                );

                interval = setInterval(function () { articleRun() }, params.aticleshow);
            }
        }
    }

})(jQuery);