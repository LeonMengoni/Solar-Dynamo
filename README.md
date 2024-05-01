# Solar-Dynamo
Bayesian inference on sunspot data, inspired by "Can Stochastic Resonance Explain Recurrence of Grand Minima?" by Carlo Albert et al. 

## Bayesian inference

Given a model with parameters $\boldsymbol{\theta}$, and observational data \boldsymbol{D}, inference can be performed to find credibility intervals for the model parameters, given the data.

Bayes' theorem is written as:

$$
p(\boldsymbol{\theta}|D) = \frac{p(D|\boldsymbol{\theta})\cdot p(\boldsymbol{\theta})}{p(D)}
$$

where $p(D|\boldsymbol{\theta})$ is the _likelihood_ of the data given the model, $p(\boldsymbol{\theta})$ is the _prior_ probability distribution of the parameters, $p(D)$ is the _evidence_ or _marginal likelihood_ of the data, and $p(\boldsymbol{\theta}|D)$ is the _posterior_ probability distribution of the parameters, given the data.

The posterior distribution $p(\boldsymbol{\theta}|D)$ contains all the necessary information about the parameters space. 

## Sampling from a probability distribution

In Bayesian inference, we will want to compute expectation values of functions with respect to the posterior probability distribution. Given a function $f(\boldsymbol{\theta})$, the general problem is to compute:

$$
\mathbb{E}_{\boldsymbol{\theta}\sim p(\boldsymbol{\theta}|D)} \[f(\boldsymbol{\theta})\] = \int p(\boldsymbol{\theta}|D)f(\boldsymbol{\theta})d\boldsymbol{\theta}
$$

This integral is typically too complex to solve analytically, so we resort to sampling methods that enable to compute the integral as a sum over the $N$ samples $\boldsymbol{\theta_i}$:

$$
\int p(\boldsymbol{\theta}|D)f(\boldsymbol{\theta})d\boldsymbol{\theta} = \frac{1}{N}\sum_{i=1}^N f(\boldsymbol{\theta_i})  
$$

**Markov Chain Monte Carlo** (MCMC) is a family of algorithms that allow sampling from complex distributions. The main idea of MCMC is to generate a Markov Chain whose equilibrium distribution resembles the target distribution. 
