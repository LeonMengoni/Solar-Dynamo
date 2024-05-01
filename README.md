# Bayesian Inference on the Solar Dynamo Model
Project developed under the guidance of Professor Carlo Albert (Eawag), for the unit "Laboratory of Computational Physics - module B" in the Physics of Data Master's Degree at the University of Padua, spring 2023.

Bayesian inference was performed on the solar dynamo model parameters, by using collected data on the number of sunspots, whcich follow the 11-year solar cycle. 



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



## Simulating the solar dynamo model

The solar dynamo model is represented by the following second order ODE:

$$
\left(\tau\frac{d}{dt} + 1\right)^2 B(t) = - \mathcal{N}(1 + \epsilon\cos(\omega_d t))f(B(t - q))B(t - q) + \sigma B_{max} \sqrt{\tau} \eta(t)
$$

The observable data is the intensity of the solar magnetic field, $B(t)$, for which the sunspot data (number of sunspots) is a proxy. For more mathematical details, consult the Solar_Dynamo_Report file in the repository. 

The workflow is as follows:

1) initialize values for model parameters (i.e. taken from the previously mentioned paper)
2) simulate the model by using the Stochastic Delay Differential Equations (SDDE) solver package in Julia
3) construct the posterior with the data (real or simulated)
4) sample the posterior by means of the EMCEE sampler package in python
5) construct credibility intervals for the parameters and compare with initial values
6) tweak simulation and EMCEE sampler

When using real data, skip directly to step 3. 

All the code is contained in the Solar_Dynamo_Notebook jupyter notebook file in the repo.
