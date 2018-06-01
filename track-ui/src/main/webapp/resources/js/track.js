var session = [];
session['timezone'] = undefined;

function adjustTimezones(timezone) {
	$(".timezone-aware").each(function() {
		session['timezone'] = timezone;
		
		var reportedTime = $(this).data("reported-time");	// ISO8601 UTC
		// alert("'" + $(this).data("reported-timezone") + "'");
		var reportedTimezone = $(this).data("reported-timezone") !== "" ? $(this).data("reported-timezone") : "Etc/UTC";
		
		newTimezone = (timezone !== undefined && timezone !== null) ? timezone : reportedTimezone;
		
		$(this).text(moment(reportedTime).tz(newTimezone).format("MMM D YYYY, h:mm:ss A (z)"));
	});
	
	// $(".timezone-aware").off('click');
	$(".timezone-aware").one("click", function() {
		adjustTimezones(timezone != null ? null : moment.tz.guess());
	});
}
	
$(document).ready(function() {
	
	// Use reported timezones by default
	adjustTimezones();
	
});