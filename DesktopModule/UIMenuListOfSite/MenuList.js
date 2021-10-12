(function ($) {
    $.fn.MenuList = function () {
        var self = $(this);
        //var defaults = { "Col": 2 };
        //var opts = jQuery.extend(defaults, options);

        var initialContainer = $(self).find('.columns');
        $.each(initialContainer, function () {
            var col = $(this).data('columns');
            if (col > 1)
            {
                var divwrap = $('<div class="wrap"></div>');
                var id = $(this).data('id');
                var columnItems = $(this).find('li'),
                columns = null,
                column = 0; // account for initial column
                //set up
                columnItems.detach();
                
                while (column++ < col) {
                    var item = $(this).clone().attr('data-id', id);
                    //item.insertBefore($(this));
                    divwrap.append(item);
                }
                //columns = $("[data-id='" + id + "']");
                columns = $(divwrap).find("[data-id='" + id + "']");
                //////end setup
                column = 0;
                var tongcot = columns.length;
                var tintrang = Math.ceil(columnItems.length / tongcot);
                var dem = 0;
                columnItems.each(function (idx, el) {
                    if (dem === tintrang) { dem = 0; column += (tongcot>column?1:0); }
                    $(columns.get(column)).append(el);
                    dem += 1;
                });
                $(divwrap).insertBefore($(this));
                $('.wrap').nextAll('ul').remove();
            }
        });
    }
})(jQuery);