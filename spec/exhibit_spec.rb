require './lib/exhibit'

RSpec.describe do
  it 'exists' do
    exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})

    expect(exhibit).to be_instance_of(Exhibit)
  end
end
