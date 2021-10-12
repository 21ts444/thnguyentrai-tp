/// <reference path="../../Scripts/jquery-1.7.1.min.js" />

(function ($) {
    $.fn.SliderArticleImage = function (options) {
        var params = { effectivetime: 5000, effectivetype: 'show', height: 0 }; ;
        params = jQuery.extend(params, options);
        var self = $(this);



        self.each(function () {

            main = $(this);
            var pw, ph;


            var itemPanel = main.children('.ItemPanel');
            //alert(itemPanel.innerWidth(true)>0);
            if (params.height != null && params.height != 0) {
                itemPanel.height(params.height);
            }
            var items = itemPanel.children().hide();
            var selecteditem, idx, inteval;
            var loop = function () {
                inteval = setInterval(function () {
                    idx++;
                    idx = (idx < items.length) ? idx : 0;
                    runEffect();
                }, params.effectivetime);
            };

            items.mouseover(function () {
                clearInterval(inteval);
            }).mouseout(function () { loop(); });

            var runEffect = function () {
                var prepareitem = $(items[idx]);
                if (params.effectivetype == 'show') {
                    prepareitem.css({ zIndex: 1 }).show()
                    selecteditem.css({ zIndex: 2 }).hide('drop', { duration: 1000, direction: 'left' });

                    prepareitem.show('drop', { duration: 1000, direction: 'right' });
                    selecteditem = prepareitem;
                }
                else if (params.effectivetype == 'fade') {
                    selecteditem.toggle('fade', 300, function () { prepareitem.toggle('fade', 300); });

                    selecteditem = prepareitem;
                }

            };


            if (items.length > 0) {
                items.find('.Image').css({ width: itemPanel.innerWidth(), height: itemPanel.innerHeight() });
                if (items.length > 1) {
                    var preButton = $('<span class="PreButton"></span>').appendTo(main).click(
                        function () {
                            if (idx > 0) {
                                idx--;
                                runEffect();
                            }
                        }
                    );
                    var nextButton = $('<span class="NextButton"></span>').appendTo(main).click(
                    function () {
                        if (idx < (items.length - 1)) {
                            idx++;
                            runEffect();
                        }
                    }

                    );
                };

                idx = 0;
                selecteditem = $(items[idx]).show();
                loop();


            }

        });

    }
})(jQuery);