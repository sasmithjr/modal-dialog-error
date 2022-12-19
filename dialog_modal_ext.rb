# typed: true
require 'sketchup'
require 'extensions'

module ModalDialogError
  VERSION = '0.24.1'.freeze

  unless file_loaded?(__FILE__)
    ext = SketchupExtension.new 'Modal Dialog Bug', 'dialog_modal_ext/loader'
    ext.description = 'Example extension to demonstrate issue with dialogs and show_modal'
    ext.version = '0.0.1'
    ext.copyright = "Smitty #{Time.now.year}"
    ext.creator = 'Smitty'
    Sketchup.register_extension ext, true

    file_loaded(__FILE__)
  end
end
