class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    matches = []
    patron.interests.each do |interest|
      exhibits.find_all do |exhibit|
        matches << exhibit if interest == exhibit.name
      end
    end
    matches
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    organized_list = Hash.new([])
    @exhibits.each do |exhibit|
      @patrons.each do |patron|
      organized_list[exhibit.name] << patron if patron.interests.include?(exhibit.name)
      end
    end
    organized_list
  end

  def ticket_lottery_contestants(exhibit)
    result = []
    @exhibits.each do |exhibit|
      @patrons.each do |patron|
        if patron.spending_money < exhibit.cost && patron.interests.include?(exhibit.name)
          result << patron
        end
      end
    end
    result
  end

  def draw_lottery_winner(exhibit)
    ticket_lottery_contestants(exhibit).map { |patron| patron.name }.sample
  end

  def announce_lottery_winner(exhibit)
    if name =! nil
      name = draw_lottery_winner(exhibit)
      "#{name} has won the IMAX edhibit lottery"
    else
      "No winners for this lottery"
    end
  end

end
