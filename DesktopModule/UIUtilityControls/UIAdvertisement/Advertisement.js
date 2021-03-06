(function ($) {
    $.fn.showAdvertisement = function (options) {
        var params = { displayType: 'Center' };
        params = jQuery.extend(params, options);
        var self = $(this);
        var titleBar = self.find('.AdvertTitleBar');
    
        switch (params.displayType)
        {
            case 'Center':
                var mask = $('<div class="AdvertisementBG"></div>').appendTo($('body')).css({ width: $(document).width(), height: $(document).height() });
                $(this).css({ left: ($(window).width() - $(this).width()) / 2, top: ($(window).height() - $(this).height()) / 2 });
                var btnClose = titleBar.find('.Collapse');
                btnClose.click(function () { mask.remove(); self.remove(); });
                break;
            case 'BottomRight':
                var btnCollapse = titleBar.find('.Collapse');
                var btnExpand = titleBar.find('.Expand').hide();
                var divContent = self.find('.AdvertContent');
                btnCollapse.click(function () {
                    divContent.hide(500);
                    btnExpand.show();
                    btnCollapse.hide();
                });
                btnExpand.click(function () {
                    divContent.show(500);
                    btnCollapse.show();
                    btnExpand.hide();
                });
                  
                break;
            default:
                break;
        }
    }
})(jQuery);