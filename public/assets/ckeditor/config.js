/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.editorConfig=function(e){
// e.filebrowserBrowseUrl="/ckeditor/attachment_files",
e.filebrowserFlashBrowseUrl="/ckeditor/attachment_files",
e.filebrowserFlashUploadUrl="/ckeditor/attachment_files",
// e.filebrowserImageBrowseLinkUrl="/ckeditor/pictures",
// e.filebrowserImageBrowseUrl="/ckeditor/pictures",
e.filebrowserImageUploadUrl="/ckeditor/pictures",
// e.filebrowserUploadUrl="/ckeditor/attachment_files",
e.filebrowserParams=function(){for(var e,r,t,o=document.getElementsByTagName("meta"), a=new Object,i=0;i<o.length;i++)
switch(t=o[i],
t.name){case"csrf-token":e=t.content;break;case"csrf-param":r=t.content;break;default:continue}return void 0!==r&&void 0!==e&&(a[r]=e),
a},
e.addQueryString=function(e,
r){var t=[];if(!r)return e;for(var o in r)t.push(o+"="+encodeURIComponent(r[o]));return e+(-1!=e.indexOf("?")?"&":"?")+t.join("&")},
CKEDITOR.on("dialogDefinition",
function(r){var t,
o,
a=r.data.name,
i=r.data.definition;CKEDITOR.tools.indexOf(["link",
"image",
"attachment",
"flash"],
a)>-1&&(t=i.getContents("Upload")||i.getContents("upload"),
o=null==t?null:t.get("upload"),
o&&o.filebrowser&&void 0===o.filebrowser.params&&(o.filebrowser.params=e.filebrowserParams(),
o.action=e.addQueryString(o.action,
o.filebrowser.params)))})

	   e.toolbar = 'Easy';

	    e.toolbar_Easy =
	        [
            	['Source'],
            	['Undo','Redo'],
				[ 'Format', 'Font', 'FontSize' ],
	            ['Bold','Italic','Strike','Underline'],
	            ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	            ['BulletedList','NumberedList','Blockquote','Outdent','Indent','ShowBlocks'],
	            ['TextColor', 'BGColor'],
	            '/',
	            ['Table,HorizontalRule'],
				['Scayt'],
	            ['Link','Unlink'],
	            ['Image', 'Attachment'],
				['Maximize']
	        ];

};

