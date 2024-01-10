

$(function() {
    window.onload = e => {
      $('#browser-wrapper').hide();
      
      window.addEventListener("message", event => {
        var item = event.data;

        if (item !== undefined && item.type === "ui") {
            if (item.display === true) {
                $("#browser-wrapper").fadeIn();
                document.querySelector(".ibrowser").setAttribute("src", item.url);
                setBrowserUrl(item.url)
            } else {
                $("#browser-wrapper").fadeOut();
            }
        }

      });
    };

    $(document).keyup(function(e) {
        if (e.keyCode == 27 || e.keyCode == 120 || e.keyCode == 8 ) {
          // closeMenu();
        }
      });

    $('.closeButton').click(function() { 
        closeMenu();
    });

    $('.ibrowser').on('load', function() {
      window.iFrameChanges = window.iFrameChanges + 1
      setBrowserUrl(document.getElementById("ibrowser").contentWindow.location.href)
    });

    window.iFrameChanges = -1;
    $('.backButton').click(function() {
      if (window.iFrameChanges > 0) 
      {
        window.iFrameChanges = window.iFrameChanges - 2 // -2 because just after the back, a new load is called which add 1
        document.getElementById("ibrowser").contentWindow.history.back(); 
      }
    });

    $('.forwardButton').click(function() {
      document.getElementById("ibrowser").contentWindow.history.forward();
    });
    
    function closeMenu() {
        $.post("http://eWebsite/close", JSON.stringify({}));
        $("#browser-wrapper").fadeOut();
    }

    function setBrowserUrl(url) {
      document.querySelector(".website-url").setAttribute("value", url);
  }



});
  