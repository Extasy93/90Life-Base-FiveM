let isShowed = false

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.action == "setMoney") {
            $("#Top-Right-Text-1").text(new Intl.NumberFormat('de-DE').format(event.data.money) + " $")
        } else if (event.data.action == "setBankMoney") {
            $("#Top-Right-Text-2").text(new Intl.NumberFormat('de-DE').format(event.data.money) + " $")
        } else if (event.data.action == "players") {
            $("#Top-Right-Players-Text").text(new Intl.NumberFormat('de-DE').format(event.data.players))
        } else if (event.data.action == "muted") {
            if (event.data.muted) {
                $("#Bot-Right-Icon-Mic-Mute").attr('src', 'img/Mic(M).png')
            } else {
                $("#Bot-Right-Icon-Mic-Mute").attr('src', 'img/Mic.png')
            }
        } else if (event.data.action == 'setVoiceLevel') {
            if (event.data.level == 1) {
                $("#Dot-Stroke-1").css("fill", "red");
                $("#Dot-Stroke-2").css("fill", "none");
                $("#Dot-Stroke-3").css("fill", "none");
            } else if (event.data.level == 2) {
                $("#Dot-Stroke-1").css("fill", "red");
                $("#Dot-Stroke-2").css("fill", "red");
                $("#Dot-Stroke-3").css("fill", "none");
            } else if (event.data.level == 3) {
                $("#Dot-Stroke-1").css("fill", "red");
                $("#Dot-Stroke-2").css("fill", "red");
                $("#Dot-Stroke-3").css("fill", "red");
            }
        } else if (event.data.action == "job") {
            $("#Top-Left-Text-1").text(event.data.job)
            $("#Top-Right-ID-Text").text(event.data.id + "  ")
            $("#Top-Right-Players-Text").text(event.data.players)
        } else if (event.data.action == "pause") {
            if (event.data.pause) {
                $(".Main").hide()
            } else {
                $(".Main").show()
            }
        } else if (event.data.action == "showAdvanced") {
            if (event.data.show) {
                $(".Main").hide()
            } else {
                $(".Main").show()
            }
        }
    });

    function startTime() {
        const today = new Date();
        let h = today.getHours();
        let m = today.getMinutes();
        let day = today.getDate()
        let month = today.getMonth() + 1
        let year = today.getFullYear()
        m = checkTime(m);
        $(".Top-Left-Clock").text(h + ":" + m)
        setTimeout(startTime, 1000);
    }
      
    function checkTime(i) {
        if (i < 10) {i = "0" + i};
        return i;
    }
    
    startTime()
});