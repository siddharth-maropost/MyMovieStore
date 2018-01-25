ActiveAdmin.register ApiKey do
  action_item only: :index do
    radio_button(:feature, 'enable', :class => 'form-control radio-inline')
  end
  action_item only: :index do
    radio_button(:feature, 'disable', :class => 'form-control radio-inline')
  end
end
