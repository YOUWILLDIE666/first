let pids = [
    "10769378101"
]

pids.forEach(function(pid) {
    $.ajax({
        url: "https://economy.roblox.com/v1/purchases/products/" + pid,
        method: "POST",
        headers: {
            "X-CSRF-TOKEN": Roblox.XsrfToken.getToken()
        },
        dataType: "json",
        data: {
            expectedCurrency: 0,
            expectedPrice: 1,
            expectedSellerId: 1
        },
        success: function(data) {
            console.log("Response data:", data);
            if (data.purchased) {
                console.log("Bought ", data.assetName);
            } else {
                console.log("Purchase not successful for product " + pid);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error purchasing product " + pid + ": " + textStatus, errorThrown);
            console.error("Response data:", jqXHR.responseJSON);
        }
    })
})
