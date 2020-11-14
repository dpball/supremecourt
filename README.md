
<p align="center">
	  <img src="/img/supremecourt.png">
</p>

## Kleros Hackathon

> Prediction is very difficult, especially about the future - Niels Bohr

### Project: Prediction Market Maker / Betting Platform

Regardless of ones political beliefs, the 2020 US Presidential election has started a discussion on the importance of decentralised prediction markets. Crowdsourcing predictions by providing financial incentives can often outperform traditional forecasting. In this project, we aim to produce a decentralised prediction market that runs on the ethereum blockchain and is secured by Kleros.

In order to design this project, two problems need to be addressed:

#### 1. The oracle problem
The outcome of any event (such as "Who will win the 2020 US Presidential Election?") needs to be established and stored on the blockchain in a trustless manner.

#### 2. Handling order book / market making
In order for users to act honestly, there must be a financial reward. Money can be exchanged between users (such as what is seen on sports betting exchanges) or with an individual market maker. 

### Existing implementations

Currently there exists a number of platforms that provide prediction markets such as Augur and Omen and these are implemented in different ways.

- Augur rewards REP token holders for acting as oracles and provides odds via a traditional order book.

- Omen use Realit.io to act as oracles via submitting answer bonds and provides liquidity via a fixed product market maker (similar to sites such as Uniswap)

In our implementation, we aim to create a strong incentive for users to create markets and provide liquidity to them, thus achieving better prices for bettors than centralised exchanges.


## Our Implementation

*Image goes here*

Our implemention works the following way:

- An Initial Liquidity Provider (ILP or GAMEMASTER) creates a market on the SUPREME COURT for a bet with at least two outcomes, setting the expiry date only. The liquidity they provide to the market can only be recovered after the bet has been settled.

- Users (BETTORS) make bets on multiple positions for the duration of the market. Essentially, bettors are purchasing futures contracts that expire at 1 if the outcome they bet on occurs, and 0 if it does not. The prices of these are set by the ODDS ALLOCATION ALGORITHM (OAA). The OAA is designed such that the GAMEMASTER will more often than not profit from the pool, although losses are still possible. The markets where a single outcome is guaranteed or extremely likely (Will I roll 1-6 with a dice?) are the most common types of market that make losses.

- Once the bet has expired, the GAMEMASTER has 24 hours to report the outcome of the bet. Should nobody dispute the outcome within 24 hours, the winners can claim their winnings and the GAMEMASTER recovers the initial liquidity pool and the additional profits. In the future, where outcomes can be determined from an API - the use of [chainlink oracles](https://chain.link) may prove beneficial.

- Anyone can dispute the GAMEMASTER's decision through the decentralised dispute resolution platform which is provided by Kleros. Whoever successfully disputes the GAMEMASTER's decision wins the rights to the Initial Liquidity Pool and any profits that the initial liquidity provider is entitled to. This should be a sufficient incentive for users to dispute incorrect decisions by Gamemasters. 

- BETTORS can also bet on a NONE OF THE ABOVE / REFUSE TO ARBITRATE/ INVALID QUESTION outcome for all contracts. This serves two purposes: first, it helps filter out unethical or invalid questions. Second, it includes all edge cases, such as a football game being cancelled before the contract expires, essentially anything that is not one of the predetermined outcomes. Because it is possible to bet on these unlikely edge cases, the profits of the GAMEMASTER increase.


### Market Making & the Odds Allocation Algorithm

Traditional orderbooks are dependent on large amounts of liquidity. As we intend for users to be able to generate their own prediction markets, it would not be viable to expect them to provide sufficient liquidity to allow for an orderbook model.

We shall take advantage of the features provided by automated market makers to allow a user to make a prediction regardless of the pre-existing liquidity. There are many different algorithms available but we have chosen to use a modified LMSR (logarithmic market scoring rule) to generate a fair price for any market.

These algorithms allow for dynamic price discovery without any pre-determined notion of the starting odds and can be implemented in a manner that minimises the losses in the case of large payouts. Morover, the algorithm is calibrated such that it is expected to generate a profit to the GAMEMASTER. 


### Future Features

- CashOut function
- ChainLink Oracle for API 







