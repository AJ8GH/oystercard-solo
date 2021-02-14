# Oystercard Challenge

[![Coverage Status](https://coveralls.io/repos/github/AJ8GH/oystercard-solo/badge.svg)](https://coveralls.io/github/AJ8GH/oystercard-solo) [![Maintainability](https://api.codeclimate.com/v1/badges/2db4bbc21808878bc42d/maintainability)](https://codeclimate.com/github/AJ8GH/oystercard-solo/maintainability)

![Oystercard](https://designandbuilduk.net/wp-content/uploads/2018/07/611.jpg)

A tricky exercise in extracting classes from a complex system using tests as a scaffold. The task was to build a system for TFL's Oystercard payment network

My implementation works, but I would like to build this program again from scratch to improve on the design further and practice the techniques again.

## Technical skills

- TDD
- Encapsulation
- Extracting a class
- SRP
- Dependency injection
- Dependency inversion
- Domain Modelling

## Dependencies

- `rspec`
- `rubocop`
- `simplecov`
- `simplecov-console`

## Getting Started

### Clone

```shell
git clone git@github.com:AJ8GH/oystercard-solo
```

### Install dependenies

```shell
bundle
```

### run oystercard challenge script in irb

```shell
irb -r ./ib/oystercard_challenge.rb
```

## User stories

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
