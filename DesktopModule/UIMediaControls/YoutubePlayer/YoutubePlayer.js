$(document).ready(function () {
    var objs = $(document).find('[type="YoutubePlayer"]');
    objs.each(function () {
        var ifr = $(this);
        if (ifr.attr('width') == null || ifr.attr('height') == null) {
            var w = ifr.parent().width();
            var h = w / 1.777777777777777;
            ifr.attr('width', w);
            ifr.attr('height', h);
        }
    });
});