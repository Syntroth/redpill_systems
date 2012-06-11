module Items

  class Ammunition < Generic
    field :name, type: String
    field :multiplier, type: Float, default: 1.0
    field :amount, type: Integer, default: 0

    after_initialize do |document|
      self.stackable = true
    end
  end

end