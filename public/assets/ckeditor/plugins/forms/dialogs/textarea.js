/*
 Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
CKEDITOR.dialog.add("textarea",function(t){return{title:t.lang.forms.textarea.title,minWidth:350,minHeight:220,onShow:function(){delete this.textarea;var t=this.getParentEditor().getSelection().getSelectedElement();t&&"textarea"==t.getName()&&(this.textarea=t,this.setupContent(t))},onOk:function(){var t,e=this.textarea,a=!e;a&&(t=this.getParentEditor(),e=t.document.createElement("textarea")),this.commitContent(e),a&&t.insertElement(e)},contents:[{id:"info",label:t.lang.forms.textarea.title,title:t.lang.forms.textarea.title,elements:[{id:"_cke_saved_name",type:"text",label:t.lang.common.name,"default":"",accessKey:"N",setup:function(t){this.setValue(t.data("cke-saved-name")||t.getAttribute("name")||"")},commit:function(t){this.getValue()?t.data("cke-saved-name",this.getValue()):(t.data("cke-saved-name",!1),t.removeAttribute("name"))}},{type:"hbox",widths:["50%","50%"],children:[{id:"cols",type:"text",label:t.lang.forms.textarea.cols,"default":"",accessKey:"C",style:"width:50px",validate:CKEDITOR.dialog.validate.integer(t.lang.common.validateNumberFailed),setup:function(t){this.setValue(t.hasAttribute("cols")&&t.getAttribute("cols")||"")},commit:function(t){this.getValue()?t.setAttribute("cols",this.getValue()):t.removeAttribute("cols")}},{id:"rows",type:"text",label:t.lang.forms.textarea.rows,"default":"",accessKey:"R",style:"width:50px",validate:CKEDITOR.dialog.validate.integer(t.lang.common.validateNumberFailed),setup:function(t){this.setValue(t.hasAttribute("rows")&&t.getAttribute("rows")||"")},commit:function(t){this.getValue()?t.setAttribute("rows",this.getValue()):t.removeAttribute("rows")}}]},{id:"value",type:"textarea",label:t.lang.forms.textfield.value,"default":"",setup:function(t){this.setValue(t.$.defaultValue)},commit:function(t){t.$.value=t.$.defaultValue=this.getValue()}}]}]}});