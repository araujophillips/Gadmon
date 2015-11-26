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
  size = $("#order_detail_product_id option").size()
  unless size is $("#order_detail_product_id").prop("size")
    $("#order_detail_product_id").prop "size", size
  else
    $("#order_detail_product_id").prop "size", 1

$("#order_detail_product_id").change ->
  customer = $(this).find("option:selected").text()
  $("#order_product_search").val customer

$ ->
  opts = $("#order_detail_product_id option").map(->
    [ [ @value, $(this).text() ] ]
  )
  $("#order_product_search").keyup ->
    rxp = new RegExp($("#order_product_search").val(), "i")
    optlist = $("#order_detail_product_id").empty()
    opts.each ->
      optlist.append $("<option/>").attr("value", this[0]).text(this[1])  if rxp.test(this[1])

$("#btn-add-product").click ->
  btn = $("#btn-add-product")
  btn.prop "type", "button"  if btn.prop("type", "submit")
  btn.prop "type", "submit"  if btn.prop("type", "button")

$ ->
$(document).on 'change', '#order_detail_product_id', (evt) ->
  $.ajax 'update_quantity',
    type: 'GET'
    url: '/order_details/update_quantity'
    dataType: 'script'
    data: {
      id: $("#order_detail_product_id option:selected").val()
    }
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("AJAX Error: #{textStatus}")
    success: (data, textStatus, jqXHR) ->
      console.log("Dynamic country select OK!")