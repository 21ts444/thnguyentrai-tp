
(function ($) {
    $.fn.Hotnews = function (options) {
        var defaults = { time: 5000, effect: 'default', count: 4 };
        var opts = jQuery.extend(defaults, options);
        var container = $(this).find(".HotnewsScroll").first();
        var list = container.children(".HotnewsList").first();
        var items = list.children(".HotnewsItem");
        if (items.length > opts.count) {
            container.height($(items.first()).outerHeight() * opts.count);
            if (opts.effect == "fade") {
                var startIndex = 0;
                if (items.length == startIndex)
                    startIndex = items.length - opts.count;
                var getNextIndex = function (i, s) {
                    return (s + i) % items.length;
                }

                items.each(function (i, j) {
                    if (i >= opts.count)
                        $(this).fadeOut(0);
                });

                var changeFade = function () {
                    var i = startIndex;
                    var k = i;
                    while (i != getNextIndex(startIndex, opts.count)) {
                        $(items[i]).fadeOut(500, function () {
                            $(items[getNextIndex(k, opts.count)]).fadeIn(500);
                            k++;
                        });
                        i = getNextIndex(i, 1);
                    }
                    startIndex = i;
                }
                var call = setInterval(changeFade, 5000);
                container.hover(function () {
                    clearInterval(call);
                }, function () {
                    call = setInterval(changeFade, 5000);
                });
            }
            else {
                list.height(list.height() + container.height());
                var items = list.children(".HotnewsItem");
                list.height(Math.ceil(list.height() / container.height()) * container.height());
                var backward = (Math.ceil(items.length / opts.count) - 1) * opts.count;
                var position = 0;
                var i = 1;
                var tmpHeight = 0;
                var first = true;
                var scrollStep = function () {
                    var scroll = 0;
                    position += i * opts.count;
                    for (var j = 0; j < position; j++) {
                        scroll += $(items[j]).outerHeight();
                    }
                    list.animate({ opacity: 0.4 }, 100);
                    container.animate({ scrollTop: scroll }, 500, function () {
                        list.animate({ opacity: 1 }, 100);
                        //scrollStop();
                    });
                    if ((position == 0 && !first) || position == backward) {
                        i = -1 * i;
                        first = false;
                    }
                };

                var call = setInterval(scrollStep, opts.time);
                container.hover(function () {
                    clearInterval(call);
                }, function () {
                    call = setInterval(scrollStep, opts.time);
                });
            }
            
        }
    }
})(jQuery);
