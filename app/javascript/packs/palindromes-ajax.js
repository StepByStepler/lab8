$(document).ready(() => {
    const form = $("form#input-form");
    form.submit(() => {
        $.ajax({
            method: "GET",
            url: "/palindromes/view.json",
            data: form.serialize()
        }).done((response) => {
            updateResult(response);
        })
        return false;
    });
})

function updateResult(response) {
    const container = $("div#result").empty();
    if (response.length <= 0) {
        $(document.createElement("p"))
            .text("Не найдено ни одного числа-палиндрома")
            .css("text-align", "center")
            .appendTo(container);
        return;
    }

    const table = $(document.createElement("div"))
        .addClass("container table")
        .attr("name", "res-table")
        .css("width", "30%")
        .appendTo(container);

    appendRow(table, ['Номер', 'Число', 'Квадрат числа']);
    for (let i = 0; i < response.length; i++) {
        appendRow(table, [i, response[i].num, response[i].sqr]);
    }
}

function appendRow(table, names) {
    const row = $(document.createElement("div"))
        .addClass("row")
        .appendTo(table);
    for (const name of names) {
        $(document.createElement("div"))
            .addClass("col")
            .text(name)
            .appendTo(row);
    }
}