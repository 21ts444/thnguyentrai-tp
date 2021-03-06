/// <reference path="jquery-1.7.1.min.js" />

var jDialog = function (options) {

    var params = { url: "", width: 350, height: 250, html: "", title: "", close: function () { } };
    params = jQuery.extend(params, options);

    var s = '<div class="jMask"></div>';
    var divMask = $(s).appendTo($('body'));
    var jContainer = $('<div class="jContainer"><div class="jBox"><div class="jTitle"></div><iframe frameborder="0" class="jFrame"></iframe></div></div>').appendTo($('body'));
    var jTitle = jContainer.find('.jTitle').text(params.title);
    var jBox = jContainer.find('.jBox');
    var jFrame = jContainer.find('iframe');
    divMask.height($(document).height()).show();
    var buttonClose = $('<span class="jClose"></span>').appendTo(jTitle).click(function () {
        divMask.hide(200, function () { jContainer.remove(); params.close(); divMask.remove() });
    });

    jFrame.css({ width: params.width, height: params.height });

    if (params.html != "") {
        jFrame.remove();
        jContainer.css({ width: params.width, height: params.height });
        jBox.html(params.html);
    }
    else {
        jFrame.attr("src", params.url);
    }

    var showMe = function () {
        var itop = ($(window).height() - jContainer.height()) / 2 + $(window).scrollTop();
        var ileft = ($(window).width() - jContainer.width()) / 2;
        jContainer.css({ top: itop, left: ileft });
    };

    showMe();
    $(window).scroll(function () { showMe(); });
}