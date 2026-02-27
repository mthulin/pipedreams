test_that("t.test.data.frame produces same result as stats::t.test", {
  result_pipe  <- mtcars |> t.test(mpg ~ am)
  result_stats <- stats::t.test(mpg ~ am, data = mtcars)

  expect_equal(result_pipe$statistic, result_stats$statistic)
  expect_equal(result_pipe$p.value,   result_stats$p.value)
  expect_equal(result_pipe$estimate,  result_stats$estimate)
})

test_that("t.test.data.frame passes ... arguments correctly", {
  result_pipe  <- mtcars |> t.test(mpg ~ am, var.equal = TRUE)
  result_stats <- stats::t.test(mpg ~ am, data = mtcars, var.equal = TRUE)

  expect_equal(result_pipe$statistic, result_stats$statistic)
})

test_that("t.test.data.frame errors when formula is not a formula", {
  expect_error(mtcars |> t.test("mpg ~ am"), "'formula' must be a formula object")
})

test_that("wilcox.test.data.frame produces same result as stats::wilcox.test", {
  result_pipe  <- mtcars |> wilcox.test(mpg ~ am)
  result_stats <- stats::wilcox.test(mpg ~ am, data = mtcars)

  expect_equal(result_pipe$statistic, result_stats$statistic)
  expect_equal(result_pipe$p.value,   result_stats$p.value)
})

test_that("wilcox.test.data.frame errors when formula is not a formula", {
  expect_error(mtcars |> wilcox.test("mpg ~ am"), "'formula' must be a formula object")
})
