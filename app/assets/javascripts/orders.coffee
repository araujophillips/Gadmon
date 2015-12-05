# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Customers search
$("#order_customer_search").click ->
  size = $("#order_customer_id option").size()
  unless size is $("#order_customer_id").prop("size")
    $("#order_customer_id").prop "size", size
  else
    $("#order_customer_id").prop "size", 1

$("#order_customer_id").change ->
  customer = $(this).find("option:selected").text()
  $("#order_customer_search").val customer

$ ->
  opts = $("#order_customer_id option").map(->
    [ [ @value, $(this).text() ] ]
  )
  $("#order_customer_search").keyup ->
    rxp = new RegExp($("#order_customer_search").val(), "i")
    optlist = $("#order_customer_id").empty()
    opts.each ->
      optlist.append $("<option/>").attr("value", this[0]).text(this[1])  if rxp.test(this[1])

# Products search
$("#order_product_search").click ->
  size = $("#product_list option").size()
  unless size is $("#product_list").prop("size")
    $("#product_list").prop "size", size
  else
    $("#product_list").prop "size", 1

$("#product_list").change ->
  customer = $(this).find("option:selected").text()
  $("#order_product_search").val customer

$ ->
  opts = $("#product_list option").map(->
    [ [ @value, $(this).text() ] ]
  )
  $("#order_product_search").keyup ->
    rxp = new RegExp($("#order_product_search").val(), "i")
    optlist = $("#product_list").empty()
    opts.each ->
      optlist.append $("<option/>").attr("value", this[0]).text(this[1])  if rxp.test(this[1])

$("#btn-add-product").click ->
  btn = $("#btn-add-product")
  btn.prop "type", "button"  if btn.prop("type", "submit")
  btn.prop "type", "submit"  if btn.prop("type", "button")

# Product quantity update
$ ->
$(document).on 'change', '#product_list', (evt,data) ->
  $("#product_details_box").empty();
  $.ajax 'update_quantity',
    type: 'GET'
    url: '/orders/update_quantity'
    dataType: 'script'
    data: {
      id: $("#product_list option:selected").val()
    }
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("AJAX Error: #{textStatus}")
    success: (data, textStatus, jqXHR) ->
      $("#product_details_box").append('
          <table class="table table-hover">
            <thead>
              <tr>
                <th>#</th>
                <th>Serial</th>
                <th class="text-center">Fecha registro</th>
                <th class="text-center">Comentario</th>
                <th class="text-center"></th>
                <th></th>
              </tr>
            </thead>
            <tbody id="details_box">
            </tbody>
          </table>
        ')
      product = JSON.parse data
      if product.length == 0
        $("#product_details_box table").hide()
      else
        for pkey, pval of product
          price_id = pval.current_price.id
          price_val = pval.current_price.price
          for key, val of pval.product_details
            comment = if !!val.comment then val.comment else "-"
            btn = if $("#row_"+val.id).is(':visible') then "hidden" else "visible"
            $("#details_box").append('
                <tr>
                  <td>'+val.id+'</td>
                  <td>'+val.serial+'</td>
                  <td class="text-center">'+val.created_at+'</td>
                  <td class="text-center">'+comment+'</td>
                  <td class="text-center">
                    <button type="button" onclick="add_row(\''+val.product_id+'\',\''+pval.name+'\',\''+price_id+'\',\''+price_val+'\',\''+val.id+'\',\''+val.serial+'\',\''+comment+'\')" id="btn_add_'+val.id+'" class="btn btn-success btn-xs '+btn+'">
                      <i class="fa fa-plus"></i> Agregar</span>
                    </button></td>
                </tr>
              ')

root = exports ? this

root.add_row = (product_id,product_name,price_id,price_val,detail_id,serial,comment) ->
  $("#btn_add_"+detail_id).hide()
  $("#order_table").show()
  if $("#empty_orden_alert").is(':visible')
    $("#empty_orden_alert").hide()
    $("#process_order").show()
  $("#order_table #order_detail").append('
      <tr id="row_'+detail_id+'">
        <td>
          <span>'+product_id+'<span>
          <input class="hidden" value="'+product_id+'" name="order[order_detail][][product_id]">
        </td>
        <td>
          <span>'+product_name+'</span>
        </td>
        <td>
          <span>'+serial+'</span>
          <input class="hidden" value="'+detail_id+'" name="order[order_detail][][product_detail_id]">
        </td>
        <td>
          Bs. <a id="price_'+detail_id+'">'+price_val+'</a>
          <input class="hidden" value="'+price_id+'" name="order[order_detail][][price_id]">
        </td>
        <td class="text-center">
          <a id="comission_'+detail_id+'" maxlenght="2" contenteditable onkeypress="return just_numbers(event)" onkeyup="calculate()">0</a>%
        </td>
        <td class="text-center">
          <span>'+comment+'</span>
        </td>
        <td class="text-center"></td>
        <td>
          <button type="button" onclick="remove_row(\''+product_id+'\',\''+detail_id+'\',\''+serial+'\',\''+comment+'\')" id="btn_remove_'+detail_id+'" class="btn btn-danger btn-xs">
            <i class="fa fa-times"></i> Remover</span>
          </button></td>
        </td>
      </tr>
    ')
  calculate()

root.remove_row = (product,id,serial,comment) ->
  $("#btn_add_"+id).show()
  $("#btn_add_"+id).removeClass('hidden')
  $("#order_detail #row_"+id).remove()
  if $("tbody#order_detail").children().length == 0
    $("#order_table").hide()
    $("#process_order").hide()
    $("#empty_orden_alert").show()
  calculate()

root.just_numbers = (e) ->
  keynum = if window.event then window.event.keyCode else e.which
  if keynum == 8 or keynum == 46
    return true
  /\d/.test String.fromCharCode(keynum)

root.calculate = () ->
  subtotal = 0
  comission = 0
  $("#order_detail tr td a[id^=price_]").each ->
    # Sum subtotal
    i = parseFloat($(this).text());
    subtotal += i
    # Get row ID
    id = this.id
    id = id.split('_');
    id = id[1]
    p = parseFloat($("#comission_"+id).text())/100
    comission += (i*p)
  total = subtotal - comission
  # To display
  $("#subtotal").text(subtotal)
  $("#comission").text(comission)
  $("#total").text(total)
  # To send as params
  $("#order_subtotal").val(subtotal)
  $("#order_comission").val(comission)
  $("#order_total").val(total)