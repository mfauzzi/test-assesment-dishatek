Rails.application.routes.draw do
    root 'game#index'
    post 'game/update' => 'game#update'
    post 'game/reset' => 'game#reset'
end
