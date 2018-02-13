function calculate_items(){
  var $overall = 0;
  $("tr.sum").each(function()
  {
    var $qnt = $(this).find("td").eq(1);
    var $price = $(this).find("td").eq(2);
    var sum = parseFloat($price.text()) * parseFloat($qnt.text());
    $(this).find("td").eq(3).text(sum.toFixed(2) + " грн");
    $overall+= sum;
  });
  $(".cart_total_sum").text(($overall).toFixed(2) + " грн");
};
