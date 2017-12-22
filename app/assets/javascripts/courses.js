var autocomplete_for_students = {};
autocomplete_for_students.namespace = function () 
{

  var bestPictures = new Bloodhound(
  {
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: '/users.json',
    remote: {
      url: '/users.json?user=1&search=%QUERY',
          wildcard: '%QUERY'
        }
  });

  var students = [];
  var id_student="";
  var identification_student="";
  var name_student="";
  var last_name_student="";
  var image_url_student="";

  $('#estudiante').typeahead(null, 
  {
    name: 'best-pictures',
    display: 'identification',
    source: bestPictures,

    templates:
    {
      empty: [
        '<div class="empty-message">',
          'unable to find any Best Picture winners that match the current query',
        '</div>'
      ],

      suggestion: function(data)
      {
         return '<div>' + '<img class="img-search" src="' + data.image_url + '" />' + '<strong>' + data.name + ' ' + data.last_name + '</strong>' + '</div>';
      }
     
    }

  });

  $(document).on("typeahead:selected", "#estudiante", function(e, data)
  { 
    id_student=data.id;
    identification_student=data.identification;
    name_student=data.name;
    last_name_student=data.last_name;
    image_url_student=data.image_url;
  });


  function checkStudent(id) 
  {
    return id == id_student;
  }

  $(document).on("click", ".matriculate-student", function()
  { 
    if(id_student != "" && identification_student != "" && name_student != "" && last_name_student != "" && image_url_student != "")
    {
      if($("#estudiante").val() == identification_student && students.find(checkStudent) == undefined)
      {
        students.push(id_student);
        var student_card = '<div id="'+id_student+'" class="col-xs-6 col-md-2">'+
                              '<div class="panel panel-default">'+
                                  '<div class="panel-header-course bg-primary"></div>'+
                                  '<div class="panel-body-course text-center">'+
                                      '<img alt="Profile Picture" class="panel-img-course img-circle img-border-light" src="'+image_url_student+'">'+
                                      '<p class="identification">'+identification_student+'</p>'+
                                      '<h5 class="name">'+name_student+' '+last_name_student+'</h5>'+
                                      '<input type="hidden" name="students[]" id="students_" value="'+id_student+'">'+
                                  '</div>'+
                              '</div>'+
                            '</div>'; 

        $("#container-students").append(student_card);
        $("#estudiante").val("");
      }

      id_student="";
      identification_student="";
      name_student="";
      last_name_student="";
      image_url_student="";      
    }
  });
};


var autocomplete_for_teacher = {};
autocomplete_for_teacher.namespace = function () 
{

  var bestPictures = new Bloodhound(
  {
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: '/users.json',
    remote: {
      url: '/users.json?user=2&search=%QUERY',
          wildcard: '%QUERY'
        }
  });

  var id_teacher="";
  var identification_teacher="";
  var name_teacher="";
  var last_name_teacher="";
  var image_url_teacher="";

  $('#teacher').typeahead(null, 
  {
    name: 'best-pictures',
    display: 'identification',
    source: bestPictures,

    templates:
    {
      empty: [
        '<div class="empty-message">',
          'unable to find any Best Picture winners that match the current query',
        '</div>'
      ],

      suggestion: function(data)
      {
         return '<div>' + '<img class="img-search" src="' + data.image_url + '" />' + '<strong>' + data.name + ' ' + data.last_name + '</strong>' + '</div>';
      }
     
    }

  });

  $(document).on("typeahead:selected", "#teacher", function(e, data)
  { 
    id_teacher=data.id;
    identification_teacher=data.identification;
    name_teacher=data.name;
    last_name_teacher=data.last_name;
    image_url_teacher=data.image_url;
  });

  $(document).on("click", ".teacher-select", function()
  { 
    if(id_teacher != "" && identification_teacher != "" && name_teacher != "" && last_name_teacher != "" && image_url_teacher != "")
    {
      if($("#teacher").val() == identification_teacher)
      {
        var teacher_card = '<div id="'+id_teacher+'" class="col-xs-6 col-xs-offset-3 col-md-5 col-md-offset-3">'+
                              '<div class="panel panel-default">'+
                                  '<div class="panel-header-course bg-primary"></div>'+
                                  '<div class="panel-body-course text-center">'+
                                      '<img alt="Profile Picture" class="panel-img-course img-circle img-border-light" src="'+image_url_teacher+'">'+
                                      '<p class="identification">'+identification_teacher+'</p>'+
                                      '<h5 class="name">'+name_teacher+' '+last_name_teacher+'</h5>'+
                                  '</div>'+
                              '</div>'+
                            '</div>'; 

        $(".container-teacher").empty();
        $(".container-teacher").append(teacher_card);
        $("#course_user_id").val(id_teacher);
        $("#teacher").val("");
      }

      id_teacher="";
      identification_teacher="";
      name_teacher="";
      last_name_teacher="";
      image_url_teacher="";     
    }
  });  
};


$(document).on("click", "#edit-calification", function()
{ 
  $("#calification-label").hide();
  $("#calification-form").show();
});


$(document).on("ajax:success", "form#add-calification", function(en,data)
{ 
  $("#calification-label").text("Nota: " + data.calification+ " ");
  $("#calification-label").append(' <span  id="edit-calification" class="glyphicon glyphicon-pencil"></span>');

  $("#calification-label").show();
  $("#calification-form").hide();
});




