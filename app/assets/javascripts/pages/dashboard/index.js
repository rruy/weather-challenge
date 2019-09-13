var ready;
ready = function() {
    var engine = new Bloodhound({
        datumTokenizer: function(d) {
            console.log(d);
            return Bloodhound.tokenizers.whitespace(d.name);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '/cities/search?q=%QUERY',
            wildcard: '%QUERY'
        }
    });

    var promise = engine.initialize();

    promise
        .done(function() { console.log('success!'); })
        .fail(function() { console.log('err!'); });

    function submitFindAll(ev, suggestion) {
        $('#search_city').submit();
    }

    $('#city').typeahead(null, {
            name: 'engine',
            displayKey: 'name',
            source: engine.ttAdapter(),
            templates: {
                empty: [
                    '<div class="list-group search-results-dropdown"><div class="list-group-item">Não encontrado</div></div>'
                ],
                header: [
                    '<div class="list-group search-results-dropdown">'
                ],
                suggestion: function(data) {
                    return '<div class=\"ProfileCard u-cf Typeahead-suggestion Typeahead-selectable\">' +
                        '<div class=\"ProfileCard-details\">' +
                        '<div class=\"ProfileCard-realName\">' + data.name + '</div>' +
                        '<div class=\"ProfileCard-screenName\"></div>' +
                        '</div>' +
                        '</div>'
                }
            }
        })
        .on('typeahead:select', submitFindAll)
        .on('typeahead:autocomplete', submitFindAll)
        .on('keydown', function(event) {
            if (event.which === 13) {
                currentQuery = $('.tt-input').val();
                if (currentQuery === '') {
                    // Trigger the default (first) suggestion
                    $('.tt-suggestion:first-child').trigger('click');
                } else {
                    // The suggestion they chose with arrow keys
                    submitFindAll
                }
            }
        });
}

$(document).ready(ready);
$(document).on('page:load', ready);