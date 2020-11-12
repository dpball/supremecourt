
<p align="center">
	  <img src="/img/supremecourt.png">
</p>

## Kleros Hackathon


### Project: Prediction Market Maker / Betting Platform

Regardless of ones political beliefs, the 2020 US Presidential election has started a discussion on the importance of decentralised prediction markets. Crowdsourcing predictions by providing financial incentives can often outperform traditional forecasting. In this project, we aim to produce a decentralised prediction market that runs on the ethereum blockchain and is secured by Kleros.

In order to design this project, two problems need to be addressed:

1. The oracle problem
> The outcome of any event (such as "Who will win the 2020 US Presidential Election?") needs to be established and stored on the blockchain in a trustless manner.

2. Handling order book / market making
> In order for users to act honestly, there must be a financial reward. Money can be exchanged between users (such as what is seen on sports betting exchanges) or with an individual market maker. 

### Existing implementations

Currently there exists a number of platforms that provide prediction markets such as Augur and Omen and these are implemented in different ways.

- Augur rewards REP token holders for acting as oracles and provides odds via a traditional order book.

- Omen use Realit.io to act as oracles via submitting answer bonds and provides liquidity via a fixed product market maker (similar to sites such as Uniswap)

In our implementation, we aim to create a strong incentive for users to create markets and provide liquidity to them, thus achieving better prices for bettors than centralised exchanges. Our project is unique in its implementation of the above principles:

### Oracle problem

We intend to solve the oracle problem using a system that optimises oracle costs by framing the outcome as a dispute.

In the first instance, the outcome of a prediction market will be determined by the user that created the market. 

After the outcome has been set (or if no outcome is set), there is a period of time to allow for anyone to dispute the result. If nobody disputes the result, then the reward can be claimed for users that predicted that outcome. In this scenario, it can be said that the outcome has been confirmed by 100% of users for no cost.

If a user disputes the result, the outcome will instead be decided by a third party. The event data will be fed to a decentralised dispute resolution platform which is provided by Kleros. The arbitration cost should be low enough to ensure that users are not dissuaded from creating a dispute if they believe that the initial outcome was incorrect, but high enough to dissuade from spurious arbitration requests.

In case of a successful dispute, whoever raised the dispute will be rewarded with the fees that would have otherwise accrued to the market creator. 

Kleros is also able to provide the option "refused to arbitrate" which can provide a solution where unforeseen outcomes may have occurred. For example, think of an instance where a football match is cancelled because of coronavirus or the bet itself is unethical (e.g. asassination markets).

In the future, where outcomes can be determined from an API - the use of [chainlink oracles](https://chain.link) may prove beneficial. 

### Market Making

Traditional orderbooks are dependent on large amounts of liquidity. As we intend for users to be able to generate their own prediction markets, it would not be viable to expect them to provide sufficient liquidity to allow for an orderbook model.

We shall take advantage of the features provided by automated market makers to allow a user to make a prediction regardless of the pre-existing liquidity. There are many different algorithms available but we have chosen to use a modified LMSR (logarithmic market scoring rule) to generate a fair price for any market.

These algorithms allow for dynamic price discovery without any pre-determined notion of the starting odds and can be implemented in a manner that minimises the losses in the case of large payouts. When the algorithm generates a profit, the funds can be kept to subsidise future arbitration costs.
