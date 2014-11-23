/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery.validationEngine-en
//= require jquery.validationEngine
//= require bootstrap-datepicker
//= require rwd-table.min
//= require jquery.blockUI
// require_tree .

$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

$(document).on('ready page:load', function() {
    $("#formID").validationEngine();
    $('.onlyinteger').bind('keypress', function(e) {
        return !(e.which !== 8 && e.which !== 0 &&
                (e.which < 48 || e.which > 57) && e.which !== 46);
    });
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
    var ex_d = $('.expiry_date').datepicker({
        format: 'dd-mm-yyyy',
        onRender: function(date) {
            return date.valueOf() < now.valueOf() ? 'disabled' : '';
        }
    }).on('changeDate', function(ev) {
        ex_d.hide();
    }).click(function() {
        ex_d.show();
    }).data('datepicker');

    var dob = $('.dob').datepicker({
        format: 'dd-mm-yyyy',
        onRender: function(date) {
            return date.valueOf() < now.valueOf() ? '' : 'disabled';
        }
    }).on('changeDate', function(ev) {
        dob.hide();
    }).click(function() {
        dob.show();
    }).data('datepicker');
});

function responsive_table(pagination) {
    $('.table-responsive').responsiveTable();
    if (pagination === true) {
        $('.pagination a').attr('data-remote', 'true');
        $('.pagination a').on('click', function() {
            $.blockUI({message: '<h4><img src="/assets/loader.gif" alt="" /> Please wait, it will take few minutes...</h4>'});
        });
    }
}

