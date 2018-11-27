class Card
  attr_accessor :hide, :face_up
  def initialize(value)
    @value = value
    @face_up = false
  end
  def hide
    @face_up = false
  end
  def reveal 
    @face_up = true
  end
  def to_s
    @value
  end
  def ==(other_val)
    @value == other_val
  end
end