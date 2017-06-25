module Test.Main
  ( main
  ) where

import Control.Monad.Eff (Eff)
import Prelude
import Test.Data.Function.Sub as Data.Function.Sub
import Test.Spec.Reporter.Tap (tapReporter)
import Test.Spec.Runner (RunnerEffects, run)

main :: ∀ eff. Eff (RunnerEffects eff) Unit
main = run [tapReporter] do
  Data.Function.Sub.spec
