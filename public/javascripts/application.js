// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
    $(".record tr:nth-child(odd)").addClass('alt');
    item_details = $(".step-item-detail .item");
    item_details.hide();
 $(".steps .step-model").click(function(event){
    //alert(this.val());
    $(".steps .step-model").removeClass("chooced");
    $(this).addClass("chooced");
    arr = $(this).attr("class").split(" ");
    t = arr[0];
    item_details.hide();
    $(".step-item-detail div[name^=" + t + "]").fadeIn('slow');
 });
});