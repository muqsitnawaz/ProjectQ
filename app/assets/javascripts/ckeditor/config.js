CKEDITOR.editorConfig = function( config )
{
   config.skins = 'office2003';

   config.toolbar = 'toolbarLight';

    config.toolbar_toolbarLight =
    [
        ['Font','FontSize','Bold','Italic','Strike','-','NumberedList','BulletedList','Blockquote','TextColor','-','Image','Table','Smiley','SpecialChar','Link'],
    ];

   config.toolbar_Fullx =
   [
      ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
      ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
      ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
      '/',
      ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
      ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
      ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
      ['Link','Unlink','Anchor'],
      ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar'],
      '/',
      ['Styles','Format','Font','FontSize'],
      ['TextColor','BGColor'],
      ['Maximize', 'ShowBlocks']
   ];

};