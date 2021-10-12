function ShowFull(img, showClass) {
    $(img).parent().parent().children(showClass).first().show();
    $(img).parent().hide();
}