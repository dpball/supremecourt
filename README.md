
<p align="center">
	  <img src="/img/supremecourt.png">
</p>

## Kleros Hackathon

> Prediction is very difficult, especially about the future - Niels Bohr

abdulla#2918

### Project: Prediction Market Maker / Betting Platform

The 2020 US Presidential election has started a discussion on the importance of decentralised betting markets. Crowdsourcing predictions by providing financial incentives can often outperform traditional forecasting. In this project, we aim to produce a decentralised betting market that runs on the ethereum blockchain and is secured by Kleros.

In order to design this project, three problems need to be addressed:

#### 1. The oracle problem
The outcome of any event (such as "Who will win the 2020 US Presidential Election?") needs to be established and stored on the blockchain in a trust minimized manner.

#### 2. Handling order book / market making
For the market to function, users need to be able to bet on certain outcomes.

#### 3. Bootstrapping liquidity
In order to create competitive betting prices, the market must be sufficiently liquid. 

### Existing implementations

Currently there exists a number of platforms that provide prediction markets such as Augur and Omen and these are implemented in different ways.

- [Augur](https://augur.net) rewards REP token holders for acting as oracles and provides odds via a traditional order book.

- [Omen](https://omen.eth.link/#/liquidity/curation-source/Any) use Realit.io to act as oracles via submitting answer bonds and provides liquidity via a fixed product market maker (similar to sites such as Uniswap)

In our implementation, we aim to create a strong incentive for users to create markets and provide liquidity to them, thus achieving better prices for bettors than centralised exchanges.

## What makes our solution different

We decided to focus on what we see as the two main issues of existing implementations: 

- Liquidity providers have little incentive to create markets. For example, the [Omen FAQ](https://omen.eth.link/faq.pdf) points out that the liquidity providers can lose up to all funds by creating a market. The trading fees do not compensate for this risk.  
- The truth settlement mechanism is too complex. Using two different truth determining mechanisms (Realit.io and appeals with Kleros) or an additional token (REP) adds fees and unneccesary complexity.

We have chosen to solve this through: 

- Using an odds allocation algorithm that provides a bounded loss to the liquidity providers, ensuring they can never lose more than 10% of their initial liquidity. 
- Using overrounding to ensure that "the house always wins" and liquidity providers have considerable upside to providing liquidity. 
- Delegating the truth determining mechanism to the initial liquidity provider, such that they stand to lose their funds if it gets successfully disputed through Kleros. 


## Our solution in practice

<p align="center">
	  <img src="/img/sneekPeak.png">
</p>


In practice our implemention works the following way:

- An Initial Liquidity Provider (GAMEMASTER) creates a market on the SUPREME COURT for a bet with at least two outcomes, setting the expiry date only. The liquidity they provide to the market can only be recovered after the bet has been settled.

- Users (BETTORS) make bets on multiple positions for the duration of the market. Essentially, bettors are purchasing futures contracts that expire at 1 if the outcome they bet on occurs, and 0 if it does not. The prices of these are set by the ODDS ALLOCATION ALGORITHM (OAA). The OAA is designed such that the GAMEMASTER will more often than not profit from the pool, although losses are still possible. The markets where a single outcome is guaranteed or extremely likely (Will I roll 1-6 with a dice?) are the most common types of market that make losses.


- Once the bet has expired, the GAMEMASTER has 24 hours to report the outcome of the bet. Should nobody dispute the outcome within 24 hours, the winners can claim their winnings and the GAMEMASTER recovers the initial liquidity pool and the additional profits. In the future, where outcomes can be determined from an API - the use of [chainlink oracles](https://chain.link) may prove beneficial.

- Anyone can dispute the GAMEMASTER's decision through the decentralised dispute resolution platform which is provided by Kleros. Whoever successfully disputes the GAMEMASTER's decision wins the rights to the Initial Liquidity Pool and any profits that the initial liquidity provider is entitled to. This should be a sufficient incentive for users to dispute incorrect decisions by Gamemasters. 

- BETTORS can also bet on a NONE OF THE ABOVE / REFUSE TO ARBITRATE/ INVALID QUESTION outcome for all contracts. This serves two purposes: first, it helps filter out unethical or invalid questions. Second, it includes all edge cases, such as a football game being cancelled before the contract expires, essentially anything that is not one of the predetermined outcomes. Because it is possible to bet on these unlikely edge cases, the profits of the GAMEMASTER increase.


### Market Making & the Odds Allocation Algorithm

Orderbook based DEXes have not been widely adopted yet due to the high throughput they would require. In practical terms, orderbook based DEXes are highly inefficient in terms of gas. For this reason we'll use a fixed product automated market maker such as [Uniswap](https://app.uniswap.org/#/swap) to offer prices. 

There are many different algorithms available but we have chosen to use a modified LMSR ([logarithmic market scoring rule](https://www.cs.cmu.edu/~./sandholm/liquidity-sensitive%20automated%20market%20maker.teac.pdf)) to generate a fair price for any market.

The key advantage of this algorithm compared to that of Uniswap or Omen is that: 
- The losses to the GAMEMASTER are bounded (i.e. 80% drawdowns are simply not possible). 
- The algorithm uses overrounding to generate an expected profit for the GAMEMASTER. 

### Future Features

- Setting odds after a creating a market to maximize profit
- CashOut function for users to sell back their bets to the market.
- ChainLink Oracle for API based bets. 
- Allow others to add liquidity to a bet, not just the GAMEMASTER. 







