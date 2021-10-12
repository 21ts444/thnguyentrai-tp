    $(document).ready(function () {
        var modal = document.getElementById("steering-modal");

        $('.btnPreview').click(function () {
            $('#steering-modal').show();
        });

        $('.close').click(function () {
            $('#steering-modal').hide();
        });

        window.onclick = function (event) {
            if (event.target == modal) {
                $('#steering-modal').hide();
            }
        }
    });

    function showFile(elem) {
        let filePath = $(elem).data('file-path');
        var myRequest = new Request(filePath);

        $('.item-file').each(function () {
            $(this).removeClass('active');
        });

        $('#choose-file').hide();
        $(elem).addClass('active');

        fetch(myRequest).then(function (response) {
            if (filePath.toLowerCase().indexOf("docx") < 0
                || filePath.toLowerCase().indexOf("doc") < 0) {
                if (response.status === 200) {
                    $('#frame-file').attr('src', filePath);
                    $('#no-preview-file').hide();
                    $('#no-exist-file').hide();
                    $('#frame-file').show();
                }
                else {
                    // 404, etc...
                    $('#no-preview-file').hide();
                    $('#frame-file').hide();
                    $('#no-exist-file').show();
                }
            }
            else {
                $('#download-file').attr('href', filePath);
                $('#no-preview-file').show();
                $('#no-exist-file').hide();
                $('#frame-file').hide();
            }
        }).catch(function (error) {
            $('#no-preview-file').hide();
            $('#frame-file').hide();
            $('#no-exist-file').show();
        });
    }
