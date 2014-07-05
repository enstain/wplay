$(document).ready(function(){
    $('[data-provide~=datepicker]').datepicker({
     "setDate": new Date(),
     isRTL: false,
     format: 'dd.mm.yyyy',
     autoclose:true,
     language: 'ru'

  });
})