
var showConfig = function (options) {

    var param = {
        width: 400, height: 300, src: '', title: 'Configuration', scrollbar: true, resizable: true, isDialog: true,
        fnOK: function () { }, fnClose: function () { }, zIndex: 500, hasButton: false, postBackClose:'', postBackType: 'parent', objArray:null
    };
    param = jQuery.extend(param, options);

    if (param.postBackClose != '') {
        if (param.postBackType == 'parent')
            window.parent[param.postBackClose] = function () { __doPostBack(param.postBackClose, ''); };
        else
            window.top[param.postBackClose] = function () { __doPostBack(param.postBackClose, ''); };
    }

    if (topWindow.zIndex == undefined)
        topWindow.zIndex = 5000;
    else
        topWindow.zIndex = topWindow.zIndex + 1;

    var eleGround;
    if (param.isDialog) {
        eleGround = $('<div type="bgconfigDialog" class="divMask"></div>').appendTo($(topWindow.document).find('body'));
        eleGround.css({ position: 'absolute', top: 0, left: 0, width: $(topWindow).innerWidth(), height: $(topWindow.document).innerHeight(),
            backgroundColor: '#c0c0c0', opacity: 0.4, zIndex: topWindow.zIndex, display: 'block'
        });
    }

    topWindow.zIndex = topWindow.zIndex + 1;

    var eleWindow = $('<div type="configDialog" class="windialog"></div>').css({ position: 'absolute', zIndex: topWindow.zIndex, top: 0, left: 0 }).appendTo($(topWindow.document).find('body')).show();
    var eleHead = $('<div class="dialogheader"><span class="title"></span><span class="button"></span></div>').appendTo(eleWindow);
    var eleContainer = $('<div class="container"></div>').appendTo(eleWindow);

    var eleContent = $('<iframe frameborder="0" ></iframe>').css({ width: param.width, height: param.height }).appendTo($(eleContainer));
    eleContent.attr('src', param.src);

    if(param.hasButton)
    {
        var eleButtonContainer = $('<div class="buttoncontainer"></div>').appendTo(eleWindow);
        var btnOK = $('<img src="/Images/confirmOK.gif"/>').appendTo(eleButtonContainer);
        btnOK.click(function () { param.fnOK(); eleWindow.remove() });
        var btnCancel = $('<img src="/Images/confirmCancel.gif" />').appendTo(eleButtonContainer);
    }

    if (param.resizable) {
        $(topWindow.document).find(eleContainer).resizable({ alsoResize: eleContent });
    }


    var wtop = ($(topWindow).innerHeight() - eleWindow.height()) / 2;
    if (wtop < 15) wtop = 15;
    wtop += $(topWindow).scrollTop();
    eleWindow.css({ top: wtop, left: ($(topWindow).innerWidth() - eleWindow.width()) / 2 });

    eleWindow.draggable({ handle: eleHead, containment: (eleGround==null?($(topWindow.document).find('body')): eleGround), drag: function () { eleGround.width($(topWindow.document).innerWidth()), eleGround.height($(topWindow.document).innerHeight()) } });
    eleWindow.find('.title').text(param.title);

    $(eleHead.find('.button')).click(function () {

        if (param.isDialog)
            topWindow.zIndex = topWindow.zIndex - 2;
        else
            topWindow.zIndex = topWindow.zIndex - 1;

        if (topWindow.zIndex <= 5000) topWindow.zIndex = undefined;
        if (eleGround != null || eleGround != undefined) eleGround.hide().remove();

        eleWindow.hide().remove(function () {
            param.fnClose()
        });

    });


}