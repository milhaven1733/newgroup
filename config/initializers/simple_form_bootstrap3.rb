# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :clean, tag: 'div', class: "clean" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label_input
  end

  config.wrappers :part, tag: 'div', class: "part" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label_input
  end

  config.wrappers :bootstrap3, tag: 'div', class: 'form-group control-group', error_class: 'simple-form-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper :controls, tag: 'div', class: 'col-lg-10 col-md-10 col-sm-10 controls' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :thin_bootstrap3, tag: 'div', class: 'form-group', error_class: 'simple-form-error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'label', class: "col-lg-2 col-md-2 col-sm-2 left-aligned control-label" do |l|
      l.use :label_text
    end
    b.wrapper :controls, tag: 'div', class: 'col-lg-6 col-md-6 col-sm-6 controls' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :ransack, tag: 'div', class: 'form-group control-group', required: false do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'label', class: "col-lg-4 col-md-4 col-sm-4 right-aligned control-label" do |l|
      l.use :label_text
    end
    b.wrapper :controls, tag: 'div', class: 'col-lg-7 col-md-7 col-sm-7 controls' do |i|
      i.use :input
    end
  end

  config.wrappers :inline_checkbox, tag: 'div', class: 'control-group form-group inline-checkbox', error_class: 'simple-form-error' do |b|
    b.wrapper tag: "div", class: "col-lg-2" do
    end
    b.use :html5
    b.use :placeholder
    b.wrapper :controls, tag: 'div', class: 'col-lg-10 col-md-10 col-sm-10 control' do |ba|
      ba.use :input, class: "boolean", type: "checkbox"
      ba.use :label_text
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :prepend, tag: 'div', class: "control-group", error_class: 'simple-form-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-prepend' do |prepend|
        prepend.use :input
      end
      input.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
      input.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :append, tag: 'div', class: "control-group", error_class: 'simple-form-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-append' do |append|
        append.use :input
      end
      input.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
      input.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap3
  config.button_class = 'btn btn-default'
  config.error_notification_class = 'alert alert-danger'
  config.label_class = 'control-label left-aligned'
  config.input_class = 'form-control'
end
