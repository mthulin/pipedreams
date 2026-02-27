test_that("glm.nb.data.frame produces same result as MASS::glm.nb", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- quine |> glm.nb(Days ~ Sex + Age + Eth)
  result_stats <- MASS::glm.nb(Days ~ Sex + Age + Eth, data = quine)

  expect_equal(coef(result_pipe), coef(result_stats))
  expect_equal(result_pipe$theta, result_stats$theta)
})

test_that("glm.nb.default still works for non-data.frame first argument", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- glm.nb(Days ~ Sex + Age + Eth, data = quine)
  result_stats <- MASS::glm.nb(Days ~ Sex + Age + Eth, data = quine)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("glm.nb.data.frame errors when formula is not a formula", {
  skip_if_not_installed("MASS")
  library(MASS)
  expect_error(quine |> glm.nb("Days ~ Sex"), "'formula' must be a formula object")
})


test_that("polr.data.frame produces same result as MASS::polr", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- housing |> polr(Sat ~ Infl + Type + Cont, weights = Freq)
  result_stats <- MASS::polr(Sat ~ Infl + Type + Cont, data = housing, weights = Freq)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("polr.default still works for non-data.frame first argument", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- polr(Sat ~ Infl + Type + Cont, data = housing, weights = Freq)
  result_stats <- MASS::polr(Sat ~ Infl + Type + Cont, data = housing, weights = Freq)

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("polr.data.frame errors when formula is not a formula", {
  skip_if_not_installed("MASS")
  library(MASS)
  expect_error(housing |> polr("Sat ~ Infl"), "'formula' must be a formula object")
})


test_that("lda.data.frame produces same result as MASS::lda", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- iris |> lda(Species ~ .)
  result_stats <- MASS::lda(Species ~ ., data = iris)

  expect_equal(result_pipe$means,    result_stats$means)
  expect_equal(result_pipe$scaling,  result_stats$scaling)
})

test_that("lda.default still works for non-data.frame first argument", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- lda(Species ~ ., data = iris)
  result_stats <- MASS::lda(Species ~ ., data = iris)

  expect_equal(result_pipe$means, result_stats$means)
})

test_that("lda.data.frame errors when formula is not a formula", {
  skip_if_not_installed("MASS")
  library(MASS)
  expect_error(iris |> lda("Species ~ ."), "'formula' must be a formula object")
})


test_that("qda.data.frame produces same result as MASS::qda", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- iris |> qda(Species ~ .)
  result_stats <- MASS::qda(Species ~ ., data = iris)

  expect_equal(result_pipe$means, result_stats$means)
})

test_that("qda.default still works for non-data.frame first argument", {
  skip_if_not_installed("MASS")
  library(MASS)

  result_pipe  <- qda(Species ~ ., data = iris)
  result_stats <- MASS::qda(Species ~ ., data = iris)

  expect_equal(result_pipe$means, result_stats$means)
})

test_that("qda.data.frame errors when formula is not a formula", {
  skip_if_not_installed("MASS")
  library(MASS)
  expect_error(iris |> qda("Species ~ ."), "'formula' must be a formula object")
})
