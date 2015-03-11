// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function hidden_fields(name) {
  $('#control1').toggle();
}

$(document).ready(function() {
  $('#control2').click(function(event){
    hidden_fields();
  });
});

function show_id(ex) {
  alert($(ex).attr('id'));
};

function has_one_correct_answer(answer) {
  var answer_id = $(answer).attr('id');
  $('#word_answers_attributes_0_correct').attr('checked', false);
  $('#word_answers_attributes_1_correct').attr('checked', false);
  $('#word_answers_attributes_2_correct').attr('checked', false);
  $('#word_answers_attributes_3_correct').attr('checked', false);
  document.getElementById(answer_id).checked = true;
};

function show_category_form() {
  if ($('.category-form').is(':hidden')){
    $('.category-form').show();
    document.getElementById('display-form').innerHTML = "Hide category form";
  }
  else {
    $('.category-form').hide();
    document.getElementById('display-form').innerHTML = "Create new category";
  }
}