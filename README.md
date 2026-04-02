# Pretenuring-Advice-Algorithm

Implementation of Blackburn’s *Pretenuring Advice* algorithm for Pharo.

## Overview

This repository provides an implementation of the pretenuring advice algorithm proposed by Blackburn et al., adapted for the Pharo environment.

The goal of the algorithm is to **analyze object lifetimes from profiling data** and produce **allocation-site-level recommendations** that can be used to guide garbage collector (GC) pretenuring decisions.

Rather than modifying the VM directly, this tool generates advice that developers can use to configure or experiment with pretenuring strategies.

## How to Install 

```st
EpMonitor disableDuring: [
	Metacello new
		baseline: 'PretenuringAdviceAlgorithm';
		repository: 'github://jordanmontt/Pretenuring-Advice-Algorithm:main';
		load ].
```

## How it Works

At a high level, the algorithm operates in three stages:

1. **Profiling**

   Object samples are collected during program execution using a profiler (e.g., FILiP). Each sample records:
    * Object size (in bytes)
    * Allocation time
    * Collection (death) time

2. **Lifetime Analysis**

   From the collected data, the algorithm computes normalized lifetime metrics:
    * Normalized age: relative to the program’s maximum live size
    * Normalized time of death: relative to total allocation time

3. **Classification & Advice Generation**
    * Objects are classified as: short-lived, long-lived, or immortal (merged into long-lived due to Pharo’s two-generation GC)
    * Allocation sites are then classified based on the distribution of object lifetimes they produce.
    * A site is considered long-lived if long-lived objects dominate; otherwise, it defaults to short-lived.

The resulting classification can be used to decide which allocation sites should be pretenured.

## Profiling Dependency 

This implementation expects object lifetime samples as input. These can be obtained using the [`FiLiP`](https://github.com/jordanmontt/illimani-memory-profiler) profiler.

## References

The algorithm is based on the following papers:
- Blackburn et al. [Pretenuring for Java](https://dl.acm.org/doi/abs/10.1145/504311.504307)
- Blackburn et al. [Profile-Based Pretenuring](https://dl.acm.org/doi/abs/10.1145/1180475.1180477)
