jQuery(document).ready(function($) {
  $('.employees form button.add_assignment')
    .on('click', function() {
      var $this  = $(this);
      var $tbody = $this.closest('table').find('tbody');
      var $tr    = $('tr:last-child', $tbody);
      var idx    = $tbody.find('tr').length;
      var html   = $tr[0].outerHTML.replace(/(employee_rates_attributes)(_|\]\[)\d+/g, "$1$2" + idx);
      var today = new Date();

      $tr.find(".until select")
        .removeClass('invisible')
        .filter(":eq(0)")
          .find("option[value='" + today.getDate() + "']")
            .attr('selected', 'selected')
          .end()
        .end()
          .filter(":eq(1)")
            .find("option[value='" + today.getMonth() + "']")
              .attr('selected', 'selected')
            .end()
          .end()
        .filter(":eq(2)")
          .find("option[value='" + today.getFullYear() + "']")
            .attr('selected', 'selected');

      $tbody.append(html);
      return false;
    });
});
