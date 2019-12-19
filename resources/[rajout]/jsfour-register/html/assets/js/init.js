$(document).ready(function(){
  $('select').formSelect();

  // Date of birth picker
  $('#dateofbirth').val('01/01/1990');
  $('.datepicker').datepicker({
    defaultDate : new Date(1, 0, 1990),
    setDefaultDate : true,
    yearRange: 100,
    format : 'dd/mm/yyyy',
    i18n : {
      cancel: 'Annuler',
      done: 'Ok',
      clear: 'Reset',
      months: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre" ],
      monthshort: ['Jan', 'Février', 'Mars', 'Avril', 'Mai', 'Jun', 'Jul', 'Août', 'Sep', 'Oct', 'Nov', 'Dec' ],
      weekdays: ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi','Dimanche'],
      weekdaysShort: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
      weekdaysLetter:['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
    },
  });

  // LUA event listener
  window.addEventListener('message', function(event) {
    if (event.data.action == 'open') {
      $('#wrapper').show();
    } else if (event.data.action == 'close') {
      $('#wrapper').hide();
    }
  });

  // Register button
  $('#register').click(function() {
    if ($('#lastname').val() != '' && $('#firstname').val() != '' && $('#dateofbirth').val() != '' && $('#sex select').val() != null && $('#height').val() != '') {
      if ($('#height').val().length > 1 && $('#dateofbirth').val().length == 10) {
        var dob = $('#dateofbirth').val();

        $.post('http://jsfour-register/register', JSON.stringify({
          firstname: $("#firstname").val(),
          lastname: $("#lastname").val(),
          dateofbirth: $("#dateofbirth").val(),
          sex: $("#sex select").val(),
          height: $("#height").val()
        }));
      }
    }
  });

  // Disable space on the input
  $("form").on({
	  keydown: function(e) {
	    if (e.which === 32)
	      return false;
	  },
	});

  // Disable form submit
  $("form").submit(function() {
		return false;
	});
});
