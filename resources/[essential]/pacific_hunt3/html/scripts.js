// Credit to Kanersps @ EssentialMode and Eraknelo @FiveM
function addGaps(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
  }
  return x1 + x2;
}
function addCommas(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + ',<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
  }
  return x1 + x2;
}

$(document).ready(function(){
  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var cursor = $('#cursor');
  var cursorX = documentWidth / 2;
  var cursorY = documentHeight / 2;

  function UpdateCursorPos() {
      $('#cursor').css('left', cursorX);
      $('#cursor').css('top', cursorY);
  }

  function triggerClick(x, y) {
      var element = $(document.elementFromPoint(x, y));
      element.focus().click();
      return true;
  }

  // Partial Functions
  function closeCodeContainer() {
    $(".code-container").css("display", "none");
  }
  function openCodeContainer() {
    $(".code-container").css("display", "block");
  }
  function closeClueContainer() {
    $(".clue-container").css("display", "none");
  }
  function openClueContainer() {
    $(".clue-container").css("display", "block");
  }
  function openContainer() {
    $(".bank-container").css("display", "block");
    $("#cursor").css("display", "block");
  }
  function closeContainer() {
    $(".bank-container").css("display", "none");
    $("#cursor").css("display", "none");
  }
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    if(item.codeOpen == true) {
      openContainer();
      closeClueContainer();
      $("#textCode").html(item.textDisplay);
      openCodeContainer();
    }
    if(item.codeOpen == false && item.clueOpen == false) {
      closeContainer();
      closeClueContainer();
      closeCodeContainer();
    }
    if(item.clueOpen == true) {
      openContainer();
      closeCodeContainer();
      $("#textClue").html(item.textDisplay);
      openClueContainer();
    }
    if (item.type == "click") {
        triggerClick(cursorX - 1, cursorY - 1);
    }
  });
  $(document).mousemove(function(event) {
    cursorX = event.pageX;
    cursorY = event.pageY;
    UpdateCursorPos();
  });
  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://pacific_hunt3/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function(){
      $.post('http://pacific_hunt3/close', JSON.stringify({}));
  });
  // Handle Form Submits
  $("#code-form").submit(function(e) {
      e.preventDefault();
      $.post('http://pacific_hunt3/codeSubmit', JSON.stringify({
          amount: $("#code-form #amount").val()
      }));
      $("#code-form #amount").prop('disabled', true)
      $("#code-form #submit").css('display', 'none')
      setTimeout(function(){
        $("#code-form #amount").prop('disabled', false)
        $("#code-form #submit").css('display', 'block')
      }, 2000)

      $("#code-form #amount").val('')
  });
});
