test_that("survfit.data.frame produces same result as survival::survfit", {
  skip_if_not_installed("survival")
  library(survival)

  result_pipe  <- lung |> survfit(Surv(time, status) ~ sex)
  result_stats <- survival::survfit(Surv(time, status) ~ sex, data = lung)

  expect_equal(result_pipe$surv,   result_stats$surv)
  expect_equal(result_pipe$time,   result_stats$time)
  expect_equal(result_pipe$n.risk, result_stats$n.risk)
})

test_that("survfit.default still works for non-data.frame first argument", {
  skip_if_not_installed("survival")
  library(survival)

  result_pipe  <- survfit(Surv(time, status) ~ sex, data = lung)
  result_stats <- survival::survfit(Surv(time, status) ~ sex, data = lung)

  expect_equal(result_pipe$surv, result_stats$surv)
})

test_that("survfit.data.frame errors when formula is not a formula", {
  skip_if_not_installed("survival")
  library(survival)
  expect_error(lung |> survfit("Surv(time, status) ~ sex"),
               "'formula' must be a formula object")
})


test_that("coxph.data.frame produces same result as survival::coxph", {
  skip_if_not_installed("survival")
  library(survival)

  result_pipe  <- lung |> coxph(Surv(time, status) ~ age + sex)
  result_stats <- survival::coxph(Surv(time, status) ~ age + sex, data = lung)

  expect_equal(coef(result_pipe), coef(result_stats))
  expect_equal(result_pipe$loglik, result_stats$loglik)
})

test_that("coxph.default still works for non-data.frame first argument", {
  skip_if_not_installed("survival")
  library(survival)

  result_pipe  <- coxph(Surv(time, status) ~ age + sex, data = lung)
  result_stats <- survival::coxph(Surv(time, status) ~ age + sex, data = lung)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("coxph.data.frame errors when formula is not a formula", {
  skip_if_not_installed("survival")
  library(survival)
  expect_error(lung |> coxph("Surv(time, status) ~ age"),
               "'formula' must be a formula object")
})


test_that("survreg.data.frame produces same result as survival::survreg", {
  skip_if_not_installed("survival")
  library(survival)

  result_pipe  <- lung |> survreg(Surv(time, status) ~ age + sex, dist = "weibull")
  result_stats <- survival::survreg(Surv(time, status) ~ age + sex,
                                    data = lung, dist = "weibull")

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("survreg.default still works for non-data.frame first argument", {
  skip_if_not_installed("survival")
  library(survival)

  result_pipe  <- survreg(Surv(time, status) ~ age + sex, data = lung)
  result_stats <- survival::survreg(Surv(time, status) ~ age + sex, data = lung)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("survreg.data.frame errors when formula is not a formula", {
  skip_if_not_installed("survival")
  library(survival)
  expect_error(lung |> survreg("Surv(time, status) ~ age"),
               "'formula' must be a formula object")
})
