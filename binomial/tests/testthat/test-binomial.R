library(testthat)

context("check binomial arguments")

test_that("check_prob with ok arguments", {
  expect_true(check_prob(1))
  expect_true(check_prob(0.1))
  expect_true(check_prob(0.2))
})

test_that("check_prob with bad arguments",{
  expect_error(check_prob(2))
  expect_error(check_prob(-0.1))
  expect_error(check_prob("a"))
  expect_error(check_prob(c(1, 0)))
})

test_that("check_trials with ok arguments", {
  expect_true(check_trials(0))
  expect_true(check_trials(1))
  expect_true(check_trials(2))
})

test_that("check_trials with bad arguments", {
  expect_error(check_trials(-1))
  expect_error(check_trials(1.1))
  expect_error(check_trials("a"))
})

test_that("check_success with ok arguments", {
  expect_true(check_success(1, 2))
  expect_true(check_success(c(1,3), 4))
  expect_true(check_success(0, 1))
})

test_that("check_success with bad arguments", {
  expect_error(check_success(-1, 2))
  expect_error(check_success(1, c(1, 2)))
  expect_error(check_success(2, 1))
})

context("summary measures")

test_that("test aux_mean", {
  expect_equal(aux_mean(1,0.5), 0.5)
  expect_length(aux_mean(1, 0.5), 1)
  expect_is(aux_mean(1, 0.5),"numeric")
})

test_that("test aux_variance", {
  expect_equal(aux_variance(1,0.5), .25)
  expect_length(aux_variance(1, 0.5), 1)
  expect_is(aux_variance(1, 0.5),"numeric")
})

test_that("test aux_mode", {
  expect_equal(aux_mode(1, 0.5), 1)
  expect_length(aux_mode(1, 0.5), 1)
  expect_is(aux_mode(1, 0.5),"integer")
})

test_that("test aux_skewness", {
  expect_equal(aux_skewness(1,0.5),  0)
  expect_length(aux_skewness(1, 0.5), 1)
  expect_is(aux_skewness(1, 0.5),"numeric")
})

test_that("test aux_kurtosis", {
  expect_equal(aux_kurtosis(1,0.5), -2)
  expect_length(aux_kurtosis(1, 0.5), 1)
  expect_is(aux_kurtosis(1, 0.5),"numeric")
})



context("binomial")

test_that("test bin_choose", {
  expect_equal(bin_choose(2,1), 2)
  expect_length(bin_choose(2, 1), 1)
  expect_error(bin_choose(1, 2),"k cannot be greater than n")
})

test_that("test bin_probability", {
  expect_equal(bin_probability(1,2,0.5), 0.5)
  expect_length(bin_probability(1,2,0.5), 1)
  expect_error(bin_probability(2,1,0.5),"success cannot be greater than trials")
})

test_that("test bin_distribution", {
  expect_is(bin_distribution(1,0.5), "bindis")
  expect_length(bin_distribution(1,0.5), 2)
  expect_error(bin_distribution(1,1.1),"invalid prob value")
})

test_that("test bin_cumulative", {
  expect_is(bin_cumulative(1,0.5), "bincum")
  expect_length(bin_cumulative(1,0.5), 3)
  expect_error(bin_cumulative(1,1.1),"invalid prob value")
})

