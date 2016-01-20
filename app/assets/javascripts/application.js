// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .


Date.prototype.getWeek = function() {
	  var onejan = new Date(this.getFullYear(),0,1);
	    return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()+1)/7)-1;
}

$(function () {
	function getDayHeader(index){
		return $('thead').children('tr').children('th').eq(index).text();
	}

	function getHoutEvent(td) {
		var strHour = td.parent('tr').children('th').text();
		return strHour.split(':')[0];
	}

	function getCurrentWeek() {
		var today = new Date();
		return today.getWeek();
	}

	function destroyEvent (evt) {
		var url = $(this).data('url');
		var icon = $(evt.target);
		$.ajax({
			url: url,
			type: 'DELETE',
			dataType: 'json'
		}).then(
			function(response) {
				var td = icon.parents('td');
				td.children('a').remove();
				td.children('b').remove();
				icon.remove();
				td.removeClass('info unavailable');

				var link = $('<a>').attr('role', 'buttom').html('Disponível');
				link.attr('data-day', getDayHeader(td.index()));
				link.attr('data-hour', getHoutEvent(td));
				link.attr('data-week', getCurrentWeek());
				link.on('click', appendEvent);
				td.append(link);
			}
		);
	}

	function appendEvent(evt) {
		var day = $(this).data('day');
		var hour = $(this).data('hour');
		var week = $(this).data('week');
		var link = $(evt.target);
		$.ajax({
			url: '/events',
			type: 'POST',
			dataType: 'json',
			data: {
				event: {
					day: day,
					hour: hour,
					week: week
				}
			}
		}).then(
			function(response){
				var _event = response.event;
				var userName = response.user_name;
				var data_url = '/events/' + _event.id;

				var icon = $('<span>').attr('class', 'glyphicon glyphicon-remove pull-right text-red');
				icon.attr('data-url', data_url);

				var boldText = $('<b>').text(userName);
				var td = link.parents('td');
				link.remove();

				link = $('<a>').attr("role", "buttom");
				link.append(icon);
				icon.on('click', destroyEvent);

				td.append(boldText);
				td.append(link);
				td.addClass('info unavailable');
			},
			function(response) {
				var notify_alert = $('<div>').addClass("alert alert-danger").attr("role", "alert");
				notify_alert.append("<b>Aviso: </b> Este horário foi reservado por um usuário em outra sessão, " +
						"atualize a página para sincronizar as informações.");
				$('.notifications').append(notify_alert);
			}
		);
	}

	$('.glyphicon-remove').on('click', destroyEvent);

	$('.available').on('click', appendEvent);
});
