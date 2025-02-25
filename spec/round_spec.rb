require './lib/turn'
require './lib/card'
require './lib/deck'
require './lib/round'
describe Deck do
  before do
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @round = Round.new(@deck)
  end

  it 'exists' do
    expect(@round).to be_instance_of(Round)
  end
  it 'has a deck' do
    expect(@round.deck).to eq(@deck)
  end
  it 'has a turns array' do
    expect(@round.turns).to eq([])
  end
  it 'can show current card' do
    expect(@round.current_card).to eq(@card_1)
  end
  it 'is in the turn class' do
    new_turn = @round.take_turn("Juneau")
    expect(new_turn.class).to eq(Turn)
  end
  it 'tests if its correct' do
    new_turn = @round.take_turn("Juneau")
    expect(new_turn.correct?).to eq(true)
  end
  it 'tests if its correct' do
    new_turn = @round.take_turn("Juneau")
    expect(@round.turns).to eq([new_turn])
  end
  it 'checks how many are correct' do
    new_turn = @round.take_turn("Juneau")
    expect(@round.number_correct).to eq(1)
  end
  it 'goes to the next turn' do
    new_turn = @round.take_turn("Juneau")
    # new_turn = @round.take_turn("Venus")
    expect(@round.current_card).to eq(@card_2)
  end
  it 'keeps track of turns' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.turns.count).to eq(2)
  end
  it 'gives feedback' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.turns.last.feedback).to eq("Incorrect!")
  end
  it 'counts the number correct' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.number_correct).to eq(1)
  end
  it 'can count number correct by category' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.number_correct_by_category(:Geography)).to eq(1)
    expect(@round.number_correct_by_category(:STEM)).to eq(0)
  end
  it 'can count number incorrect by category' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.number_incorrect_by_category(:Geography)).to eq(0)
    expect(@round.number_incorrect_by_category(:STEM)).to eq(1)
  end
  it 'can calculate the percent correct' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.percent_correct).to eq(50.0)
  end
  it 'can calculate percent correct by category' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.percent_correct_by_category(:Geography)).to eq(100.0)
  end
  it 'moves to the last card' do
    new_turn = @round.take_turn("Juneau")
    new_turn = @round.take_turn("Venus")
    expect(@round.current_card).to eq(@card_3)
  end
end
