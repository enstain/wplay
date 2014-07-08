// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
	$("#quest_target_all").click(function() {
		$("#quest_department_ids").val('');
		$("#quest_worker_ids").val('');
		$("#quest_department_ids").hide();
		$("#quest_worker_ids").hide();
	});

	$("#quest_target_department").click(function() {
		$("#quest_department_ids").show();
		$("#quest_department_ids").val('');
		$("#quest_worker_ids").val('');
		$("#quest_worker_ids").hide();
	});

	$("#quest_target_person").click(function() {
		$("#quest_worker_ids").show();
		$("#quest_department_ids").hide();
		$("#quest_department_ids").val('');
		$("#quest_worker_ids").val('');
	});


    $('[data-behaviour~=datepicker]').datepicker({
    	format: "dd.mm.yyyy",
    	language: "ru"
    });

    $('[data-behaviour~=datetimepicker]').datetimepicker({
    	language: "ru",
    	icons: {
                    time: "fa fa-clock-o",
                    date: "fa fa-calendar",
                    up: "fa fa-arrow-up",
                    down: "fa fa-arrow-down"
                }
    });
});
