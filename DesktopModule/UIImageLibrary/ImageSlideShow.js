(function ($) {
    $.fn.ImageSlideShow = function (options) {
        var defaults = { effecttime: 5000, effect: 'blind', width: $(this).parent().width(), height: $(this).parent().width() * 3 / 4 };
        var opts = jQuery.extend(defaults, options);
        var itemcontainer = $($(this).children('.SlideShowItem'));
        var btnnext = $(itemcontainer).find('.next');
        var btnprev = $(itemcontainer).find('.prev');
       
        
        //alert($(this).attr("class"));
        var img = $($(this).find('.image-item'));
        var title = $($(this).find('.image-title'));
        var idx = 0;
        var c = 1;
        var x = 0;
        var loop;
        var thumbs = $(this).find('.ThumbList li');
        var divThumb = $(this).find('.div-thumb');
        var ulThumb = $(this).find('.ThumbList');
        var divW = divThumb.width();
        var last_li = ulThumb.find('li:last-child');
        var img_thumb = divThumb.find('img.image-thumb');
        var idx_temp=-1;
        img.width(opts.width);
        img.height(opts.height);
        itemcontainer.height(opts.height);
        btnnext.css({ 'top': $(img).height() / 2 - $(btnnext).height() / 2 });
        btnprev.css({ 'top': $(img).height() / 2 - $(btnprev).height() / 2 });
        
        $(btnnext).click(function () {
            
            if (x === img.length-1)
                x = 0;
            else
                x += 1;
            
            $(img).fadeOut(-1);
                    $(title).fadeOut(-1);
                    $(img).eq(target).fadeIn(100);
                    $(title).eq(target).fadeIn(100);
            
        });
        $(btnprev).click(function () {
            if (x == 0)
                x = img.length-1;
            else
                x -= 1;
            $(img).fadeOut(-1);
                    $(title).fadeOut(-1);
                    $(img).eq(target).fadeIn(100);
                    $(title).eq(target).fadeIn(100);
        });
        thumbs.click(function () {
            //clearInterval(loop);
            var target = $(this).index();
            idx_temp = idx;
            img_thumb.removeClass('selected');
            img_thumb.eq(target).addClass('selected');
            //idx = target;
            //alert(target);
            switch (opts.effect) {
                case 'blind':
                    $(img).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000);
                    $(title).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000).fadeTo(10, 0.7);
                    $(img[target]).effect(opts.effect, { mode: 'show', direction: 'horizontal' }, 1000);
                    $(title[target]).effect(opts.effect, { mode: 'show', direction: 'horizontal' }, 1000).fadeTo(10, 0.7);
                    break;
                case 'slide':
                    $(img).fadeOut(-1);
                    $(title).fadeOut(-1);
                    $(img).eq(target).fadeIn(100);
                    $(title).eq(target).fadeIn(100);
                    break;
            }
            
        });
        divThumb.mousemove(function (e) {
            clearInterval(loop);
            ulThumb.removeAttr('style');
            var ulWidth = last_li[0].offsetLeft + last_li.outerWidth();
            var left = (e.pageX - divThumb.offset().left) * (ulWidth - divW) / divW;
            divThumb.scrollLeft(left);
            //$('.abc').html('e.PageX:' + e.pageX + '<br/>last_li[0].offsetLeft: ' + last_li[0].offsetLeft + '<br/> last_li.outerWidth(): ' + last_li.outerWidth() + '<br/> divThumb.offset().left: ' + divThumb.offset().left + '<br/> ulWidth: ' + ulWidth + '<br/> divW: ' + divW + '<br/> (ulWidth - divW) / divW: ' + (ulWidth - divW) / divW + '<br/> left: ' + left)
        });
        title.fadeTo('slow', 0.7);
        img.hide();
        title.hide();
        $(img[idx]).show();
        $(title[idx]).show().fadeTo('slow', 0.7);
        img_thumb.removeClass('selected').first().addClass('selected');
       
        var interval = function () {
            loop = setInterval(function () {
                if (idx === img.length - 1)
                    idx = 0;
                else
                    idx += 1;
                c++;
                //idx++;
                if (idx >= Math.floor(opts.width / last_li.outerWidth())) {
                    //alert(Math.floor(opts.width / last_li.outerWidth()));
                    if (idx === img_thumb.length-1) {
                        idx = 0; c = 0;
                    }
                    ulThumb.animate({ 'left': '-' + ((last_li.outerWidth() * c) - opts.width) + 'px' });
                    img_thumb.removeClass('selected');
                    img_thumb.eq(idx).addClass('selected');
                }
                else {
                    ulThumb.animate({ 'left': '0px' });
                    img_thumb.removeClass('selected');
                    img_thumb.eq(idx).addClass('selected');
                }
                
                switch (opts.effect) {
                    case 'blind':
                        //idx++;
                        //if (idx == img.length) { idx = -1; return; }
                        //$(img).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000);
                        //$(title).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000);
                        //$(img).eq(idx).effect(opts.effect, { mode: 'show', direction: 'horizontal' }, 1000);
                        //$(title).eq(idx).effect(opts.effect, { mode: 'show', direction: 'horizontal' }, 1000);
                        $(img[idx]).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000);
                        $(title[idx]).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000).fadeTo(10, 0.7);
                        //idx++;
                        //if (idx == img.length) {
                        //    idx = 0;
                        //}
                        $(img[idx]).effect(opts.effect, { mode: 'show', direction: 'vertical' }, 1000);
                        $(title[idx]).effect(opts.effect, { mode: 'show', direction: 'vertical' }, 1000).fadeTo(10, 0.7);


                        break;
                    case 'clip':
                        $(img[idx]).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000);
                        $(title[idx]).effect(opts.effect, { mode: 'hide', direction: 'horizontal' }, 1000).fadeTo(10, 0.7);
                        //idx++;
                        //if (idx == img.length) {
                        //    idx = 0;
                        //}
                        $(img[idx]).effect(opts.effect, { mode: 'show', direction: 'horizontal' }, 1000);
                        $(title[idx]).effect(opts.effect, { mode: 'show', direction: 'horizontal' }, 1000).fadeTo(10, 0.7);
                        break;
                    case 'slide':
                        //if (idx === img.length) {
                        //    idx = 0;
                        //}
                        //idx++;
                        //if (idx == img.length) { idx = -1; return; }
                        //$('.SlideShowItem').animate({ left: '-' + $(img[idx]).width() + 'px' });

                        $(img).fadeOut(2000);
                        $(title).hide();

                        $(img).eq(idx).fadeIn(2000);
                        $(title).eq(idx).show();
                        
                       
                        //$(img[idx]).effect(opts.effect, { mode: 'hide', direction: 'right' }, 1000);
                        //$(title[idx]).effect(opts.effect, { mode: 'hide', direction: 'down' }, 1000).fadeTo(10, 0.7);
                        //idx++;
                        //if (idx == img.length) {
                        //    idx = 0;
                        //}
                        //$(img[idx]).effect(opts.effect, { mode: 'show', direction: 'right' }, 1000);
                        //$(title[idx]).effect(opts.effect, { mode: 'show', direction: 'up' }, 1000).fadeTo(10, 0.7);
                        break;
                }

            }, opts.effecttime);

        };
        divThumb.mouseleave(function () {
            if (idx_temp != -1)
            idx = idx_temp;
            img_thumb.removeClass('selected');
            img_thumb.eq(idx).addClass('selected');
            divThumb.scrollLeft(0);
            interval();
        });
        interval();
        
    }
})(jQuery);