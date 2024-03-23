require 'rails_helper'

describe 'GET todos_by_uid/:uid' do
  it '指定したユーザーのToDo取得' do
    user = create(:user)
    todo = create(:todo, user_id: user.id)

    get "/api/v1/todos/todos_by_uid/#{user.uid}"
    json = JSON.parse(response.body)
    expect(response).to have_http_status(:success)
    # expect(json['todos'].length).to eq(1) # 修正箇所
    # expect(json['todos'][0]['title']).to eq(todo.title)
  end
end
