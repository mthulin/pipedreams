#' pipedreams: Pipe-Friendly Wrappers for Common Statistical Tests and Models
#'
#' Provides `data.frame` S3 methods for a range of statistical functions so
#' that a data frame can be passed as the first argument via the base pipe
#' (`|>`) without needing the `data = _` placeholder.
#'
#' Covered functions:
#' - **stats**: `t.test`, `wilcox.test`, `lm`, `glm`, `aov`, `nls`
#' - **survival**: `survfit`, `coxph`, `survreg`
#' - **lme4**: `lmer`, `glmer`
#' - **MASS**: `glm.nb`, `polr`, `rlm`, `lda`, `qda`
#'
#' @section Usage:
#' ```r
#' library(pipedreams)
#'
#' # base stats
#' mtcars |> t.test(mpg ~ am)
#' mtcars |> wilcox.test(mpg ~ am)
#' mtcars |> lm(mpg ~ wt + cyl)
#' mtcars |> glm(am ~ mpg, family = binomial)
#' npk    |> aov(yield ~ block + N * P * K)
#' Puromycin |> subset(state == "treated") |>
#'   nls(rate ~ Vm * conc / (K + conc), start = list(Vm = 200, K = 0.05))
#'
#' # survival
#' survival::lung |> survfit(Surv(time, status) ~ sex)
#' survival::lung |> coxph(Surv(time, status) ~ age + sex)
#' survival::lung |> survreg(Surv(time, status) ~ age + sex, dist = "weibull")
#'
#' # lme4
#' lme4::sleepstudy |> lmer(Reaction ~ Days + (Days | Subject))
#' lme4::cbpp |> glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
#'               family = binomial)
#'
#' # MASS
#' MASS::quine   |> glm_nb(Days ~ Sex + Age + Eth)
#' MASS::housing |> polr(Sat ~ Infl + Type + Cont)
#' mtcars |> rlm(mpg ~ wt + cyl)
#' iris    |> lda(Species ~ .)
#' iris    |> qda(Species ~ .)
#' ```
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom stats t.test wilcox.test
## usethis namespace: end
NULL
