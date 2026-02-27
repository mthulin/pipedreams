test_that("nls.data.frame produces same result as stats::nls", {
  result_pipe <- Puromycin |>
    subset(state == "treated") |>
    nls(rate ~ Vm * conc / (K + conc), start = list(Vm = 200, K = 0.05))

  result_stats <- stats::nls(
    rate ~ Vm * conc / (K + conc),
    data  = subset(Puromycin, state == "treated"),
    start = list(Vm = 200, K = 0.05)
  )

  expect_equal(coef(result_pipe), coef(result_stats))
  expect_equal(fitted(result_pipe), fitted(result_stats))
})

test_that("nls.default still works for non-data.frame first argument", {
  result_pipe  <- nls(rate ~ Vm * conc / (K + conc),
                      data  = subset(Puromycin, state == "treated"),
                      start = list(Vm = 200, K = 0.05))
  result_stats <- stats::nls(rate ~ Vm * conc / (K + conc),
                              data  = subset(Puromycin, state == "treated"),
                              start = list(Vm = 200, K = 0.05))

  expect_equal(coef(result_pipe), coef(result_stats))
})

test_that("nls.data.frame errors when formula is not a formula", {
  expect_error(
    Puromycin |> nls("rate ~ Vm * conc / (K + conc)", start = list(Vm = 200, K = 0.05)),
    "'formula' must be a formula object"
  )
})
