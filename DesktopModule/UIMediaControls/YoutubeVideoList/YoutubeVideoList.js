(function ($) {
    $.fn.YoutubeVideoList = function (opts) {
        var main = $(this);
        var items = main.find('.VideoList').children();
        items.click(function () {
            var item = $(this);
            if (main.attr('showtype') == 'VideoShow') {
                if ($(document).find('[type="YoutubePlayer"]').length > 0) {
                    var videoScreen = $($(document).find('[type="YoutubePlayer"]').get(0));
                    if (videoScreen != null) {
                        var p = videoScreen.parents('.YoutubePlayer');
                        videoScreen.attr('src', item.attr('src'));
                        $(document).scrollTop(videoScreen.offset().top);
                        var t, d;
                        t= p.find('.Title'); if(t!=null) t.html(item.attr('title'));
                        d= p.find('.Description'); if(d!=null) d.html(item.attr('description'));
                    }
                }
                else alert('Không tìm thấy màn hình hiển thị video trên trang');
            }
            else if (main.attr('showtype') == 'Popup') {
                var divMask = $('<div class="YoutubeVideoMask" style="background: #000000; opacity: 0.8"></div>').appendTo($('body'));
                divMask.css({ position: 'fixed', zIndex: 10000, top: '0px', width: '100%', height: screen.height });
                var divPanel = $('<div class="VideoPanel" style="width:640px; height:auto; padding: 8px;"><span class="closeButton"></span></div>').appendTo($('body'));
                var ifrm = $('<iframe frameborder="0" class="YoutubePlayer" width="100%" height="360" src="' + item.attr('src') + '" allowfullscreen ></iframe>').appendTo(divPanel);
                var title = $('<div class="Title">' + item.attr('title') + '</div>').appendTo(divPanel);
                var description = $('<div class="Description">' + item.attr('description') + '</div>').appendTo(divPanel);
                var btnClose = divPanel.find('.closeButton').click(function () {
                    divPanel.remove();
                    divMask.remove();
                });
                divMask.click(function () {
                    divPanel.remove();
                    divMask.remove();
                });

                divPanel.css({ backgroundColor: '#ffffff', position: 'fixed', zIndex: 10001, left: (divMask.width() - divPanel.outerWidth()) / 2, top: (divMask.height() - divPanel.height()) / 2 });
                btnClose.css({ position: 'absolute', top: '-16px', right: '-16px', zIndex: 10002, backgroundColor: 'red', width: '32px', height: '32px' });
            }
            else if(main.attr('showtype')=="Link") {
                window.document.location.href = main.attr('href') + '&vcatid=' + item.attr('catid') + '&vid=' + item.attr('vid') + '&vname=' + item.attr('vname');
            }
        });
    }
})(jQuery);