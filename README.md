# Rsi / Moving average Expert Advisor

This program is an algorithm (in the trading lingo: Expert Advisor) coded in mql4 programming language and his purpose
is to open trading orders in the market following the entry rules of the technical analysis. 

In this program I coded the algorithm in order to place a <span style="color:green">buy order</span> in the market when these conditions are satisfied:

- The fast moving average (smoothed red line) has to stay above the slow moving average (smoothed blue line).
- The RSI must be smaller than 30 (oversold).
- The new close price must be greater than the previous one.

For the sell orders the conditions are the opposite:

- The slow moving average (smoothed red line) has to stay above the fast moving average (smoothed blue line).
- The RSI must be greater than 70 (overbought).
- The new close price must be smaller than the previous one.

<br>

In this graph we can see the trading alghoritm at work in the Eur/Usd cross:

<img width="601" alt="Algorithm at work" src="https://user-images.githubusercontent.com/95365607/158892759-b9b413b1-6f3a-45cf-aab8-7ce02a3008cc.png">

<br>
In this example there are 2 orders and both of them are long positions, furthermore they both succesfully reached the take profit.
<br>
<br>

## More about this project

I coded this alghoritm for my bachelor degree thesis by the title:'THE ONLINE TRADING WITH CFDs: Why the majority of the traders lose their own money?'
and I used the results of the operativity of this very algorithm to see if some of the strategies described in the technical analysis books can really
outperform the market.
In conclusion , this project gave further evidences that the markets are efficient and that is 
virtually impossible to generate a revenue with this type of elementary strategies.

