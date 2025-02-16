require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  it 'loads the model' do
    expect(JwtDenylist).to be_a(Class)
  end
end
