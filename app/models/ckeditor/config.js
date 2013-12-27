// Rails CSRF token

  config.filebrowserParams = function(){

    var csrf_token = $('meta[name=csrf-token]').attr('content'),

        csrf_param = $('meta[name=csrf-param]').attr('content'),

        params = new Object();



    if (csrf_param !== undefined && csrf_token !== undefined) {

      params[csrf_param] = csrf_token;

    }



    return params;

  };