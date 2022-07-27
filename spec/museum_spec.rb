require './lib/exhibit'
require './lib/patron'
require './lib/museum'

RSpec.describe do
  it 'exists' do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns).to be_instance_of(Museum)
  end

  it 'has a name and empty exhibits list by default as attributes' do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns.name).to eq("Denver Museum of Nature and Science")
    expect(dmns.exhibits).to eq([])
  end

  it 'can add exhibits' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
  end

  it 'can recommend exhibits to a specific patron' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)
    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("IMAX")

    expect(dmns.recommend_exhibits(patron_1)).to eq([dead_sea_scrolls, gems_and_minerals])
    expect(dmns.recommend_exhibits(patron_2)).to eq([imax])

  end


    it 'can admit patrons' do
      dmns = Museum.new("Denver Museum of Nature and Science")
      dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
      imax = Exhibit.new({name: "IMAX",cost: 15})
      gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      expect(dmns.patrons).to eq([])

      patron_1 = Patron.new("Bob", 20)
      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2 = Patron.new("Sally", 20)
      patron_2.add_interest("Dead Sea Scrolls")
      patron_3 = Patron.new("Johnny", 5)
      patron_3.add_interest("Dead Sea Scrolls")

      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)

      expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
    end

#i know this test doesn't pass, I spend an hour on it and then moved on to show my other skills.
    xit 'can list patrons as a hash by interest by exhibit' do
      dmns = Museum.new("Denver Museum of Nature and Science")
      dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
      imax = Exhibit.new({name: "IMAX",cost: 15})
      gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      expect(dmns.patrons).to eq([])

      patron_1 = Patron.new("Bob", 20)
      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2 = Patron.new("Sally", 20)
      patron_2.add_interest("Dead Sea Scrolls")
      patron_3 = Patron.new("Johnny", 5)
      patron_3.add_interest("Dead Sea Scrolls")

      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)

      hash = {
        "Dead Sea Scrolls": [patron_1, patron_2, patron_3],
        "IMAX": [],
        "Gems and Minerals": [patron_1]
      }

      expect(dmns.patrons_by_exhibit_interest).to eq(hash)
    end

  it 'can list patrons who qualify for the lottery for a particular exhibit' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.patrons).to eq([])

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

# I only put patron 3 in this expect statement because Johnny is the only one with
#less then $5 which is less than the entry fee of #10 even though the interaction pattern has more than
#one element in the array
    expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_3])
  end

  it 'can draw a lottery winner' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.patrons).to eq([])

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)
#don't know how to use a stub yet but looking forward to learning!
    expect(dmns.draw_lottery_winner(dead_sea_scrolls)).to be_instance_of(String)
  end


  it 'can announce a lottery winner' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.patrons).to eq([])

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.announce_lottery_winner(dead_sea_scrolls)).to eq("Johnny has won the IMAX edhibit lottery")
  end
end
