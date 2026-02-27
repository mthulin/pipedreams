test_that("lm.data.frame produces same result as stats::lm", {
  result_pipe  <- mtcars |> lm(mpg ~ wt + cyl)
  result_stats <- stats::lm(mpg ~ wt + cyl, data = mtcars)

  expect_equal(coef(result_pipe), coef(result_stats))
  expect_equal(fitted(result_pipe), fitted(result_stats))
})

test_that("lm.default still works for non-data.frame first argument", {
  result_pipe  <- lm(mpg ~ wt, data = mtcars)
  result_stats <- stats::lm(mpg ~ wt, data = mtcars)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("lm.data.frame errors when formula is not a formula", {
  expect_error(mtcars |> lm("mpg ~ wt"), "'formula' must be a formula object")
})

test_that("glm.data.frame produces same result as stats::glm", {
  result_pipe  <- mtcars |> glm(am ~ mpg + wt, family = binomial)
  result_stats <- stats::glm(am ~ mpg + wt, data = mtcars, family = binomial)

  expect_equal(coef(result_pipe), coef(result_stats))
  expect_equal(result_pipe$deviance, result_stats$deviance)
})

test_that("glm.default still works for non-data.frame first argument", {
  result_pipe  <- glm(am ~ mpg, data = mtcars, family = binomial)
  result_stats <- stats::glm(am ~ mpg, data = mtcars, family = binomial)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("glm.data.frame errors when formula is not a formula", {
  expect_error(mtcars |> glm("am ~ mpg"), "'formula' must be a formula object")
})

test_that("aov.data.frame produces same result as stats::aov", {
  result_pipe  <- npk |> aov(yield ~ block + N)
  result_stats <- stats::aov(yield ~ block + N, data = npk)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("aov.default still works for non-data.frame first argument", {
  result_pipe  <- aov(yield ~ block + N, data = npk)
  result_stats <- stats::aov(yield ~ block + N, data = npk)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("aov.data.frame errors when formula is not a formula", {
  expect_error(npk |> aov("yield ~ block"), "'formula' must be a formula object")
})
