test_that("lmer.data.frame produces same result as lme4::lmer", {
  skip_if_not_installed("lme4")
  library(lme4)

  result_pipe  <- sleepstudy |> lmer(Reaction ~ Days + (Days | Subject))
  result_stats <- lme4::lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)

  expect_equal(fixef(result_pipe), fixef(result_stats))
  expect_equal(logLik(result_pipe), logLik(result_stats))
})

test_that("lmer.default still works for non-data.frame first argument", {
  skip_if_not_installed("lme4")
  library(lme4)

  result_pipe  <- lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)
  result_stats <- lme4::lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)

  expect_equal(fixef(result_pipe), fixef(result_stats))
})

test_that("lmer.data.frame errors when formula is not a formula", {
  skip_if_not_installed("lme4")
  library(lme4)
  expect_error(sleepstudy |> lmer("Reaction ~ Days + (Days | Subject)"),
               "'formula' must be a formula object")
})


test_that("glmer.data.frame produces same result as lme4::glmer", {
  skip_if_not_installed("lme4")
  library(lme4)

  result_pipe  <- cbpp |>
    glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
          family = binomial)
  result_stats <- lme4::glmer(
    cbind(incidence, size - incidence) ~ period + (1 | herd),
    data = cbpp, family = binomial
  )

  expect_equal(fixef(result_pipe), fixef(result_stats))
  expect_equal(logLik(result_pipe), logLik(result_stats))
})

test_that("glmer.default still works for non-data.frame first argument", {
  skip_if_not_installed("lme4")
  library(lme4)

  result_pipe  <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
                        data = cbpp, family = binomial)
  result_stats <- lme4::glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
                               data = cbpp, family = binomial)

  expect_equal(fixef(result_pipe), fixef(result_stats))
})

test_that("glmer.data.frame errors when formula is not a formula", {
  skip_if_not_installed("lme4")
  library(lme4)
  expect_error(
    cbpp |> glmer("cbind(incidence, size - incidence) ~ period + (1 | herd)",
                  family = binomial),
    "'formula' must be a formula object"
  )
})
