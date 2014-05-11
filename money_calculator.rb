class MoneyCalculator

	attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands, :total, :money_change, :money_bills

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
  	@ones = ones.to_i * 1
  	@fives = fives.to_i * 5
  	@tens = tens.to_i * 10
  	@twenties = twenties.to_i * 20
  	@fifties = fifties.to_i * 50
  	@hundreds = hundreds.to_i * 100
  	@five_hundreds = five_hundreds.to_i * 500
  	@thousands = thousands.to_i * 1000

  	@total = @ones + @fives + @tens + @twenties + @fifties + @hundreds + @five_hundreds + @thousands

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
  end

  def change(cost)
    @cost= cost
    @money_change = @total - @cost
    if @money_change < 0 
      @money_bills = {}
    else
      @money_bills = {
        :ones => (@money_change.to_i % 1000 % 500 % 100 % 50 % 20 % 5) / 1,
        :fives => (@money_change.to_i % 1000 % 500 % 100 % 50 % 20% 10) / 5,
        :tens => (@money_change.to_i % 1000 % 500 % 100 % 50 % 20) / 10,
        :twenties => (@money_change.to_i % 1000 % 500 % 100 % 50) / 20,
        :fifties => (@money_change.to_i % 1000 % 500 % 100) / 50,
        :hundreds => (@money_change.to_i % 1000 % 500) / 100,
        :five_hundreds => (@money_change.to_i % 1000) / 500,
        :thousands => @money_change.to_i / 1000
      }

      return @money_bills
    end
  end
end