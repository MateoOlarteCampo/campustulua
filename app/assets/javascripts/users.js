$(document).on("ajax:success", "form#activate_account", function(en,data)
{	
	var element = "#"+data.id;
	$(element).remove();
});


$(document).on("click", "#edit-name-btn", function()
{	
	$("#user-name").hide();
	$("#edit-name-div").show();
});


$(document).on("click", "#cancel-edit-name", function()
{	
	$("#edit-name-div").hide();
	$("#user-name").show();
});


$(document).on("click", "#edit-email-btn", function()
{	
	$("#user-email").hide();
	$("#edit-email-div").show();
});


$(document).on("click", "#cancel-edit-email", function()
{	
	$("#edit-email-div").hide();
	$("#user-email").show();
});

$(document).on("click", ".profile-picture-container", function()
{	
	$('#imgupload').trigger('click'); 
	$("#edit-picture-div").show();
});

$(document).on("click", "#cancel-edit-picture", function()
{	
	$("#edit-picture-div").hide();
	$("#profile-picture-container").show();
	$("#image-holder").empty();
	$("#error-picture").hide();
});



var change_profile_picture = {};
change_profile_picture.namespace = function () 
{
  $("#imgupload").on('change', function() 
  {
    $("#profile-picture-container").hide();
    //Get count of selected files
    var countFiles = $(this)[0].files.length;
    var imgPath = $(this)[0].value;
    var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
    var image_holder = $("#image-holder");
    var caption = $("#text-edit-picture").clone();
    image_holder.empty();
    if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") 
    {
      $("#error-picture").hide();
      $("#btn-edit-picture").prop( "disabled", false );
      if (typeof(FileReader) != "undefined") {
        //loop for each file selected for uploaded.
        for (var i = 0; i < countFiles; i++) 
        {
          var reader = new FileReader();
          reader.onload = function(e) {
            caption.appendTo(image_holder);
            $("<img />", {
              "src": e.target.result,
              "class": "img-border-light",
            }).appendTo(image_holder);
          }
          image_holder.show();
          reader.readAsDataURL($(this)[0].files[i]);
        }
      } 
      else 
      {
        alert("This browser does not support FileReader.");
      }
    }
    else
    {
      $("#error-picture").show();
      $("#profile-picture-container").show();
      $("#image-holder").empty();
      $("#btn-edit-picture").prop( "disabled", true );
    } 
  });
};



$(document).ready(function()
{

$("#avatar-2").fileinput({
  overwriteInitial: true,
    maxFileSize: 1500,
    showClose: false,
    showCaption: false,
    browseLabel: '',
    removeLabel: '',
    browseIcon: '<i class="glyphicon glyphicon-folder-open"></i>',
    removeIcon: '<i class="glyphicon glyphicon-remove"></i>',
    removeTitle: 'Cancel or reset changes',
    defaultPreviewContent: '<img src="/assets/default/profile_picture_default.png" alt="Your Avatar" style="width:160px">',
    layoutTemplates: {main2: '{preview} '  + ' {remove} {browse}'},
    allowedFileExtensions: ["jpg", "png", "gif"]
   
});
	
});


