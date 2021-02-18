$("#Search").click(function () {
    alert("Search");
    $.ajax({
        url: '/Employee/Search',
        type: 'GET',
        dataType: 'json',
        cache: false,
        data: {
            'Fromdate': $("#Fromdate").val(),
            'Todate': $("#Todate").val()
        },
        dataSrc: function (json) {
            alert(json.lst)
        },
        error: function () {
            alert('Error occured');
        }
    });
});
