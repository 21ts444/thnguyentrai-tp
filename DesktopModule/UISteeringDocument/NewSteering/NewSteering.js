
(function ($) {
    $.fn.EffectSteering = function (options) {
        var self = $(this);
        var defaults = { time: 5000, effect: 'default', count: 4 };
        var opts = jQuery.extend(defaults, options);
        var itemContainer = self.find('.DetailScroll');
        var container = $(this).find(".DetailScroll").first();
        var ListItems = container.children(".ListItem");
        var list = container.children(".ListItem").first();
        var items = list.children(".item");
        var btnUp;
        var btnDown;

        var n = 0;
        //for (var i = 0; i < items.length; i++) {
        //    n += $(items[i]).height();
        //}
        n = $(items.first()).outerHeight() * items.length;
        //-----------------------------------------------
        
        var buttonState = function () {
            //alert(list.position().top);
           // alert(n + list.position().top);
             if (list.position().top >= 0) {
                 btnDown.hide();
                 btnUp.show();
             }
             else if (n + (list.position().top) <= $(container).outerHeight() + 5) {
                 btnDown.show();
                 btnUp.hide();
             }
             else {
                 btnDown.show();
                 btnUp.show();
             }
        }
        var createScrollButton = function () {
            btnUp = $('<div class="SteeringScrollUp"></div>').prependTo(itemContainer);
            btnDown = $('<div class="SteeringScrollDown"></div>').appendTo(itemContainer);
            btnUp.css({ 'position': 'absolute', 'left': container.width() / 2+'px', 'top': '0' });
            btnDown.css({ 'position': 'absolute', 'left': container.width()/2+'px', 'top': self.height() - 100 });
            btnUp.click(function () {
                buttonState();
                var targetOffset = $(list).position().top;
                $(list).animate({ 'top': targetOffset - $(items[0]).height() }, 100);
            });
            btnDown.click(function () {
                buttonState();
                var targetOffset = $(list).position().top;
                $(list).animate({ 'top': targetOffset + $(items[0]).height() }, 100);
            });
            //btnDown.hide();
            //btnUp.hide();

        };
        //------------------------------------end button scroll
        if (items.length > opts.count) {
            container.height($(items.first()).outerHeight() * opts.count);
            if (opts.effect == "fade") {
                var startIndex = 0;
                if (items.length == startIndex)
                    startIndex = items.length - opts.count;
                var getNextIndex = function (i, s) {
                    return (s + i) % items.length;
                }
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
                var call = setInterval(changeFade, opts.time);
                container.hover(function () {
                    clearInterval(call);
                }, function () {
                    call = setInterval(changeFade, opts.time);
                });
            }
            else if(opts.effect=="scroll") {
                list.height(list.height() + container.height());
                var items = list.children(".item");
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
            else if(opts.effect=="auto")
            {
                var scrollSpeed = 2;
                var totalheight = $(items.first()).outerHeight() * items.length;
                $(list).css('top', 0);
                var scroll = setInterval(function (i) {
                    if (parseInt($(list).css('top')) * (-1) < totalheight) { //- $(container).outerHeight()+5
                        // move scroller upwards
                        offset = parseInt($(list).css('top')) - scrollSpeed + "px";
                        $(list).css({ 'top': offset });
                    }
                    else {
                        offset = parseInt($(list).parent().height()) + 8 + "px";
                        $(list).css({ 'top': offset });
                    }
                }, 100);
                $(container).mouseover(function () {
                    scrollSpeed = 0;
                });
                $(container).mouseout(function () {
                    scrollSpeed = 2;
                });
            }

        }
        else $(self).css('height', ($(items.first()).outerHeight() + 25) * opts.count);
        if (opts.effect == "auto") {
            itemContainer.mouseover(function () {
            buttonState();
        });
        itemContainer.mouseout(function (ev) {
                btnDown.hide();
                btnUp.hide();
        });
        createScrollButton();
        }
    };
})(jQuery);
