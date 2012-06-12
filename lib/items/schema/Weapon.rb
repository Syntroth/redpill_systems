module Items

  class Weapon < Generic
    field :damage, type: Integer, default: 0
    field :skill, type: String

    @showable = {mass: 'kg', damage: '', skill: ''}
  end

end
