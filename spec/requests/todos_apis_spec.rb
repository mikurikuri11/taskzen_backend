require 'rails_helper'

describe 'GET todos_by_uid/:uid' do
  it '指定したユーザーのToDo取得' do
    FactoryBot.create_list(:todo, 10)
    get 'todos_by_uid/:uid'
    json = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json.length).to eq(1)
  end
end
