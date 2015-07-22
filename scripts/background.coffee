getCookie = (name) ->
  value = "; " + document.cookie;
  parts = value.split("; " + name + "=");
  if (parts.length == 2)
    return parts.pop().split(";").shift();

checkin = $('#map-search-checkin').val()
checkout = $('#map-search-checkout').val()
guestsno = $('#guest-select').val()
csrf_token = getCookie('_csrf_token')

updateListings = ->
  $('.listing').each ->
    url = "/rooms/ajax_refresh_subtotal?authenticity_token=#{csrf_token} \
      &checkin=#{checkin}&checkout=#{checkout}&number_of_guests=#{guestsno} \
      &hosting_id=#{$(@).data('id')}"

    $.getJSON url, (data) =>
      price_per_person = (data.total_price_with_fees.replace('$', '') /
        data.nights / guestsno).toFixed(2);
      $(@).find('.price-amount').append(" / #{price_per_person}")

updateListings()
