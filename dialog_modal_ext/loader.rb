# typed: true
require 'sketchup'

module ModalDialogError
  module Menu
    FIRST_DIALOG_CONTENT = "<script>setTimeout(() => { sketchup.callNext() }, 2000)</script><p>First dialog content</p>".freeze
    SECOND_DIALOG_CONTENT = "<p>Second dialog content</p>".freeze

    private_class_method def self.open_second_dialog
      dialog = UI::HtmlDialog.new
      dialog.set_html SECOND_DIALOG_CONTENT
      dialog.show_modal
    end

    private_class_method def self.open_first_dialog
      dialog = UI::HtmlDialog.new
      dialog.add_action_callback('callNext') do |_|
        dialog.close
        open_second_dialog
      end
      dialog.set_html FIRST_DIALOG_CONTENT
      dialog.show_modal
    end

    private_class_method def self.setup_test_case(menu)
      menu_item = menu.add_item('Test Case') do
        open_first_dialog
      end

      menu.set_validation_proc(menu_item) do
        MF_ENABLED
      end
    end

    private_class_method def self.show_second_dialog(menu)
      menu_item = menu.add_item('Show Second Dialog') do
        open_second_dialog
      end

      menu.set_validation_proc(menu_item) do
        MF_ENABLED
      end
    end

    def self.setup
      ext_menu = UI.menu('Extensions')
      menu = ext_menu.add_submenu('Modal Dialog Error Example')
      setup_test_case(menu)
      show_second_dialog(menu)
    end
  end

  def self.launch
    Menu.setup
    file_loaded(__FILE__)
  end

  launch unless file_loaded?(__FILE__)
end
