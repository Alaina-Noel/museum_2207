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

end
