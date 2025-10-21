Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'questions#index'
  devise_for :users

  resources :questions do
    resources :answers, shallow: true do
      member do
        patch :mark_best
      end
      # Voting for answers
      post 'upvote', to: 'votes#upvote'
      post 'downvote', to: 'votes#downvote'
      delete 'vote', to: 'votes#cancel'
      # Comments for answers
      resources :comments, only: [:create, :destroy]
    end

    # Voting for questions
    post 'upvote', to: 'votes#upvote'
    post 'downvote', to: 'votes#downvote'
    delete 'vote', to: 'votes#cancel'
    # Comments for questions
    resources :comments, only: [:create, :destroy]
  end

  resources :attachments, only: [:destroy]
  resources :tags, only: [:index, :show]
end