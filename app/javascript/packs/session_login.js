$(document).ready(() => {
    const form = $("form");
    form.submit(() => {
        $.ajax({
            method: "GET",
            url: "/sessions/create",
            data: form.serialize(),
            statusCode: {
                200: () => {
                    document.location.href = '/palindromes/input';
                },
                401: (data) => {
                    $("#status").text(data.responseText).css('color', 'red');
                }
            }
        });
        return false;
    })

    $("#register").click(() => {
        document.location.href = '/users/new';
    })
})